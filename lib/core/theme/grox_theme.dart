import 'package:flutter/material.dart';

class GroxTheme {
  // Warna untuk mode terang
  static const _lightPrimaryColor = Color(0xFF1976D2); // Biru profesional
  static const _lightPrimaryVariant = Color(0xFF1565C0);
  static const _lightSecondaryColor = Color(0xFF26A69A); // Teal modern
  static const _lightBackgroundColor = Color(0xFFF5F5F5);
  static const _lightSurfaceColor = Colors.white;
  static const _lightTextColor = Color(0xFF212121);
  static const _lightTextSecondaryColor = Color(0xFF757575);

  // Warna untuk mode gelap
  static const _darkPrimaryColor = Color(0xFF42A5F5); // Biru lebih cerah
  static const _darkPrimaryVariant = Color(0xFF1976D2);
  static const _darkSecondaryColor = Color(0xFF4DB6AC); // Teal gelap
  static const _darkBackgroundColor = Color(0xFF121212);
  static const _darkSurfaceColor = Color(0xFF1E1E1E);
  static const _darkTextColor = Color(0xFFE0E0E0);
  static const _darkTextSecondaryColor = Color(0xFFB0B0B0);

  // Tema terang
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _lightPrimaryColor,
      primaryColorDark: _lightPrimaryVariant,
      scaffoldBackgroundColor: _lightBackgroundColor,
      colorScheme: const ColorScheme.light(
        primary: _lightPrimaryColor,
        secondary: _lightSecondaryColor,
        surface: _lightSurfaceColor,
        background: _lightBackgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: _lightTextColor,
        onBackground: _lightTextColor,
      ),
      // Konfigurasi ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _lightPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Konfigurasi TextFormField
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _lightPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        labelStyle: const TextStyle(color: _lightTextSecondaryColor),
        hintStyle: const TextStyle(color: _lightTextSecondaryColor),
      ),
      // Konfigurasi Card
      cardTheme: CardTheme(
        color: _lightSurfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      // Konfigurasi AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      // Konfigurasi Text
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: _lightTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _lightTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: _lightTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: _lightTextSecondaryColor,
        ),
      ),
      // Konfigurasi Icon
      iconTheme: const IconThemeData(
        color: _lightTextColor,
        size: 24,
      ),
      // Konfigurasi FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _lightSecondaryColor,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }

  // Tema gelap
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _darkPrimaryColor,
      primaryColorDark: _darkPrimaryVariant,
      scaffoldBackgroundColor: _darkBackgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondary: _darkSecondaryColor,
        surface: _darkSurfaceColor,
        background: _darkBackgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: _darkTextColor,
        onBackground: _darkTextColor,
      ),
      // Konfigurasi ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _darkPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Konfigurasi TextFormField
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurfaceColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _darkPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        labelStyle: const TextStyle(color: _darkTextSecondaryColor),
        hintStyle: const TextStyle(color: _darkTextSecondaryColor),
      ),
      // Konfigurasi Card
      cardTheme: CardTheme(
        color: _darkSurfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      // Konfigurasi AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      // Konfigurasi Text
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: _darkTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _darkTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: _darkTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: _darkTextSecondaryColor,
        ),
      ),
      // Konfigurasi Icon
      iconTheme: const IconThemeData(
        color: _darkTextColor,
        size: 24,
      ),
      // Konfigurasi FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _darkSecondaryColor,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }
}
