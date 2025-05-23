import 'package:attendance_flutter/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:attendance_flutter/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:attendance_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:attendance_flutter/app/modules/profile/controllers/profile_controller.dart';
import 'package:attendance_flutter/app/modules/register/controllers/register_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
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
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
