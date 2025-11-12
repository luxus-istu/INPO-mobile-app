part of 'chat_bot_bloc.dart';

sealed class ChatBotEvent extends Equatable {
  const ChatBotEvent();

  @override
  List<Object?> get props => [];
}

final class ChatBotRequestEvent extends ChatBotEvent {
  final String request;
  const ChatBotRequestEvent(this.request);

  @override
  List<Object?> get props => [this.request];
}

final class ChatBotLoadEvent extends ChatBotEvent {
  const ChatBotLoadEvent();
}
