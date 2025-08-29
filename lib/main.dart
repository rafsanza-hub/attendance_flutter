import 'package:attendance_flutter/app/bindings/initial_binding.dart';
import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/core/config/supabase_config.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.loadEnvIfNeeded();
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
    debug: false,
  );
  await Get.put<AuthService>(AuthService()).waitUntilUserLoaded();
  final session = Supabase.instance.client.auth.currentSession;
  AppLogger.instance.i('session: $session');
  runApp(
    GetMaterialApp(
      title: "Application",
      initialBinding: InitialBinding(),
      initialRoute: session != null ? Routes.MAIN : Routes.ONBOARDING,
      getPages: AppPages.routes,
    ),
  );
}
