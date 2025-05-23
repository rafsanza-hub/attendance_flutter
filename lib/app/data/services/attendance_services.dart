import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../models/attendance_model.dart';

class AttendanceService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

      // Ambil pengaturan waktu tenant
      final settingsDoc = await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('settings')
          .doc('workingHours')
          .get();
      if (!settingsDoc.exists) {
        throw Exception('Tenant settings not found');
      }
      final workingHours = settingsDoc.data()!['value'] as Map<String, dynamic>;
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

      // Simpan data absensi
      final attendanceId = _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('attendances')
          .doc()
          .id;
      final attendance = AttendanceModel(
        id: attendanceId,
        userId: userId,
        checkIn: now,
        status: status,
        latitude: latitude,
        longitude: longitude,
        isFaceVerified: isFaceVerified,
      );
      await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('attendances')
          .doc(attendanceId)
          .set(attendance.toJson());
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

      // Periksa apakah absensi ada
      final doc = await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('attendances')
          .doc(attendanceId)
          .get();
      if (!doc.exists || doc.data()!['userId'] != userId) {
        throw Exception('Attendance record not found or unauthorized');
      }

      // Update check-out
      await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('attendances')
          .doc(attendanceId)
          .update({
        'checkOut': DateTime.now(),
      });
    } catch (e) {
      throw Exception('Failed to check out: $e');
    }
  }

  // Mendapatkan stream daftar absensi
  Stream<List<AttendanceModel>> getAttendancesStream({
    bool forAdmin = false,
  }) {
    final tenantId = _authService.getTenantId();
    final userId = _authService.currentUser.value?.uid;
    if (tenantId == null || userId == null) {
      throw Exception('Invalid user or tenant');
    }

    Query<Map<String, dynamic>> query = _firestore
        .collection('tenants')
        .doc(tenantId)
        .collection('attendances');

    // Filter berdasarkan peran
    if (!forAdmin || _authService.getRole() != 'admin') {
      query = query.where('userId', isEqualTo: userId);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => AttendanceModel.fromJson({
              ...doc.data(),
              'id': doc.id,
            }))
        .toList());
  }

  // Mendapatkan daftar absensi untuk laporan
  Future<List<AttendanceModel>> getAttendances({
    bool forAdmin = false,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final tenantId = _authService.getTenantId();
      final userId = _authService.currentUser.value?.uid;
      if (tenantId == null || userId == null) {
        throw Exception('Invalid user or tenant');
      }

      Query<Map<String, dynamic>> query = _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('attendances');

      // Filter berdasarkan peran
      if (!forAdmin || _authService.getRole() != 'admin') {
        query = query.where('userId', isEqualTo: userId);
      }

      // Filter berdasarkan tanggal
      if (startDate != null && endDate != null) {
        query = query
            .where('checkIn', isGreaterThanOrEqualTo: startDate)
            .where('checkIn', isLessThanOrEqualTo: endDate);
      }

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => AttendanceModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw Exception('Failed to get attendances: $e');
    }
  }

  // Mendapatkan lokasi saat ini
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Placeholder untuk verifikasi wajah
  Future<bool> verifyFace() async {
    // TODO: Integrasikan dengan ML Kit Face Detection atau API eksternal
    return true; // Simulasi verifikasi wajah berhasil
  }
}
