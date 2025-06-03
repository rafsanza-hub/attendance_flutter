import 'dart:async';
import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/data/services/attendance_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ClockInController extends GetxController {
  final AttendanceService _attendanceService = Get.find();
  final location = Rx<Position?>(null);
  StreamSubscription<Position>? _locationSubscription;

  void startLocationTracking() {
    try {
      _locationSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position newPosition) {
        location.value = newPosition;
      });
    } catch (e) {
      AppLogger.instance.e('Error listening to location: $e');
    }
  }

  Future<void> clockIn() async {
    try {
      final pos = location.value;
      if (pos != null) {
        await _attendanceService.checkIn(
          latitude: pos.latitude,
          longitude: pos.longitude,
          isFaceVerified: true,
        );
      } else {
        AppLogger.instance.e('No location available during clock in.');
      }
    } catch (e) {
      AppLogger.instance.e('Error clocking in: $e');
    }
  }

  Future<void> clockOut() async {
    try {
      await _attendanceService.checkOut('');
    } catch (e) {
      AppLogger.instance.e('Error clocking out: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    startLocationTracking();
  }

  @override
  void onClose() {
    _locationSubscription?.cancel();
    super.onClose();
  }
}
