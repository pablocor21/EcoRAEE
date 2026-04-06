import 'package:flutter/material.dart';

class CicloxColors {
  static const Color primary = Color(0xFFB2F333); // Verde lima
  static const Color primaryLight = Color(0xFFE8F2D9); // Verde claro
  static const Color secondary = Color(0xFF6787AE); // Azul gris
  static const Color dark = Color(0xFF19133B); // Azul oscuro
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFE53935);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFF5F5F5);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: CicloxColors.white,
    colorScheme: ColorScheme.light(
      primary: CicloxColors.primary,
      secondary: CicloxColors.secondary,
      error: CicloxColors.error,
      surface: CicloxColors.white,
      onPrimary: CicloxColors.dark,
      onSecondary: CicloxColors.white,
      onSurface: CicloxColors.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: CicloxColors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: CicloxColors.dark),
      titleTextStyle: TextStyle(
        color: CicloxColors.dark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CicloxColors.primary,
        foregroundColor: CicloxColors.dark,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CicloxColors.greyLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CicloxColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CicloxColors.error),
      ),
      hintStyle: const TextStyle(color: CicloxColors.grey, fontSize: 14),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: CicloxColors.dark,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: CicloxColors.dark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: CicloxColors.dark, fontSize: 16),
      bodyMedium: TextStyle(color: CicloxColors.grey, fontSize: 14),
    ),
  );
}
