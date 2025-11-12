import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:inpo_mobile_app/features/chat/domain/usecases/send_message_use_case.dart';

part 'chat_bot_event.dart';
part 'chat_bot_state.dart';

@lazySingleton
final class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final GetMessagesUseCase _getMessages;
  final SendMessageUseCase _sendMessage;

  ChatBotBloc(this._getMessages, this._sendMessage)
      : super(const ChatBotInitial()) {
    on<ChatBotRequestEvent>(_onSendMessage);
    on<ChatBotLoadEvent>(_onLoadMessages);
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
    final List<MessageEntity> currentMessages =
        state is ChatBotLoaded ? (state as ChatBotLoaded).messages : [];

    final userMessage = MessageEntity(
      text: event.request,
      sender: 'user',
      timestamp: DateTime.now(),
    );

    final messagesWithUserInput = [...currentMessages, userMessage];

    emit(ChatBotProcessing(messagesWithUserInput));

    try {
      final result = await this._sendMessage(params: event.request);
      if (result is DataFailed) {
        return emit(ChatBotError(result.error!));
      }

      this.add(const ChatBotLoadEvent());
    } on Exception catch (e) {
      return emit(ChatBotError(e));
    }
  }
}
