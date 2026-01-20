import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:inpo_mobile_app/features/news/presentation/widgets/news_card.dart';

void main() {
  group('NewsCard Widget Tests', () {
    final testNewsItem = NewsItem(
      title: 'Test News Title',
      date: '2024-01-01',
      imageUrl: 'https://example.com/image.jpg',
      link: 'https://example.com/news',
    );

    testWidgets('should display news card with correct content',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewsCard(
              newsItem: testNewsItem,
              isTablet: false,
              isDesktop: false,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Test News Title'), findsOneWidget);
      expect(find.text('2024-01-01'), findsOneWidget);
    });

    testWidgets('should have different sizes for different device types',
        (WidgetTester tester) async {
      // Test mobile size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewsCard(
              newsItem: testNewsItem,
              isTablet: false,
              isDesktop: false,
            ),
          ),
        ),
      );

      final titleText = tester.widget<Text>(find.text('Test News Title'));
      expect(titleText.style?.fontSize, 15.0);

      // Test tablet size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewsCard(
              newsItem: testNewsItem,
              isTablet: true,
              isDesktop: false,
            ),
          ),
        ),
      );

      final titleTextTablet = tester.widget<Text>(find.text('Test News Title'));
      expect(titleTextTablet.style?.fontSize, 16.0);

      // Test desktop size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewsCard(
              newsItem: testNewsItem,
              isTablet: false,
              isDesktop: true,
            ),
          ),
        ),
      );

      final titleTextDesktop =
          tester.widget<Text>(find.text('Test News Title'));
      expect(titleTextDesktop.style?.fontSize, 18.0);
    });

    testWidgets('should display correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewsCard(
              newsItem: testNewsItem,
              isTablet: false,
              isDesktop: false,
            ),
          ),
        ),
      );

      // Check title styling
      final titleText = tester.widget<Text>(find.text('Test News Title'));
      expect(titleText.style?.color, const Color(0xFF000080));
      expect(titleText.style?.fontWeight, FontWeight.w400);
      expect(titleText.style?.fontFamily, 'Onder');

      // Check date styling
      final dateText = tester.widget<Text>(find.text('2024-01-01'));
      expect(dateText.style?.color, const Color(0xFF8F8F8F));
      expect(dateText.style?.fontWeight, FontWeight.bold);
      expect(dateText.style?.fontFamily, 'SF Pro Display');
    });
  });
}
