import 'package:attendance_flutter/app/core/logger/logger.dart';
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
  final todayAttendance = Rxn<AttendanceModel>();

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
    checkTodayStatus();
  }

  bool get isClockedIn => todayAttendance.value != null;
  bool get isClockedOut => todayAttendance.value?.checkOut != null;
  get todayWorkingHours {
    if (isClockedIn) {
      return todayAttendance.value?.checkOut!
          .difference(todayAttendance.value?.checkIn ?? DateTime.now())
          .inMinutes;
    }
    return DateTime.now()
        .difference(todayAttendance.value?.checkIn ?? DateTime.now())
        .inMinutes;
  }

  // // Mencatat check-in
  // Future<void> checkIn() async {
  //   try {
  //     isLoading.value = true;
  //     final position = await _attendanceService.getCurrentLocation();
  //     final isFaceVerified = await _attendanceService.verifyFace();
  //     final attendanceId = await _attendanceService.checkIn(
  //       latitude: position.latitude,
  //       longitude: position.longitude,
  //       isFaceVerified: isFaceVerified,
  //     );
  //     currentAttendanceId.value = attendanceId;
  //     Get.snackbar('Success', 'Checked in successfully');
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void checkTodayStatus() {
    final result = _attendanceService.getTodayAttendanceStream();
    todayAttendance.bindStream(result);
  }

  // Mencatat check-out
  Future<void> checkOut() async {
    try {
      isLoading.value = true;
      if (todayAttendance.value?.id == null) {
        throw Exception('No active check-in found');
      }
      await _attendanceService.checkOut(todayAttendance.value?.id ?? '');
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
      AppLogger.instance.d('Fetched $result attendances');
    } catch (e) {
      AppLogger.instance.e('Error fetching attendances: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
