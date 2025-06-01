import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/leave_model.dart';

class LeaveService extends GetxService {
  // Dependencies
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = Get.find<AuthService>();

  // Validasi pengguna dan tenant
  Future<void> _validateUserAndTenant(String operation) async {
    final userId = _authService.currentUser.value?.uid;
    final tenantId = _authService.getTenantId(); // Async call
    AppLogger.instance
        .d('LeaveService: $operation - userId: $userId, tenantId: $tenantId');

    if (userId == null) {
      throw Exception('User not logged in');
    }
    if (_authService.isSuperAdmin()) {
      throw Exception('Superadmin cannot perform $operation');
    }
    if (tenantId == null || tenantId.isEmpty) {
      throw Exception('No tenant assigned');
    }
  }

  // Mengajukan cuti baru
  Future<void> submitLeave({
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  }) async {
    try {
      await _validateUserAndTenant('submitLeave');

      final userId = _authService.currentUser.value!.uid;
      final tenantId = (_authService.getTenantId())!;
      final totalDays = endDate.difference(startDate).inDays + 1;
      final leaveId =
          'leave_${userId}_${DateTime.now().millisecondsSinceEpoch}';

      await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('leaves')
          .doc(leaveId)
          .set({
        'userId': userId,
        'startDate': Timestamp.fromDate(startDate),
        'endDate': Timestamp.fromDate(endDate),
        'totalDays': totalDays,
        'status': 'review',
        'submittedAt': FieldValue.serverTimestamp(),
        'reviewedAt': null,
        'reviewedBy': null,
        'reason': reason,
      });

      AppLogger.instance
          .i('LeaveService: Leave submitted successfully, leaveId: $leaveId');
    } catch (e) {
      AppLogger.instance.e('LeaveService: Submit leave error: $e');
      rethrow;
    }
  }

  // Mengambil riwayat cuti berdasarkan status
  Future<List<LeaveModel>> getLeaves({
    required bool forAdmin,
    String? status, // "review", "approved", "rejected"
  }) async {
    try {
      await _validateUserAndTenant('getLeaves');

      final userId = _authService.currentUser.value!.uid;
      final tenantId = (_authService.getTenantId())!;
      Query<Map<String, dynamic>> query =
          _firestore.collection('tenants').doc(tenantId).collection('leaves');

      if (!forAdmin) {
        query = query.where('userId', isEqualTo: userId);
      }
      if (status != null) {
        query = query.where('status', isEqualTo: status);
      }
      query = query.orderBy('submittedAt', descending: true);

      final snapshot = await query.get();
      final leaves =
          snapshot.docs.map((doc) => LeaveModel.fromFirestore(doc)).toList();

      AppLogger.instance.i('LeaveService: Fetched ${leaves.length} leaves');
      return leaves;
    } catch (e) {
      AppLogger.instance.e('LeaveService: Get leaves error: $e');
      rethrow;
    }
  }

  // Stream untuk riwayat cuti secara real-time
  Stream<List<LeaveModel>> getLeavesStream({
    required bool forAdmin,
    String? status,
  }) async* {
    try {
      await _validateUserAndTenant('getLeavesStream');
      final userId = _authService.currentUser.value!.uid;
      final tenantId = (_authService.getTenantId())!;
      AppLogger.instance.d(
          'LeaveService: getLeavesStream - userId: $userId, forAdmin: $forAdmin');

      Query<Map<String, dynamic>> query =
          _firestore.collection('tenants').doc(tenantId).collection('leaves');

      if (!forAdmin) {
        query = query.where('userId', isEqualTo: userId);
      }
      if (status != null) {
        query = query.where('status', isEqualTo: status);
      }
      query = query.orderBy('submittedAt', descending: true);

      yield* query.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => LeaveModel.fromFirestore(doc)).toList());
    } catch (e) {
      AppLogger.instance.e('LeaveService: getLeavesStream error: $e');
      rethrow;
    }
  }

  // Menyetujui atau menolak cuti (untuk admin)
  Future<void> reviewLeave({
    required String leaveId,
    required String status, // "approved" atau "rejected"
  }) async {
    try {
      await _validateUserAndTenant('reviewLeave');

      final userId = _authService.currentUser.value!.uid;
      final tenantId = (_authService.getTenantId())!;
      if (!(_authService.isAdmin())) {
        throw Exception('Only admin can review leaves');
      }

      final docRef = _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('leaves')
          .doc(leaveId);
      final doc = await docRef.get();
      if (!doc.exists) {
        throw Exception('Leave record not found');
      }
      if (doc.data()!['status'] != 'review') {
        throw Exception('Leave already reviewed');
      }

      await docRef.update({
        'status': status,
        'reviewedAt': FieldValue.serverTimestamp(),
        'reviewedBy': userId,
      });

      if (status == 'approved') {
        final leaveUserId = doc.data()!['userId'];
        final totalDays = doc.data()!['totalDays'];
        await _firestore
            .collection('tenants')
            .doc(tenantId)
            .collection('employees')
            .doc(leaveUserId)
            .update({
          'leaveBalance': FieldValue.increment(-totalDays),
        });
      }

      AppLogger.instance
          .i('LeaveService: Leave $status successfully, leaveId: $leaveId');
    } catch (e) {
      AppLogger.instance.e('LeaveService: Review leave error: $e');
      rethrow;
    }
  }

  // Mendapatkan kuota cuti dan cuti yang digunakan
  Future<Map<String, dynamic>> getLeaveSummary() async {
    try {
      await _validateUserAndTenant('getLeaveSummary');

      final userId = _authService.currentUser.value!.uid;
      final tenantId = (_authService.getTenantId())!;

      // Ambil kuota dari settings
      final settingsDoc = await _firestore
          .collection('tenants')
          .doc(tenantId)
          .get(); // Perbaikan: Ambil dokumen tenant langsung
      final leaveQuota = settingsDoc.data()?['leaveQuota'] ?? 0;
      final periodStart =
          (settingsDoc.data()?['leavePeriodStart'] as Timestamp?)?.toDate();
      final periodEnd =
          (settingsDoc.data()?['leavePeriodEnd'] as Timestamp?)?.toDate();

      // Ambil sisa cuti dari employees
      final employeeDoc = await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('employees')
          .doc(userId)
          .get();
      final leaveBalance = employeeDoc.data()?['leaveBalance'] ?? leaveQuota;

      // Hitung cuti yang digunakan
      final usedLeaves = await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('leaves')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'approved')
          .where('startDate',
              isGreaterThanOrEqualTo:
                  Timestamp.fromDate(periodStart ?? DateTime.now()))
          .where('startDate',
              isLessThanOrEqualTo:
                  Timestamp.fromDate(periodEnd ?? DateTime.now()))
          .get();
      final usedDays = usedLeaves.docs
          .fold<int>(0, (acc, doc) => acc + (doc.data()['totalDays'] as int));

      AppLogger.instance.i(
          'LeaveService: Leave summary - available: $leaveBalance, used: $usedDays');
      return {
        'available': leaveBalance,
        'used': usedDays,
        'periodStart': periodStart,
        'periodEnd': periodEnd,
      };
    } catch (e) {
      AppLogger.instance.e('LeaveService: Get leave summary error: $e');
      rethrow;
    }
  }
}
