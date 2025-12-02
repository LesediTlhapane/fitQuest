import 'package:flutter/material.dart';

final ThemeData fitQuestTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF0F4C81),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFF0F4C81),
    secondary: const Color(0xFFFFC107),
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    ),
  ),
);
