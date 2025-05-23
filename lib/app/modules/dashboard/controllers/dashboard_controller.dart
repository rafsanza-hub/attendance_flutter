import 'package:attendance_flutter/app/data/models/attendance_model.dart';
import 'package:attendance_flutter/app/data/services/setting_services.dart';
import 'package:attendance_flutter/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SettingServices settingServices = Get.find();
  final AttendanceController attendanceController = Get.find();

  @override
  void onInit() {
    final user = _auth.currentUser;
    if (user != null) {}
    super.onInit();
  }

  
}
