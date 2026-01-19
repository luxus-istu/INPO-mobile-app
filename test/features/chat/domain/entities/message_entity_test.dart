import 'package:flutter_test/flutter_test.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';

void main() {
  group('MessageEntity', () {
    test('should create MessageEntity with required fields', () {
      // Arrange
      const text = 'Hello, world!';
      const sender = 'user';
      final timestamp = DateTime.now();

      // Act
      final message = MessageEntity(
        text: text,
        sender: sender,
        timestamp: timestamp,
      );

      // Assert
      expect(message.text, text);
      expect(message.sender, sender);
      expect(message.timestamp, timestamp);
    });

    test('should convert to JSON correctly', () {
      // Arrange
      const text = 'Hello, world!';
      const sender = 'user';
      final timestamp = DateTime.now();
      final message = MessageEntity(
        text: text,
        sender: sender,
        timestamp: timestamp,
      );

      // Act
      final json = message.toJson();

      // Assert
      expect(json, {
        'role': sender,
        'content': text,
      });
      expect(json.length, 2);
    });

    test('should copyWith update fields correctly', () {
      // Arrange
      final originalMessage = MessageEntity(
        text: 'Original text',
        sender: 'user',
        timestamp: DateTime.now(),
      );

      // Act
      final copiedMessage = originalMessage.copyWith(
        text: 'New text',
        sender: 'ai',
      );

      // Assert
      expect(copiedMessage.text, 'New text');
      expect(copiedMessage.sender, 'ai');
      expect(copiedMessage.timestamp, originalMessage.timestamp);
      expect(copiedMessage, isNot(same(originalMessage)));
    });

    test('should support value equality', () {
      // Arrange
      final timestamp = DateTime.now();
      final message1 = MessageEntity(
        text: 'Hello',
        sender: 'user',
        timestamp: timestamp,
      );
      final message2 = MessageEntity(
        text: 'Hello',
        sender: 'user',
        timestamp: timestamp,
      );
      final message3 = MessageEntity(
        text: 'Hello',
        sender: 'ai',
        timestamp: timestamp,
      );

      // Assert
      expect(message1, equals(message2));
      expect(message1, isNot(equals(message3)));
    });

    test('should have correct props for Equatable', () {
      // Arrange
      final timestamp = DateTime.now();
      final message = MessageEntity(
        text: 'Hello',
        sender: 'user',
        timestamp: timestamp,
      );

      // Act
      final props = message.props;

      // Assert
      expect(
          props,
          containsAll([
            'Hello',
            'user',
            timestamp,
          ]));
      expect(props.length, 3);
    });
  });
}
