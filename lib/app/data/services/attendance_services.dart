import 'dart:async';

import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/attendance_model.dart';

class AttendanceService extends GetxService {
  final SupabaseClient _client = Supabase.instance.client;
  final AuthService _authService = Get.find<AuthService>();

  // Mencatat check-in
  Future<String> checkIn({
    required double latitude,
    required double longitude,
    required bool isFaceVerified,
  }) async {
    try {
      // Validasi peran
      if (_authService.getRole() != 'employee') {
        throw Exception('Only employees can check in');
      }
      final tenantId = _authService.getTenantId();
      final userId = _authService.currentUser.value?.uid;
      if (tenantId == null || userId == null) {
        throw Exception('Invalid user or tenant');
      }

      // Ambil pengaturan waktu tenant dari Supabase
      final settings = await _client
          .from('tenant_settings')
          .select('value')
          .eq('tenantId', tenantId)
          .eq('key', 'workingHours')
          .maybeSingle();
      if (settings == null) {
        throw Exception('Tenant settings not found');
      }
      final workingHours = (settings['value'] as Map).cast<String, dynamic>();
      final startTimeStr = workingHours['startTime'] as String;
      final days = List<String>.from(workingHours['days'] as List);

      // Validasi hari kerja
      final now = DateTime.now();
      final currentDay = [
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
        'sunday'
      ][now.weekday - 1];
      if (!days.contains(currentDay)) {
        throw Exception('Today is not a working day');
      }

      // Hitung status absensi
      final startTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(startTimeStr.split(':')[0]),
        int.parse(startTimeStr.split(':')[1]),
      );
      final status = now.isAfter(startTime) ? 'late' : 'present';

      // Simpan data absensi di Supabase
      final attendanceId =
          'att_${DateTime.now().millisecondsSinceEpoch}_${userId.substring(0, 6)}';
      final attendance = AttendanceModel(
        id: attendanceId,
        userId: userId,
        checkIn: now,
        status: status,
        latitude: latitude,
        longitude: longitude,
        isFaceVerified: isFaceVerified,
      );
      await _client.from('attendances').insert({
        ...attendance.toJson(),
        'tenantId': tenantId,
      });
      return attendanceId;
    } catch (e) {
      throw Exception('Failed to check in: $e');
    }
  }

  // Mencatat check-out
  Future<void> checkOut(String attendanceId) async {
    try {
      // Validasi peran
      if (_authService.getRole() != 'employee') {
        throw Exception('Only employees can check out');
      }
      final tenantId = _authService.getTenantId();
      final userId = _authService.currentUser.value?.uid;
      if (tenantId == null || userId == null) {
        throw Exception('Invalid user or tenant');
      }

      // Periksa apakah absensi ada di Supabase
      final record = await _client
          .from('attendances')
          .select()
          .eq('tenantId', tenantId)
          .eq('id', attendanceId)
          .maybeSingle();
      if (record == null || (record['userId'] ?? record['userid']) != userId) {
        throw Exception('Attendance record not found or unauthorized');
      }

      // Update check-out
      await _client
          .from('attendances')
          .update({'checkout': DateTime.now().toIso8601String()})
          .eq('tenantId', tenantId)
          .eq('id', attendanceId);
    } catch (e) {
      throw Exception('Failed to check out: $e');
    }
  }

  // Mendapatkan stream daftar absensi
  Stream<List<AttendanceModel>> getAttendancesStream({
    bool forAdmin = false,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    try {
      final tenantId = _authService.getTenantId();
      final userId = _authService.currentUser.value?.uid;

      if (tenantId == null || userId == null) {
        throw Exception('Invalid user or tenant');
      }

      final stream = _client
          .from('attendances')
          .stream(primaryKey: ['id']).order('checkin');

      Stream<List<Map<String, dynamic>>> filtered = stream;

      if (!forAdmin || _authService.getRole() != 'admin') {
        filtered = filtered.map((rows) => rows
            .where((row) => (row['userId'] ?? row['userid']) == userId)
            .toList());
      }
      if (startDate != null && endDate != null) {
        filtered = filtered.map((rows) => rows.where((row) {
              final dt = DateTime.tryParse(
                  (row['checkIn'] ?? row['checkin']) as String? ?? '');
              if (dt == null) return false;
              return dt.isAfter(
                      startDate.subtract(const Duration(seconds: 1))) &&
                  dt.isBefore(endDate.add(const Duration(seconds: 1)));
            }).toList());
      }

      return filtered
          .map((rows) => rows.map((r) => AttendanceModel.fromJson(r)).toList());
    } catch (e) {
      AppLogger.instance.e('Error fetching attendances: $e');
      return Stream.empty();
    }
  }

  // Mendapatkan daftar absensi untuk laporan
  Future<List<AttendanceModel>> getAttendances({
    bool forAdmin = false,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      await _authService.waitUntilUserLoaded();
      final tenantId = _authService.getTenantId();
      final userId = _authService.currentUser.value?.uid;

      if (tenantId == null || userId == null) {
        throw Exception('Invalid user or tenant');
      }

      final builder =
          _client.from('attendances').select().eq('tenantid', tenantId);
      if (!forAdmin || _authService.getRole() != 'admin') {
        builder.eq('userid', userId);
      }
      if (startDate != null && endDate != null) {
        builder.gte('checkin', startDate.toIso8601String());
        builder.lte('checkin', endDate.toIso8601String());
      }
      final rows =
          await builder.order('checkin').then((value) => value as List);
      return rows
          .map((r) => AttendanceModel.fromJson(r as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get attendances: $e');
    }
  }

  Stream<AttendanceModel?> getTodayAttendanceStream() {
    final tenantId = _authService.getTenantId();
    final userId = _authService.currentUser.value?.uid;

    if (tenantId == null || userId == null) {
      return Stream.error('Invalid user or tenant');
    }

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final stream = _client.from('attendances').stream(primaryKey: ['id']);
    return stream.map((rows) {
      final todays = rows.where((row) {
        final dt = DateTime.tryParse(
            (row['checkIn'] ?? row['checkin']) as String? ?? '');
        if (dt == null) return false;
        return row['tenantId'] == tenantId &&
            (row['userId'] ?? row['userid']) == userId &&
            dt.isAfter(startOfDay.subtract(const Duration(seconds: 1))) &&
            dt.isBefore(endOfDay.add(const Duration(seconds: 1)));
      }).toList();
      if (todays.isEmpty) return null;
      return AttendanceModel.fromJson(todays.first);
    });
  }

  // Mendapatkan lokasi saat ini
  // Future<Position> getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     throw Exception('Location services are disabled');
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       throw Exception('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     throw Exception('Location permissions are permanently denied');
  //   }

  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  // void startLocationUpdates() {
  //   _locationSubscription = Geolocator.getPositionStream(
  //     locationSettings: const LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 10,
  //     ),
  //   ).listen((Position pos) {
  //     _locationController.add(pos);
  //   });
  // }

  // void stopLocationUpdates() {
  //   _locationSubscription?.cancel();
  //   _locationSubscription = null;
  // }

  // Placeholder untuk verifikasi wajah
  Future<bool> verifyFace() async {
    return true; // Simulasi verifikasi wajah berhasil
  }
}
