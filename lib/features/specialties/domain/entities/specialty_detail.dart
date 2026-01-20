import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class SpecialtyDetail extends Equatable {
  final IconData? icon;
  final String? title;
  final String? description;
  final String? seats;
  final String? duration;
  final List<String>? companies;
  final List<String>? disciplines;
  final List<String>? competencies; // Новое поле
  final String? code; // Новое поле
  final String? link;

  const SpecialtyDetail({
    this.icon,
    this.title,
    this.description,
    this.seats,
    this.duration,
    this.companies,
    this.disciplines,
    this.competencies,
    this.code,
    this.link,
  });

  @override
  List<Object?> get props => [
        this.icon,
        this.title,
        this.description,
        this.seats,
        this.duration,
        this.companies,
        this.disciplines,
        this.competencies,
        this.code,
        this.link,
      ];
}
