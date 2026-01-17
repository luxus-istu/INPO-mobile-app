part of 'chat_bot_bloc.dart';

sealed class ChatBotEvent extends Equatable {
  const ChatBotEvent();

  @override
  List<Object> get props => [];
}

final class ChatBotLoadEvent extends ChatBotEvent {
  const ChatBotLoadEvent();
}

final class ChatBotRequestEvent extends ChatBotEvent {
  final String request;

  const ChatBotRequestEvent(this.request);

  @override
  List<Object> get props => [request];
}

final class ChatBotCancelStreamEvent extends ChatBotEvent {
  const ChatBotCancelStreamEvent();
}
