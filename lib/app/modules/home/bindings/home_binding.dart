import 'package:attendance_flutter/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:attendance_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:attendance_flutter/app/modules/register/controllers/register_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AttendanceController>(
      () => AttendanceController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
  }
}
