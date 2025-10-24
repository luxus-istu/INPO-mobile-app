import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData.light().copyWith(
      textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontFamily: "Nunito",
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w800),
    headlineMedium: TextStyle(
        fontFamily: "Nunito",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black),
    headlineSmall: TextStyle(
        fontFamily: "Nunito",
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.black),
  ));

  static ThemeData dark = ThemeData.dark().copyWith();
}
