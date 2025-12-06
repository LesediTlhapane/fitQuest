import 'package:flutter/material.dart';

final Color primaryPurple = const Color(0xFF6A5AE0);
final Color lightPurple = const Color(0xFFEDE7FF);
final Color deepPurple = const Color(0xFF4B3ECF);
final Color softPink = const Color.fromARGB(255, 73, 107, 220);

final ThemeData fitQuestTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: softPink,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryPurple,
    primary: primaryPurple,
    secondary: deepPurple,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
  ),
);
