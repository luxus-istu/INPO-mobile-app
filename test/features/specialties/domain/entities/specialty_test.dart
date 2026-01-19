import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';

void main() {
  group('Specialty', () {
    test('should create Specialty with all fields', () {
      // Arrange
      const code = '38.02.01';
      const title = 'Экономика и бухгалтерский учет';
      const formOfEducation = 'Среднее профессиональное образование';
      const link = 'https://example.com/specialty';
      final icon = Icons.school;

      // Act
      final specialty = Specialty(
        code: code,
        title: title,
        formOfEducation: formOfEducation,
        link: link,
        icon: icon,
      );

      // Assert
      expect(specialty.code, code);
      expect(specialty.title, title);
      expect(specialty.formOfEducation, formOfEducation);
      expect(specialty.link, link);
      expect(specialty.icon, icon);
    });

    test('should create Specialty with null fields', () {
      // Act
      final specialty = Specialty();

      // Assert
      expect(specialty.code, isNull);
      expect(specialty.title, isNull);
      expect(specialty.formOfEducation, isNull);
      expect(specialty.link, isNull);
      expect(specialty.icon, isNull);
    });

    test('should support value equality', () {
      // Arrange
      final specialty1 = Specialty(
        code: '38.02.01',
        title: 'Экономика',
      );
      final specialty2 = Specialty(
        code: '38.02.01',
        title: 'Экономика',
      );
      final specialty3 = Specialty(
        code: '38.02.02',
        title: 'Экономика',
      );

      // Assert
      expect(specialty1, equals(specialty2));
      expect(specialty1, isNot(equals(specialty3)));
    });

    test('should have correct props for Equatable', () {
      // Arrange
      final specialty = Specialty(
        code: '38.02.01',
        title: 'Экономика',
        formOfEducation: 'Среднее профессиональное образование',
        link: 'https://example.com',
        icon: Icons.school,
      );

      // Act
      final props = specialty.props;

      // Assert
      expect(
          props,
          containsAll([
            'Экономика',
            '38.02.01',
            'https://example.com',
            'Среднее профессиональное образование',
            Icons.school,
          ]));
      expect(props.length, 5);
    });
  });
}
