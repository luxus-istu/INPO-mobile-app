import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/widgets/specialty_grid_item.dart';

void main() {
  group('SpecialtyGridItem Widget Tests', () {
    final testSpecialty = Specialty(
      code: '38.02.01',
      title: 'Экономика и бухгалтерский учет',
      icon: Icons.school,
      link: '/specialty/38.02.01',
    );

    testWidgets('should display specialty grid item with correct content',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpecialtyGridItem(
              specialty: testSpecialty,
              isTablet: false,
              isDesktop: false,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Экономика и бухгалтерский учет'), findsOneWidget);
      expect(find.byIcon(Icons.school), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('should have correct colors and styling',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpecialtyGridItem(
              specialty: testSpecialty,
              isTablet: false,
              isDesktop: false,
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.color, const Color(0xFF9FBAFF));

      final text =
          tester.widget<Text>(find.text('Экономика и бухгалтерский учет'));
      expect(text.style?.color, Colors.white);
      expect(text.style?.fontWeight, FontWeight.w600);
      expect(text.maxLines, 2);
      expect(text.textAlign, TextAlign.center);
    });

    testWidgets('should have different sizes for different device types',
        (WidgetTester tester) async {
      // Test mobile size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpecialtyGridItem(
              specialty: testSpecialty,
              isTablet: false,
              isDesktop: false,
            ),
          ),
        ),
      );

      final iconMobile = tester.widget<Icon>(find.byIcon(Icons.school));
      expect(iconMobile.size, 48.0);

      final textMobile =
          tester.widget<Text>(find.text('Экономика и бухгалтерский учет'));
      expect(textMobile.style?.fontSize, 16.0);

      // Test tablet size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpecialtyGridItem(
              specialty: testSpecialty,
              isTablet: true,
              isDesktop: false,
            ),
          ),
        ),
      );

      final iconTablet = tester.widget<Icon>(find.byIcon(Icons.school));
      expect(iconTablet.size, 56.0);

      final textTablet =
          tester.widget<Text>(find.text('Экономика и бухгалтерский учет'));
      expect(textTablet.style?.fontSize, 17.0);

      // Test desktop size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpecialtyGridItem(
              specialty: testSpecialty,
              isTablet: false,
              isDesktop: true,
            ),
          ),
        ),
      );

      final iconDesktop = tester.widget<Icon>(find.byIcon(Icons.school));
      expect(iconDesktop.size, 64.0);

      final textDesktop =
          tester.widget<Text>(find.text('Экономика и бухгалтерский учет'));
      expect(textDesktop.style?.fontSize, 18.0);
    });

    testWidgets('should handle long specialty names with ellipsis',
        (WidgetTester tester) async {
      // Arrange
      final longNameSpecialty = Specialty(
        code: '38.02.01',
        title:
            'Очень длинное название специальности которое должно быть обрезано с помощью многоточия',
        icon: Icons.school,
        link: '/specialty/38.02.01',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200, // Constrain width to force text overflow
              child: SpecialtyGridItem(
                specialty: longNameSpecialty,
                isTablet: false,
                isDesktop: false,
              ),
            ),
          ),
        ),
      );

      // Assert
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.maxLines, 2);
      expect(text.overflow, TextOverflow.ellipsis);
    });
  });
}
