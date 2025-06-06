import 'package:attendance_flutter/app/bindings/initial_binding.dart';
import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:attendance_flutter/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.put<AuthService>(AuthService()).waitUntilUserLoaded();
  final user = FirebaseAuth.instance.currentUser;
  AppLogger.instance.i('user : $user');
  runApp(
    GetMaterialApp(
      title: "Application",
      initialBinding: InitialBinding(),
      initialRoute: user != null ? Routes.MAIN : Routes.ONBOARDING,
      getPages: AppPages.routes,
    ),
  );
}
