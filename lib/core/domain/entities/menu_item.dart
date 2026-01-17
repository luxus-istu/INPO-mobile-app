import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class MenuItem extends Equatable {
  final IconData icon;
  final String label;
  final String route;

  const MenuItem(
    this.icon,
    this.label,
    this.route,
  );

  @override
  List<Object?> get props => [
        this.icon,
        this.label,
        this.route,
      ];
}
