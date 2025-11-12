import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.text,
    required super.sender,
    required super.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'],
      sender: json['sender'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sender': sender,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      text: entity.text,
      sender: entity.sender,
      timestamp: entity.timestamp,
    );
  }
}
