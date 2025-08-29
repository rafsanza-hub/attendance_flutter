import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/leave_model.dart';

class LeaveService extends GetxService {
  // Dependencies
  final SupabaseClient _client = Supabase.instance.client;
  final AuthService _authService = Get.find<AuthService>();

  // Validasi pengguna dan tenant
  Future<void> _validateUserAndTenant(String operation) async {
    await _authService.waitUntilUserLoaded();
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

      await _client.from('leaves').insert({
        'id': leaveId,
        'tenantId': tenantId,
        'userId': userId,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'totalDays': totalDays,
        'status': 'review',
        'submittedAt': DateTime.now().toIso8601String(),
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
      final rows = await _client
          .from('leaves')
          .select()
          .match({'tenantId': tenantId}).order('submittedAt',
              ascending: false) as List;
      final filtered = rows.where((row) {
        if (!forAdmin && row['userId'] != userId) return false;
        if (status != null && row['status'] != status) return false;
        return true;
      }).toList();
      final leaves = filtered
          .map((row) => LeaveModel.fromJson(row as Map<String, dynamic>))
          .toList();

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

      final stream = _client
          .from('leaves')
          .stream(primaryKey: ['id'])
          .eq('tenantId', tenantId)
          .order('submittedAt', ascending: false);

      yield* stream.map((rows) {
        var filtered = rows;
        if (!forAdmin) {
          filtered = filtered.where((row) => row['userId'] == userId).toList();
        }
        if (status != null) {
          filtered = filtered.where((row) => row['status'] == status).toList();
        }
        return filtered
            .map((row) => LeaveModel.fromJson(row as Map<String, dynamic>))
            .toList();
      });
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

      final record = await _client
          .from('leaves')
          .select()
          .eq('tenantId', tenantId)
          .eq('id', leaveId)
          .maybeSingle();
      if (record == null) {
        throw Exception('Leave record not found');
      }
      if (record['status'] != 'review') {
        throw Exception('Leave already reviewed');
      }

      await _client
          .from('leaves')
          .update({
            'status': status,
            'reviewedAt': DateTime.now().toIso8601String(),
            'reviewedBy': userId,
          })
          .eq('tenantId', tenantId)
          .eq('id', leaveId);

      if (status == 'approved') {
        final leaveUserId = record['userId'];
        final totalDays = record['totalDays'] as int;
        await _client.rpc('decrement_leave_balance', params: {
          'p_tenant_id': tenantId,
          'p_user_id': leaveUserId,
          'p_days': totalDays,
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
      final tenant = await _client
          .from('tenants')
          .select('leaveQuota, leavePeriodStart, leavePeriodEnd')
          .eq('id', tenantId)
          .maybeSingle();
      final leaveQuota = tenant?['leaveQuota'] ?? 0;
      final periodStart = tenant?['leavePeriodStart'] != null
          ? DateTime.tryParse(tenant?['leavePeriodStart'])
          : null;
      final periodEnd = tenant?['leavePeriodEnd'] != null
          ? DateTime.tryParse(tenant?['leavePeriodEnd'])
          : null;

      // Ambil sisa cuti dari employees
      final employee = await _client
          .from('employees')
          .select('leaveBalance')
          .eq('tenantId', tenantId)
          .eq('id', userId)
          .maybeSingle();
      final leaveBalance = employee?['leaveBalance'] ?? leaveQuota;

      // Hitung cuti yang digunakan
      final rows = await _client
          .from('leaves')
          .select('totalDays')
          .eq('tenantId', tenantId)
          .eq('userId', userId)
          .eq('status', 'approved')
          .gte('startDate', (periodStart ?? DateTime.now()).toIso8601String())
          .lte('startDate',
              (periodEnd ?? DateTime.now()).toIso8601String()) as List;
      final usedDays =
          rows.fold<int>(0, (acc, row) => acc + (row['totalDays'] as int));

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
