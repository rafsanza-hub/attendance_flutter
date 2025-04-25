import 'package:flutter/material.dart';

class NotionTheme {
  // Warna untuk tema terang (Light Mode) - Terinspirasi Notion
  static const Color primaryLight = Color(0xFF2F3437);
  static const Color primaryVariantLight = Color(0xFF000000);
  static const Color secondaryLight = Color(0xFF2382FF);
  static const Color errorLight = Color(0xFFEB5757);

  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF7F6F3);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dividerLight = Color(0xFFEBEAE6);

  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF37352F);
  static const Color onSurfaceLight = Color(0xFF37352F);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF6B6B6B);

  // Warna untuk tema gelap (Dark Mode) - Terinspirasi Notion
  static const Color primaryDark = Color(0xFF2F3437);
  static const Color primaryVariantDark = Color(0xFF000000);
  static const Color secondaryDark = Color(0xFF2382FF);
  static const Color errorDark = Color(0xFFEB5757);

  static const Color backgroundDark = Color(0xFF191919);
  static const Color surfaceDark = Color(0xFF2F3437);
  static const Color cardDark = Color(0xFF2F3437);
  static const Color dividerDark = Color(0xFF373A3C);

  static const Color onPrimaryDark = Color(0xFFFFFFFF);
  static const Color onBackgroundDark = Color(0xFFE3E2E0);
  static const Color onSurfaceDark = Color(0xFFE3E2E0);
  static const Color onSecondaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF8F8F8F);

  // Font
  static const String fontFamily = 'Inter';

  // Light Theme
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryLight,
      colorScheme: const ColorScheme.light(
        primary: primaryLight,
        primaryContainer: primaryVariantLight,
        secondary: secondaryLight,
        error: errorLight,
        background: backgroundLight,
        surface: surfaceLight,
        onPrimary: onPrimaryLight,
        onBackground: onBackgroundLight,
        onSurface: onSurfaceLight,
        onSecondary: onSecondaryLight,
      ),
      scaffoldBackgroundColor: backgroundLight,
      fontFamily: fontFamily,

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundLight,
        foregroundColor: onBackgroundLight,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: onBackgroundLight,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        iconTheme: IconThemeData(color: onBackgroundLight),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: onPrimaryLight,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: secondaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLight,
          side: const BorderSide(color: dividerLight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // Text Field
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundLight,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: dividerLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: dividerLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: primaryLight, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: errorLight),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: errorLight, width: 1.5),
        ),
        hintStyle:
            TextStyle(color: onBackgroundLight.withOpacity(0.5), fontSize: 14),
        labelStyle: const TextStyle(color: textSecondaryLight, fontSize: 14),
        floatingLabelStyle: const TextStyle(color: primaryLight, fontSize: 12),
        errorStyle: const TextStyle(color: errorLight, fontSize: 12),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: const BorderSide(color: dividerLight),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: backgroundLight,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundLight,
        selectedItemColor: primaryLight,
        unselectedItemColor: textSecondaryLight,
        selectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        elevation: 2,
        type: BottomNavigationBarType.fixed,
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: secondaryLight,
        foregroundColor: onSecondaryLight,
        elevation: 2,
        shape: CircleBorder(),
      ),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(onPrimaryLight),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return secondaryLight;
          }
          return Colors.transparent;
        }),
        side: const BorderSide(color: textSecondaryLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return secondaryLight;
          }
          return Colors.grey.shade400;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return secondaryLight.withOpacity(0.5);
          }
          return Colors.grey.shade300;
        }),
      ),

      // Radio
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return secondaryLight;
          }
          return textSecondaryLight;
        }),
      ),

      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: secondaryLight,
        inactiveTrackColor: secondaryLight.withOpacity(0.2),
        thumbColor: secondaryLight,
        overlayColor: secondaryLight.withOpacity(0.1),
        valueIndicatorColor: secondaryLight,
      ),

      // TabBar
      tabBarTheme: const TabBarTheme(
        labelColor: primaryLight,
        unselectedLabelColor: textSecondaryLight,
        indicatorColor: primaryLight,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 14),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: dividerLight,
        thickness: 1,
        space: 1,
      ),

      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: primaryLight.withOpacity(0.9),
          borderRadius: BorderRadius.circular(3),
        ),
        textStyle: const TextStyle(color: onPrimaryLight, fontSize: 12),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: onBackgroundLight,
        ),
        displayMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: onBackgroundLight,
        ),
        displaySmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: onBackgroundLight,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: onBackgroundLight,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: onBackgroundLight,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: onBackgroundLight,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: onBackgroundLight,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onBackgroundLight,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textSecondaryLight,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: onBackgroundLight,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: onBackgroundLight,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondaryLight,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onBackgroundLight,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: onBackgroundLight,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textSecondaryLight,
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryDark,
        primaryContainer: primaryVariantDark,
        secondary: secondaryDark,
        error: errorDark,
        background: backgroundDark,
        surface: surfaceDark,
        onPrimary: onPrimaryDark,
        onBackground: onBackgroundDark,
        onSurface: onSurfaceDark,
        onSecondary: onSecondaryDark,
      ),
      scaffoldBackgroundColor: backgroundDark,
      fontFamily: fontFamily,

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark,
        foregroundColor: onBackgroundDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: onBackgroundDark,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        iconTheme: IconThemeData(color: onBackgroundDark),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDark,
          foregroundColor: onPrimaryDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: secondaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: onBackgroundDark,
          side: const BorderSide(color: dividerDark),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // Text Field
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: dividerDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: dividerDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: secondaryDark, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: errorDark),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: errorDark, width: 1.5),
        ),
        hintStyle:
            TextStyle(color: onBackgroundDark.withOpacity(0.5), fontSize: 14),
        labelStyle: const TextStyle(color: textSecondaryDark, fontSize: 14),
        floatingLabelStyle: const TextStyle(color: secondaryDark, fontSize: 12),
        errorStyle: const TextStyle(color: errorDark, fontSize: 12),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: const BorderSide(color: dividerDark),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: surfaceDark,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundDark,
        selectedItemColor: secondaryDark,
        unselectedItemColor: textSecondaryDark,
        selectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        elevation: 2,
        type: BottomNavigationBarType.fixed,
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: secondaryDark,
        foregroundColor: onSecondaryDark,
        elevation: 2,
        shape: CircleBorder(),
      ),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(onSecondaryDark),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return secondaryDark;
          }
          return Colors.transparent;
        }),
        side: const BorderSide(color: textSecondaryDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return secondaryDark;
          }
          return Colors.grey.shade600;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return secondaryDark.withOpacity(0.5);
          }
          return Colors.grey.shade800;
        }),
      ),

      // Radio
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return secondaryDark;
          }
          return textSecondaryDark;
        }),
      ),

      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: secondaryDark,
        inactiveTrackColor: secondaryDark.withOpacity(0.2),
        thumbColor: secondaryDark,
        overlayColor: secondaryDark.withOpacity(0.1),
        valueIndicatorColor: secondaryDark,
      ),

      // TabBar
      tabBarTheme: const TabBarTheme(
        labelColor: onBackgroundDark,
        unselectedLabelColor: textSecondaryDark,
        indicatorColor: secondaryDark,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 14),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: dividerDark,
        thickness: 1,
        space: 1,
      ),

      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surfaceDark.withOpacity(0.9),
          borderRadius: BorderRadius.circular(3),
        ),
        textStyle: const TextStyle(color: onSurfaceDark, fontSize: 12),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: onBackgroundDark,
        ),
        displayMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: onBackgroundDark,
        ),
        displaySmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: onBackgroundDark,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: onBackgroundDark,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: onBackgroundDark,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: onBackgroundDark,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: onBackgroundDark,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onBackgroundDark,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textSecondaryDark,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: onBackgroundDark,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: onBackgroundDark,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondaryDark,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onBackgroundDark,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: onBackgroundDark,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textSecondaryDark,
        ),
      ),
    );
  }

  // Contoh halaman untuk demonstrasi tema
  static Widget buildThemeShowcase() {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notion Theme'),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notion Style Theme',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Clean and minimalist design',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Divider(height: 32),

                Text(
                  'Typography',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Text('Heading 1',
                    style: Theme.of(context).textTheme.displaySmall),
                Text('Heading 2',
                    style: Theme.of(context).textTheme.headlineLarge),
                Text('Heading 3',
                    style: Theme.of(context).textTheme.headlineMedium),
                Text('Normal text',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('Small text',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 24),

                Text(
                  'Buttons',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Primary'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Secondary'),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Text'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Text(
                  'Input Fields',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter title',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter description',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter email',
                    errorText: 'Invalid email format',
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Cards',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Project Note',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This is a sample note similar to what you might create in Notion. It includes some details about a project.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'April 25, 2025',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.person_outline, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'John Doe',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Selection Controls',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                // Checkbox
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Task 1: Complete design'),
                  leading: Checkbox(
                    value: true,
                    onChanged: (_) {},
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Task 2: Implement theme'),
                  leading: Checkbox(
                    value: false,
                    onChanged: (_) {},
                  ),
                ),

                // Switch
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dark Mode'),
                  trailing: Switch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (_) {},
                  ),
                ),

                // Radio
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Priority: High'),
                  leading: Radio<int>(
                    value: 1,
                    groupValue: 1,
                    onChanged: (_) {},
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Priority: Medium'),
                  leading: Radio<int>(
                    value: 2,
                    groupValue: 1,
                    onChanged: (_) {},
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Slider',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('0%'),
                    Expanded(
                      child: Slider(
                        value: 0.7,
                        onChanged: (_) {},
                      ),
                    ),
                    const Text('100%'),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outlined),
                activeIcon: Icon(Icons.bookmark),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: 0,
            onTap: (_) {},
          ),
        );
      },
    );
  }
}
