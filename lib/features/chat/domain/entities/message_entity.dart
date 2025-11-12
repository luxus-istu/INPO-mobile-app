class MessageEntity {
  final String text;
  final String sender;
  final DateTime timestamp;

  const MessageEntity({
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageEntity &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          sender == other.sender &&
          timestamp == other.timestamp;

  @override
  int get hashCode => text.hashCode ^ sender.hashCode ^ timestamp.hashCode;
}
