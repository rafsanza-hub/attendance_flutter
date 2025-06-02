import 'package:attendance_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
