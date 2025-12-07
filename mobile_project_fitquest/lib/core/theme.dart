import 'package:flutter/material.dart';

// Vibrant Colors
final Color primaryPurple = const Color(0xFF6A5AE0);
final Color lightPurple = const Color(0xFFEDE7FF);
final Color deepPurple = const Color(0xFF4B3ECF);
final Color softPink = const Color(0xFFF966FD);
final Color vibrantBlue = const Color(0xFF00D4FF);
final Color electricGreen = const Color(0xFF00FF94);
final Color sunnyYellow = const Color(0xFFFFD166);
final Color coralRed = const Color(0xFFFF6B6B);
final Color softWhite = const Color(0xFFF8F9FA);
final Color darkGray = const Color(0xFF2D3436);

final Gradient primaryGradient = LinearGradient(
  colors: [primaryPurple, softPink],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final Gradient blueGradient = LinearGradient(
  colors: [vibrantBlue, Color(0xFF0095FF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final Gradient greenGradient = LinearGradient(
  colors: [electricGreen, Color(0xFF00CC7A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final ThemeData fitQuestTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: softWhite,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryPurple,
    primary: primaryPurple,
    secondary: softPink,
    tertiary: vibrantBlue,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black87),
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: darkGray,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: darkGray,
    ),
    titleMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: darkGray,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: darkGray,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.grey[600],
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryPurple,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);