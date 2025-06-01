import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:attendance_flutter/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find();
  final tenantService = Get.find();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser.obs;

  login() async {
    isLoading.value = true;
    if (!formKey.currentState!.validate()) return;
    try {
      await _authService.signIn(emailC.text, passwordC.text);
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
        if (tenantId != null) {
          Get.offNamed('/main');
        } else {
          await _authService.signOut();
          Get.snackbar(
              'Error', 'Belum terdaftar, Mohon hubungi layanan bantuan.');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else if (e.code == 'email-not-verified') {
        Get.snackbar('Error', 'Please verify your email');
      } else {
        Get.snackbar('Error', e.message ?? 'An error occurred');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      Get.offAllNamed(Routes.LOGIN);
      await auth.signOut();
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

  // String? confirmPasswordValidator(String value, String password) {
  //   if (value != password) {
  //     return 'Password tidak sama';
  //   }
  //   return null;
  // }
}
