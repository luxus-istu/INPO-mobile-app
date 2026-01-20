import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

final class Specialty extends Equatable {
  final String? code; // Код специальности, например "38.02.01"
  final String? title; // Название, например "Экономика и бухгалтерский учет"
  final String?
      formOfEducation; // Форма, например "Среднее профессиональное образование"
  final String? link;
  final IconData? icon;

  const Specialty(
      {this.icon, this.title, this.code, this.link, this.formOfEducation});

  @override
  List<Object?> get props => [title, code, link, formOfEducation, icon];
}
