import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:attendance_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find();

  Future<void> logout() async {
    try {
      Get.offAllNamed(Routes.LOGIN);
      await _authService.signOut();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
