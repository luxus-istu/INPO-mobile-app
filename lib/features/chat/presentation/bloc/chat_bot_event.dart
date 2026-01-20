part of 'chat_bot_bloc.dart';

sealed class ChatBotEvent extends Equatable {
  const ChatBotEvent();

  @override
  List<Object?> get props => [];
}

class ChatBotLoadEvent extends ChatBotEvent {
  const ChatBotLoadEvent();
}

class ChatBotSendMessageEvent extends ChatBotEvent {
  final String message;

  const ChatBotSendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatBotCancelStreamEvent extends ChatBotEvent {
  const ChatBotCancelStreamEvent();
}

class ChatBotStreamError extends ChatBotEvent {
  final Exception error;

  const ChatBotStreamError(this.error);

  @override
  List<Object?> get props => [error];
}
