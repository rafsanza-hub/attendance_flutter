import 'package:attendance_flutter/app/data/models/attendance_model.dart';
import 'package:attendance_flutter/app/data/services/attendance_services.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final AttendanceService _attendanceService = Get.find<AttendanceService>();
  final AuthService _authService = Get.find<AuthService>();
  final RxList<AttendanceModel> attendances = <AttendanceModel>[].obs;
  final isLoading = false.obs;
  final isAdmin = false.obs;
  final currentAttendanceId = RxString('');

  @override
  void onInit() {
    super.onInit();
    isAdmin.value = _authService.isAdmin();
    final userId = _authService.currentUser.value?.uid;
    if (userId != null) {
      attendances.bindStream(_attendanceService.getAttendancesStream(
        forAdmin: isAdmin.value,
      ));
    }
  }

  // Mencatat check-in
  Future<void> checkIn() async {
    try {
      isLoading.value = true;
      final position = await _attendanceService.getCurrentLocation();
      final isFaceVerified = await _attendanceService.verifyFace();
      final attendanceId = await _attendanceService.checkIn(
        latitude: position.latitude,
        longitude: position.longitude,
        isFaceVerified: isFaceVerified,
      );
      currentAttendanceId.value = attendanceId;
      Get.snackbar('Success', 'Checked in successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Mencatat check-out
  Future<void> checkOut() async {
    try {
      isLoading.value = true;
      if (currentAttendanceId.value.isEmpty) {
        throw Exception('No active check-in found');
      }
      await _attendanceService.checkOut(currentAttendanceId.value);
      currentAttendanceId.value = '';
      Get.snackbar('Success', 'Checked out successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Mengambil daftar absensi dengan filter tanggal (untuk laporan)
  Future<void> fetchAttendances({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      isLoading.value = true;
      final result = await _attendanceService.getAttendances(
        forAdmin: isAdmin.value,
        startDate: startDate,
        endDate: endDate,
      );
      attendances.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
