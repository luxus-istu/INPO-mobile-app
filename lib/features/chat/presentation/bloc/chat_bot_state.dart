part of 'chat_bot_bloc.dart';

sealed class ChatBotState extends Equatable {
  const ChatBotState();

  @override
  List<Object?> get props => [];
}

final class ChatBotInitial extends ChatBotState {
  const ChatBotInitial();
}

final class ChatBotLoading extends ChatBotState {
  const ChatBotLoading();
}

final class ChatBotLoaded extends ChatBotState {
  final List<MessageEntity> messages;
  const ChatBotLoaded(this.messages);

  @override
  List<Object?> get props => [this.messages];
}

final class ChatBotProcessing extends ChatBotState {
  final List<MessageEntity> messages;
  const ChatBotProcessing(this.messages);

  @override
  List<Object?> get props => [messages];
}

final class ChatBotError extends ChatBotState {
  final Exception exception;
  const ChatBotError(this.exception);

  @override
  List<Object?> get props => [this.exception];
}
