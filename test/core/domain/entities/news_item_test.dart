import 'package:flutter_test/flutter_test.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';

void main() {
  group('NewsItem', () {
    test('should create NewsItem with all fields', () {
      // Arrange
      const title = 'Test News Title';
      const date = '2024-01-01';
      const imageUrl = 'https://example.com/image.jpg';
      const link = 'https://example.com/news';

      // Act
      final newsItem = const NewsItem(
        title: title,
        date: date,
        imageUrl: imageUrl,
        link: link,
      );

      // Assert
      expect(newsItem.title, title);
      expect(newsItem.date, date);
      expect(newsItem.imageUrl, imageUrl);
      expect(newsItem.link, link);
    });

    test('should create NewsItem with null fields', () {
      // Act
      final newsItem = const NewsItem();

      // Assert
      expect(newsItem.title, isNull);
      expect(newsItem.date, isNull);
      expect(newsItem.imageUrl, isNull);
      expect(newsItem.link, isNull);
    });

    test('should support value equality', () {
      // Arrange
      final newsItem1 = const NewsItem(
        title: 'Title',
        date: '2024-01-01',
      );
      final newsItem2 = const NewsItem(
        title: 'Title',
        date: '2024-01-01',
      );
      final newsItem3 = const NewsItem(
        title: 'Different Title',
        date: '2024-01-01',
      );

      // Assert
      expect(newsItem1, equals(newsItem2));
      expect(newsItem1, isNot(equals(newsItem3)));
    });

    test('should have correct props for Equatable', () {
      // Arrange
      final newsItem = const NewsItem(
        title: 'Title',
        date: '2024-01-01',
        imageUrl: 'https://example.com/image.jpg',
        link: 'https://example.com/news',
      );

      // Act
      final props = newsItem.props;

      // Assert
      expect(
          props,
          containsAll([
            'Title',
            '2024-01-01',
            'https://example.com/image.jpg',
            'https://example.com/news',
          ]));
      expect(props.length, 4);
    });
  });
}
