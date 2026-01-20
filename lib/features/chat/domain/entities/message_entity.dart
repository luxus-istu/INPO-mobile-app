import 'package:equatable/equatable.dart';

final class MessageEntity extends Equatable {
  final String text;
  final String sender;
  final DateTime timestamp;

  const MessageEntity({
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "role": this.sender,
      "content": this.text,
    };
  }

  MessageEntity copyWith({String? text, String? sender}) {
    return MessageEntity(
      sender: sender ?? this.sender,
      text: text ?? this.text,
      timestamp: this.timestamp,
    );
  }

  @override
  List<Object?> get props => [this.text, this.sender, this.timestamp];
}
