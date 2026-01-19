part of 'chat_bot_bloc.dart';

sealed class ChatBotState extends Equatable {
  const ChatBotState();

  @override
  List<Object?> get props => [];
}

class ChatBotInitial extends ChatBotState {
  const ChatBotInitial();
}

class ChatBotLoading extends ChatBotState {
  const ChatBotLoading();
}

class ChatBotLoaded extends ChatBotState {
  final List<MessageEntity> messages;

  const ChatBotLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatBotProcessing extends ChatBotState {
  final List<MessageEntity> messages;
  final bool isStreaming; // ← новый флаг

  const ChatBotProcessing(
    this.messages, {
    this.isStreaming = true,
  });

  @override
  List<Object?> get props => [messages, isStreaming];
}

class ChatBotError extends ChatBotState {
  final Exception error;

  const ChatBotError(this.error);

  @override
  List<Object?> get props => [error];
}
