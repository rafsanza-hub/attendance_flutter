import 'package:attendance_flutter/app/data/services/attendance_services.dart';
import 'package:attendance_flutter/app/data/services/leave_service.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:attendance_flutter/app/data/services/setting_services.dart';
import 'package:attendance_flutter/app/data/services/tenant_services.dart';
import 'package:attendance_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:attendance_flutter/app/modules/main/controllers/main_controller.dart';
import 'package:attendance_flutter/app/screens/onboarding_screen.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.lazyPut<TenantService>(() => TenantService());
    Get.lazyPut<AttendanceService>(() => AttendanceService());
    Get.lazyPut<SettingServices>(() => SettingServices());
    Get.lazyPut<OnboardingController>(() => OnboardingController());
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<LeaveService>(() => LeaveService());
  }
}
