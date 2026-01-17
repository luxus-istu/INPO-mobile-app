import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/utils/logger.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:inpo_mobile_app/features/chat/domain/usecases/save_message_use_case.dart';
import 'package:inpo_mobile_app/features/chat/domain/usecases/send_message_use_case.dart';

part 'chat_bot_event.dart';
part 'chat_bot_state.dart';

@lazySingleton
final class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final GetMessagesUseCase _getMessages;
  final SendMessageUseCase _sendMessage;
  final SaveMessageUseCase _saveMessage;
  StreamSubscription<DataState<String>>? _responseSubscription;

  // Для накопления потокового ответа
  String _accumulatedResponse = '';
  late MessageEntity _currentAiMessage;
  late MessageEntity _userMessage;

  // Для отслеживания ограничения скорости
  DateTime? _lastRateLimitError;

  ChatBotBloc(this._getMessages, this._sendMessage, this._saveMessage)
      : super(const ChatBotInitial()) {
    on<ChatBotRequestEvent>(_onSendMessage);
    on<ChatBotLoadEvent>(_onLoadMessages);
    on<ChatBotCancelStreamEvent>(_onCancelStream);

    on<_ChatBotStreamUpdated>(_onStreamUpdated);
    on<_ChatBotStreamError>(_onStreamError);
    on<_ChatBotStreamCompleted>(_onStreamCompleted);
  }

  @override
  Future<void> close() {
    _cancelCurrentStream();
    return super.close();
  }

  Future<void> _onLoadMessages(
      ChatBotLoadEvent event, Emitter<ChatBotState> emit) async {
    emit(const ChatBotLoading());
    try {
      final messages = await this._getMessages();
      if (messages is DataFailed) {
        return emit(ChatBotError(messages.error!));
      }
      return emit(ChatBotLoaded(messages.data!));
    } on Exception catch (e) {
      return emit(ChatBotError(e));
    }
  }

  Future<void> _onSendMessage(
      ChatBotRequestEvent event, Emitter<ChatBotState> emit) async {
    await _cancelCurrentStream();

    // Check for recent rate limit errors to prevent immediate retries
    if (_lastRateLimitError != null) {
      final timeSinceLastError =
          DateTime.now().difference(_lastRateLimitError!);
      if (timeSinceLastError < const Duration(minutes: 1)) {
        emit(ChatBotError(Exception(
            'Слишком много запросов. Пожалуйста, подождите ${(60 - timeSinceLastError.inSeconds)} секунд перед повторной попыткой.')));
        return;
      }
    }

    final List<MessageEntity> currentMessages = switch (state) {
      ChatBotLoaded(messages: final msgs) => msgs,
      ChatBotProcessing(messages: final msgs) => msgs,
      _ => <MessageEntity>[],
    };

    // Создаем сообщение пользователя
    _userMessage = MessageEntity(
      text: event.request,
      sender: 'user',
      timestamp: DateTime.now(),
    );

    // Создаем пустое сообщение для AI (будем обновлять по мере получения чанков)
    _currentAiMessage = MessageEntity(
      text: '',
      sender: 'ai',
      timestamp: DateTime.now(),
    );

    final messagesWithStreaming = [
      ...currentMessages,
      _userMessage,
      _currentAiMessage
    ];

    // Начинаем потоковую обработку
    emit(ChatBotProcessing(messagesWithStreaming));

    // Сначала сохраняем сообщение пользователя
    final saveUserResult = await _saveMessage(params: _userMessage);
    if (saveUserResult is DataFailed) {
      emit(ChatBotError(saveUserResult.error!));
      return;
    }

    // Запускаем потоковый запрос
    _responseSubscription = _sendMessage().listen(
      (dataState) {
        _handleStreamResponse(dataState);
      },
      onError: (error) {
        AppLogger.error('Stream error: ${error.toString()}');
        add(_ChatBotStreamError(Exception(error.toString())));
      },
      onDone: () {
        add(_ChatBotStreamCompleted());
      },
      cancelOnError: true,
    );
  }

  void _onCancelStream(
      ChatBotCancelStreamEvent event, Emitter<ChatBotState> emit) async {
    await _cancelCurrentStream();
    // После отмены загружаем актуальные сообщения
    add(const ChatBotLoadEvent());
  }

  void _handleStreamResponse(DataState<String> dataState) {
    dataState.when(
      success: (chunk) {
        _accumulatedResponse += chunk;

        // Обновляем текущее сообщение AI
        _currentAiMessage = _currentAiMessage.copyWith(
          text: _accumulatedResponse,
        );

        // Обновляем состояние с новым чанком
        final currentState = state;
        if (currentState is ChatBotProcessing) {
          final updatedMessages =
              List<MessageEntity>.from(currentState.messages);

          // Заменяем последнее сообщение (которое от AI) обновленной версией
          if (updatedMessages.isNotEmpty &&
              updatedMessages.last.sender == 'ai') {
            updatedMessages[updatedMessages.length - 1] = _currentAiMessage;
          }

          // Добавляем внутреннее событие для обновления состояния
          add(_ChatBotStreamUpdated(updatedMessages, _accumulatedResponse));
        }
      },
      failure: (error) {
        // Передаем ошибку через событие
        AppLogger.error('Stream failure: $error');
        add(_ChatBotStreamError(error));
      },
    );
  }

  Future<void> _cancelCurrentStream() async {
    _accumulatedResponse = '';
    await _responseSubscription?.cancel();
    _responseSubscription = null;
  }

  // Внутренние обработчики для событий из потока
  void _onStreamUpdated(
      _ChatBotStreamUpdated event, Emitter<ChatBotState> emit) {
    emit(ChatBotProcessing(
      event.messages,
      accumulatedResponse: event.accumulatedResponse,
    ));
  }

  Future<void> _onStreamError(
      _ChatBotStreamError event, Emitter<ChatBotState> emit) async {
    AppLogger.error('Stream error handled: ${event.error}');
    await _cancelCurrentStream();

    // Track rate limit errors
    if (event.error.toString().contains('429') ||
        event.error.toString().contains('Too Many Requests') ||
        event.error.toString().contains('Rate limit exceeded')) {
      _lastRateLimitError = DateTime.now();
    }

    emit(ChatBotError(event.error));
  }

  Future<void> _onStreamCompleted(
      _ChatBotStreamCompleted event, Emitter<ChatBotState> emit) async {
    try {
      // Проверяем, что накопился какой-то ответ
      if (_accumulatedResponse.isEmpty) {
        emit(ChatBotError(Exception(
            'Пустой ответ от ИИ. Попробуйте отправить сообщение снова.')));
        return;
      }

      // Сохраняем финальное сообщение AI
      final finalAiMessage = _currentAiMessage.copyWith(
        text: _accumulatedResponse,
      );

      final saveAiResult = await _saveMessage(params: finalAiMessage);

      if (saveAiResult is DataFailed) {
        emit(ChatBotError(saveAiResult.error!));
        return;
      }

      // После сохранения загружаем обновленные сообщения
      add(const ChatBotLoadEvent());
    } on Exception catch (e) {
      AppLogger.error('Stream completion error: ${e.toString()}');
      emit(
          ChatBotError(Exception('Ошибка сохранения ответа: ${e.toString()}')));
    }
  }
}

class _ChatBotStreamUpdated extends ChatBotEvent {
  final List<MessageEntity> messages;
  final String accumulatedResponse;

  const _ChatBotStreamUpdated(this.messages, this.accumulatedResponse);

  @override
  List<Object> get props => [messages, accumulatedResponse];
}

class _ChatBotStreamError extends ChatBotEvent {
  final Exception error;

  const _ChatBotStreamError(this.error);

  @override
  List<Object> get props => [error];
}

class _ChatBotStreamCompleted extends ChatBotEvent {
  const _ChatBotStreamCompleted();
}
