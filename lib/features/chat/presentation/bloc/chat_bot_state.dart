part of 'chat_bot_bloc.dart';

sealed class ChatBotState extends Equatable {
  const ChatBotState();

  @override
  List<Object> get props => [];
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
  List<Object> get props => [messages];
}

final class ChatBotProcessing extends ChatBotState {
  final List<MessageEntity> messages;
  final String accumulatedResponse;

  const ChatBotProcessing(
    this.messages, {
    this.accumulatedResponse = '',
  });

  ChatBotProcessing copyWith({
    List<MessageEntity>? messages,
    String? accumulatedResponse,
  }) {
    return ChatBotProcessing(
      messages ?? this.messages,
      accumulatedResponse: accumulatedResponse ?? this.accumulatedResponse,
    );
  }

  @override
  List<Object> get props => [messages, accumulatedResponse];
}

final class ChatBotError extends ChatBotState {
  final Exception error;

  const ChatBotError(this.error);

  @override
  List<Object> get props => [error];
}
