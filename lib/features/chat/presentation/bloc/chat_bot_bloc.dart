import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/get_messages_use_case.dart';
import '../../domain/usecases/save_message_use_case.dart';
import '../../domain/usecases/send_message_use_case.dart';

part 'chat_bot_event.dart';
part 'chat_bot_state.dart';

@lazySingleton
class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final GetMessagesUseCase _getMessages;
  final SendMessageUseCase _sendMessage;
  final SaveMessageUseCase _saveMessage;

  ChatBotBloc(
    this._getMessages,
    this._sendMessage,
    this._saveMessage,
  ) : super(const ChatBotInitial()) {
    on<ChatBotLoadEvent>(_onLoadMessages);
    on<ChatBotSendMessageEvent>(_onSendMessage);
    on<ChatBotCancelStreamEvent>(_onCancelStream);
    on<ChatBotStreamError>(_onStreamError);
  }

  Future<void> _onLoadMessages(
    ChatBotLoadEvent event,
    Emitter<ChatBotState> emit,
  ) async {
    emit(const ChatBotLoading());

    final result = await _getMessages();

    if (result is DataSuccess) {
      emit(ChatBotLoaded(result.data!));
    } else {
      emit(ChatBotError(result.error!));
    }
  }

  Future<void> _onSendMessage(
    ChatBotSendMessageEvent event,
    Emitter<ChatBotState> emit,
  ) async {
    final currentMessages = switch (state) {
      ChatBotLoaded(messages: final msgs) => msgs,
      ChatBotProcessing(messages: final msgs) => msgs,
      _ => <MessageEntity>[],
    };

    final userMessage = MessageEntity(
      text: event.message.trim(),
      sender: 'user',
      timestamp: DateTime.now(),
    );

    final tempAiMessage = MessageEntity(
      text: '',
      sender: 'assistant',
      timestamp: DateTime.now(),
    );

    final updatedMessages = [...currentMessages, userMessage, tempAiMessage];

    emit(ChatBotProcessing(updatedMessages, isStreaming: true));

    final saveUserResult = await _saveMessage(params: userMessage);
    if (saveUserResult is DataFailed) {
      emit(ChatBotError(saveUserResult.error!));
      return;
    }

    String accumulated = '';

    await emit.forEach<DataState<String>>(
      _sendMessage(),
      onData: (dataState) {
        return dataState.when(
          success: (chunk) {
            accumulated += chunk;
            AppLogger.debug("data prishal $accumulated");

            final newMessages = List<MessageEntity>.from(updatedMessages)
              ..removeLast()
              ..add(tempAiMessage.copyWith(text: accumulated));

            return ChatBotProcessing(newMessages, isStreaming: true);
          },
          failure: (error) {
            AppLogger.error('AI Stream error: $error');
            return ChatBotError(Exception('Ошибка стрима: $error'));
          },
        );
      },
    );

    // Когда стрим завершён
    if (accumulated.isEmpty) {
      emit(ChatBotError(Exception('ИИ не ответил')));
      return;
    }

    final finalAiMessage = tempAiMessage.copyWith(text: accumulated);
    final saveAiResult = await _saveMessage(params: finalAiMessage);

    if (saveAiResult is DataSuccess) {
      // Переключаем флаг isStreaming → false
      emit(ChatBotProcessing(
        List.from(updatedMessages)
          ..removeLast()
          ..add(finalAiMessage),
        isStreaming: false,
      ));

      // Затем загружаем полную историю
      add(const ChatBotLoadEvent());
    } else {
      emit(ChatBotError(saveAiResult.error!));
    }
  }

  Future<void> _onCancelStream(
    ChatBotCancelStreamEvent event,
    Emitter<ChatBotState> emit,
  ) async {
    // Cancel logic if needed (e.g., cancel stream subscription)
    add(const ChatBotLoadEvent());
  }

  void _onStreamError(ChatBotStreamError event, Emitter<ChatBotState> emit) {
    final errorMsg = event.error.toString();

    String userMessage;
    if (errorMsg.contains('429') || errorMsg.contains('Too Many Requests')) {
      userMessage =
          'Слишком много запросов. Подождите минуту и попробуйте снова.';
    } else if (errorMsg.contains('timeout')) {
      userMessage = 'Превышено время ожидания ответа от ИИ.';
    } else {
      userMessage = 'Ошибка связи с ИИ: $errorMsg';
    }

    emit(ChatBotError(Exception(userMessage)));
  }
}
