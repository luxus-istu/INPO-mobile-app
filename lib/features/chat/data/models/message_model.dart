import 'package:hive_ce/hive_ce.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';

part 'message_model.g.dart';

@HiveType(typeId: 0)
final class MessageModel extends HiveObject {
  @HiveField(0)
  final String? text;
  @HiveField(1)
  final String? sender;
  @HiveField(2)
  final DateTime timestamp;

  MessageModel({
    this.text,
    this.sender,
    required this.timestamp,
  });

  MessageEntity toEntity() {
    return MessageEntity(
      text: this.text ?? "",
      sender: this.sender ?? "",
      timestamp: timestamp,
    );
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      text: entity.text,
      sender: entity.sender,
      timestamp: entity.timestamp,
    );
  }
}
