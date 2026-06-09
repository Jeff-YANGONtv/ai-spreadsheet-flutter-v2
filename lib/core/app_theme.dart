import 'package:flutter/material.dart';

class AppTheme {
  static const Color scaffoldBackground = Color(0xFF0A0E27);
  static const Color cardBackground = Color(0xFF1A1F3A);
  static const Color inputBackground = Color(0xFF2A2F4A);
  static const Color accentColor = Colors.cyan;

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: accentColor,
    scaffoldBackgroundColor: scaffoldBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: cardBackground,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor: cardBackground,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: accentColor.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: accentColor.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
      hintStyle: TextStyle(color: Colors.grey[400]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
      ),
    ),
  );
}
