import 'package:attendance_flutter/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  final isLoading = false.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  login(String email, String password) async {
    isLoading.value = true;
    try {
      final UserCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (UserCredential.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        throw FirebaseAuthException(code: 'email-not-verified');
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

  logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
