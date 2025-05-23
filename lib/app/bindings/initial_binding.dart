import 'package:attendance_flutter/app/data/services/attendance_services.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:attendance_flutter/app/data/services/tenant_services.dart';
import 'package:attendance_flutter/app/modules/attendance/bindings/attendance_binding.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<TenantService>(() => TenantService());
    Get.lazyPut<AttendanceService>(() => AttendanceService());
  }
}
