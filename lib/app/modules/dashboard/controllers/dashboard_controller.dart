import 'package:attendance_flutter/app/data/models/tenant_model.dart';
import 'package:attendance_flutter/app/data/services/setting_services.dart';
import 'package:attendance_flutter/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final SettingServices settingServices = Get.find();
  final AttendanceController attendanceController = Get.find();
  final Rx<WorkingHours?> workingHours = Rx<WorkingHours?>(null);

  @override
  void onInit() {
    getWorkingHours();
    super.onInit();
  }

  Future<void> getWorkingHours() async {
    try {
      workingHours.value = await settingServices.getWorkingHours();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
