import 'package:attendance_flutter/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': name,
          'email': email,
        });
        await userCredential.user!.sendEmailVerification();
      }
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
