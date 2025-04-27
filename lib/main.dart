import 'package:attendance_flutter/core/theme/modern_theme.dart';
import 'package:attendance_flutter/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final user = FirebaseAuth.instance.currentUser;
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ModernTheme.light(),
      darkTheme: ModernTheme.dark(),
      initialRoute:
          user != null && user.emailVerified ? Routes.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
