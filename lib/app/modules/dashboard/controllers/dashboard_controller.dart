import 'package:attendance_flutter/app/data/models/attendance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<AttendanceModel> attendances = <AttendanceModel>[].obs;

  @override
  void onInit() {
    final user = _auth.currentUser;
    if (user != null) {
      attendances.bindStream(_getAttendances(user.uid));
    }
    super.onInit();
  }

  Future<void> checkIn() async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'Please login first');
      return;
    }

    try {
      // Mendapatkan lokasi
      Position position = await _getCurrentLocation();

      // Placeholder untuk deteksi wajah
      bool isFaceVerified = await _verifyFace();

      final attendance = AttendanceModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.uid,
        checkIn: DateTime.now(),
        status: 'Checked In',
        latitude: position.latitude,
        longitude: position.longitude,
        isFaceVerified: isFaceVerified,
      );

      await _firestore
          .collection('attendances')
          .doc(attendance.id)
          .set(attendance.toJson());
      Get.snackbar('Success', 'Check-in recorded');
    } catch (e) {
      print("musyaffa: " + e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

  Stream<List<AttendanceModel>> _getAttendances(String userId) {
    return _firestore
        .collection('attendances')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AttendanceModel.fromJson(doc.data()))
            .toList());
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied.';
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> _verifyFace() async {
    // Placeholder untuk deteksi wajah
    return true; // Simulasi verifikasi wajah berhasil
  }
}
