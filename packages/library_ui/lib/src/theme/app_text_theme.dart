import 'package:flutter/material.dart';

abstract final class AppTextTheme {
  static const String display = 'Literata';
  static const String figtree = 'Figtree';
  static const String package = 'library_ui';

  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: display,
      package: package,
      fontSize: 30,
      height: 36 / 30,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      fontFamily: display,
      package: package,
      fontSize: 26,
      height: 32 / 26,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontFamily: display,
      package: package,
      fontSize: 22,
      height: 28 / 22,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      fontFamily: figtree,
      package: package,
      fontSize: 18,
      height: 24 / 18,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontFamily: display,
      package: package,
      fontSize: 16,
      height: 20 / 16,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      fontFamily: figtree,
      package: package,
      fontSize: 15,
      height: 20 / 15,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontFamily: figtree,
      package: package,
      fontSize: 15,
      height: 24 / 15,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: figtree,
      package: package,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: figtree,
      package: package,
      fontSize: 13,
      height: 18 / 13,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontFamily: figtree,
      package: package,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w500,
    ),
  );
}
