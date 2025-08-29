import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:attendance_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final currentUser = Rxn<dynamic>();

  login() async {
    isLoading.value = true;
    if (!formKey.currentState!.validate()) return;
    try {
      AppLogger.instance.d('email: ${emailC.text}');
      await _authService.signIn(emailC.text, passwordC.text);
      AppLogger.instance.d('email: ${emailC.text}');
      // Jika superadmin
      if (_authService.isSuperAdmin()) {
        Get.offNamed('/tenant');

        // Jika admin
      } else if (_authService.isAdmin()) {
        final tenantId = _authService.getTenantId();
        AppLogger.instance.d('tenantId: $tenantId');
        if (tenantId != null) {
          Get.offNamed('/main');
        } else {
          await _authService.signOut();
          Get.snackbar(
              'Error', 'Belum terdaftar, Mohon hubungi layanan bantuan.');
        }
      } else {
        final tenantId = _authService.getTenantId();
        AppLogger.instance.d('tenantId: $tenantId');

        if (tenantId != null) {
          Get.offNamed('/main');
        } else {
          await _authService.signOut();
          Get.snackbar(
              'Error', 'Belum terdaftar, Mohon hubungi layanan bantuan .');
        }
      }
    } catch (e) {
      AppLogger.instance.e('Error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      Get.offAllNamed(Routes.ONBOARDING);
      await _authService.signOut();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password harus lebih dari 6 karakter';
    }
    return null;
  }
}
