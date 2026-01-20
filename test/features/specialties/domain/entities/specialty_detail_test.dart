import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty_detail.dart';

void main() {
  group('SpecialtyDetail', () {
    test('should create SpecialtyDetail with all fields', () {
      // Arrange
      final icon = Icons.school;
      const title = 'Экономика и бухгалтерский учет';
      const description = 'Описание специальности';
      const seats = '50';
      const duration = '2 года 10 месяцев';
      final companies = ['Company A', 'Company B'];
      final disciplines = ['Discipline 1', 'Discipline 2'];
      final competencies = ['Competency 1', 'Competency 2'];
      const code = '38.02.01';
      const link = 'https://example.com/specialty';

      // Act
      final specialtyDetail = SpecialtyDetail(
        icon: icon,
        title: title,
        description: description,
        seats: seats,
        duration: duration,
        companies: companies,
        disciplines: disciplines,
        competencies: competencies,
        code: code,
        link: link,
      );

      // Assert
      expect(specialtyDetail.icon, icon);
      expect(specialtyDetail.title, title);
      expect(specialtyDetail.description, description);
      expect(specialtyDetail.seats, seats);
      expect(specialtyDetail.duration, duration);
      expect(specialtyDetail.companies, companies);
      expect(specialtyDetail.disciplines, disciplines);
      expect(specialtyDetail.competencies, competencies);
      expect(specialtyDetail.code, code);
      expect(specialtyDetail.link, link);
    });

    test('should create SpecialtyDetail with null fields', () {
      // Act
      final specialtyDetail = SpecialtyDetail();

      // Assert
      expect(specialtyDetail.icon, isNull);
      expect(specialtyDetail.title, isNull);
      expect(specialtyDetail.description, isNull);
      expect(specialtyDetail.seats, isNull);
      expect(specialtyDetail.duration, isNull);
      expect(specialtyDetail.companies, isNull);
      expect(specialtyDetail.disciplines, isNull);
      expect(specialtyDetail.competencies, isNull);
      expect(specialtyDetail.code, isNull);
      expect(specialtyDetail.link, isNull);
    });

    test('should support value equality', () {
      // Arrange
      final detail1 = SpecialtyDetail(
        title: 'Title',
        code: '38.02.01',
      );
      final detail2 = SpecialtyDetail(
        title: 'Title',
        code: '38.02.01',
      );
      final detail3 = SpecialtyDetail(
        title: 'Different Title',
        code: '38.02.01',
      );

      // Assert
      expect(detail1, equals(detail2));
      expect(detail1, isNot(equals(detail3)));
    });

    test('should have correct props for Equatable', () {
      // Arrange
      final detail = SpecialtyDetail(
        icon: Icons.school,
        title: 'Title',
        description: 'Description',
        seats: '50',
        duration: '2 years',
        companies: ['Company A'],
        disciplines: ['Discipline 1'],
        competencies: ['Competency 1'],
        code: '38.02.01',
        link: 'https://example.com',
      );

      // Act
      final props = detail.props;

      // Assert
      expect(
          props,
          containsAll([
            Icons.school,
            'Title',
            'Description',
            '50',
            '2 years',
            ['Company A'],
            ['Discipline 1'],
            ['Competency 1'],
            '38.02.01',
            'https://example.com',
          ]));
      expect(props.length, 10);
    });
  });
}
