import 'package:flutter/material.dart';

class AppTheme {
  // Warna primer dan aksen untuk tema terang dan gelap
  static const Color primaryLight = Color(0xFF6200EE);
  static const Color primaryDarkLight = Color(0xFF3700B3);
  static const Color secondaryLight = Color(0xFF03DAC6);
  static const Color errorLight = Color(0xFFB00020);
  
  static const Color primaryDark = Color(0xFFBB86FC);
  static const Color primaryDarkDark = Color(0xFF9E68F9);
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color errorDark = Color(0xFFCF6679);

  // Warna latar belakang dan permukaan
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Colors.white;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Warna teks
  static const Color onPrimaryLight = Colors.white;
  static const Color onBackgroundLight = Color(0xFF121212);
  static const Color onSurfaceLight = Color(0xFF121212);
  
  static const Color onPrimaryDark = Color(0xFF121212);
  static const Color onBackgroundDark = Colors.white;
  static const Color onSurfaceDark = Colors.white;

  // Font
  static const String fontFamily = 'Roboto';

  // Theme Data untuk Mode Terang
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryLight,
      colorScheme: const ColorScheme.light(
        primary: primaryLight,
        primaryContainer: primaryDarkLight,
        secondary: secondaryLight,
        error: errorLight,
        background: backgroundLight,
        surface: surfaceLight,
        onPrimary: onPrimaryLight,
        onBackground: onBackgroundLight,
        onSurface: onSurfaceLight,
      ),
      scaffoldBackgroundColor: backgroundLight,
      fontFamily: fontFamily,
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryLight,
        foregroundColor: onPrimaryLight,
        elevation: 2,
        centerTitle: true,
      ),
      
      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: onPrimaryLight,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ),
      
      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLight,
          side: const BorderSide(color: primaryLight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surfaceLight,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: onSurfaceLight.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: onSurfaceLight.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorLight, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorLight, width: 2),
        ),
        hintStyle: TextStyle(color: onSurfaceLight.withOpacity(0.6)),
        errorStyle: const TextStyle(color: errorLight, fontSize: 12),
        labelStyle: TextStyle(color: onSurfaceLight.withOpacity(0.8)),
        floatingLabelStyle: const TextStyle(color: primaryLight),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        color: surfaceLight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),
      
      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: surfaceLight,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceLight,
        selectedItemColor: primaryLight,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
        foregroundColor: onPrimaryLight,
        elevation: 6,
        shape: CircleBorder(),
      ),
      
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(onPrimaryLight),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryLight;
          }
          return Colors.transparent;
        }),
        side: BorderSide(color: onSurfaceLight.withOpacity(0.6)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryLight;
          }
          return Colors.grey.shade400;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryLight.withOpacity(0.5);
          }
          return Colors.grey.shade300;
        }),
      ),
      
      // Radio
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryLight;
          }
          return onSurfaceLight.withOpacity(0.6);
        }),
      ),
      
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryLight,
        inactiveTrackColor: primaryLight.withOpacity(0.3),
        thumbColor: primaryLight,
        overlayColor: primaryLight.withOpacity(0.2),
        valueIndicatorColor: primaryDarkLight,
      ),
      
      // TabBar
      tabBarTheme: TabBarTheme(
        labelColor: primaryLight,
        unselectedLabelColor: onSurfaceLight.withOpacity(0.7),
        indicatorColor: primaryLight,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
      ),
      
      // Divider
      dividerTheme: DividerThemeData(
        color: onSurfaceLight.withOpacity(0.15),
        thickness: 1,
        space: 1,
      ),
      
      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: onSurfaceLight.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: const TextStyle(color: surfaceLight),
      ),
    );
  }

  // Theme Data untuk Mode Gelap
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryDark,
        primaryContainer: primaryDarkDark,
        secondary: secondaryDark,
        error: errorDark,
        background: backgroundDark,
        surface: surfaceDark,
        onPrimary: onPrimaryDark,
        onBackground: onBackgroundDark,
        onSurface: onSurfaceDark,
      ),
      scaffoldBackgroundColor: backgroundDark,
      fontFamily: fontFamily,
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceDark,
        foregroundColor: onSurfaceDark,
        elevation: 0,
        centerTitle: true,
      ),
      
      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDark,
          foregroundColor: onPrimaryDark,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ),
      
      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDark,
          side: const BorderSide(color: primaryDark),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surfaceDark,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: onSurfaceDark.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: onSurfaceDark.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorDark, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorDark, width: 2),
        ),
        hintStyle: TextStyle(color: onSurfaceDark.withOpacity(0.6)),
        errorStyle: const TextStyle(color: errorDark, fontSize: 12),
        labelStyle: TextStyle(color: onSurfaceDark.withOpacity(0.8)),
        floatingLabelStyle: const TextStyle(color: primaryDark),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        color: surfaceDark,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),
      
      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: surfaceDark,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceDark,
        selectedItemColor: primaryDark,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryDark,
        foregroundColor: onPrimaryDark,
        elevation: 6,
        shape: CircleBorder(),
      ),
      
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(onPrimaryDark),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryDark;
          }
          return Colors.transparent;
        }),
        side: BorderSide(color: onSurfaceDark.withOpacity(0.6)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryDark;
          }
          return Colors.grey.shade600;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryDark.withOpacity(0.5);
          }
          return Colors.grey.shade800;
        }),
      ),
      
      // Radio
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryDark;
          }
          return onSurfaceDark.withOpacity(0.6);
        }),
      ),
      
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryDark,
        inactiveTrackColor: primaryDark.withOpacity(0.3),
        thumbColor: primaryDark,
        overlayColor: primaryDark.withOpacity(0.2),
        valueIndicatorColor: primaryDarkDark,
      ),
      
      // TabBar
      tabBarTheme: TabBarTheme(
        labelColor: primaryDark,
        unselectedLabelColor: onSurfaceDark.withOpacity(0.7),
        indicatorColor: primaryDark,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
      ),
      
      // Divider
      dividerTheme: DividerThemeData(
        color: onSurfaceDark.withOpacity(0.2),
        thickness: 1,
        space: 1,
      ),
      
      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: onSurfaceDark.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: const TextStyle(color: surfaceDark),
      ),
    );
  }
}

// Contoh penggunaan:
