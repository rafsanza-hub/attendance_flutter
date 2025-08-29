import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();

  RxBool isLoading = false.obs;

  final SupabaseClient _client = Supabase.instance.client;

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;
    try {
      final response = await _client.auth
          .signUp(email: email, password: password, data: {'name': name});
      final created = response.user;
      if (created != null) {
        await _client.from('users').insert({
          'id': created.id,
          'email': email,
          'role': 'employee',
        });
      }
      Get.offAllNamed(Routes.ONBOARDING);
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      AppLogger.instance.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (GetUtils.isEmail(value)) {
      return 'Email is not valid';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != passwordC.text) {
      return 'Password does not match';
    }
    return null;
  }

  @override
  void onClose() {
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
