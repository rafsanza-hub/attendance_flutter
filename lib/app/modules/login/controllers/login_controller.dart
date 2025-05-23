import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:attendance_flutter/app/data/services/tenant_services.dart';
import 'package:attendance_flutter/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find();
  final TenantService _tenantService = Get.find();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  final isLoading = false.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser.obs;

  login() async {
    isLoading.value = true;
    try {
      await _authService.signIn(emailC.text, passwordC.text);
      // Jika superadmin
      if (_authService.isSuperAdmin()) {
        Get.offNamed('/tenant');

        // Jika admin
      } else if (_authService.isAdmin()) {
        final tenantId = _authService.getTenantId();
        print('tenantId: $tenantId');
        if (tenantId != null) {
          Get.offNamed('/main');
        } else {
          await _authService.signOut();
          Get.snackbar('Error', 'Belum terdaftar, Mohon hubungi layanan bantuan.');
        }
      } else {
        final tenantId = _authService.getTenantId();
        if (tenantId != null && await _tenantService.tenantExists(tenantId)) {
          Get.offNamed('/main');
        } else {
          await _authService.signOut();
          Get.snackbar('Error', 'Belum terdaftar, Mohon hubungi layanan bantuan.');
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
}
