import 'package:attendance_flutter/app/data/models/tenant_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TenantService extends GetxService {
  final SupabaseClient _client = Supabase.instance.client;

  // Future<String> createTenant({
  //   required String name,
  //   required String adminId,
  //   required String startTime,
  //   required String endTime,
  // }) async {
  //   try {
  //     final result =
  //         await FirebaseFunctions.instance.httpsCallable('createTenant').call({
  //       'tenantName': name,
  //       'adminEmail': adminId,
  //       'startTime': startTime,
  //       'endTime': endTime,
  //     });
  //     return result.data['tenantId'] as String;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<String> createTenant({
    required String name,
    required String adminEmail,
    required String adminPassword,
    required String startTime,
    required String endTime,
  }) async {
    try {
      // Buat tenant id dan admin di Supabase
      final tenantId = 'tenant_${DateTime.now().millisecondsSinceEpoch}';
      final adminRes = await _client.auth.signUp(
        email: adminEmail,
        password: adminPassword,
      );
      if (adminRes.user == null) {
        throw Exception('Failed to create admin user');
      }
      final adminId = adminRes.user!.id;

      await _client.from('users').insert({
        'id': adminId,
        'email': adminEmail,
        'tenantId': tenantId,
        'role': 'admin',
      });

      await _client.from('tenants').insert({
        'id': tenantId,
        'name': name,
        'adminId': adminId,
      });

      await _client.from('tenant_settings').upsert({
        'tenantId': tenantId,
        'key': 'workingHours',
        'value': {
          'startTime': startTime,
          'endTime': endTime,
          'timezone': 'Asia/Jakarta',
          'days': ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'],
        },
      }, onConflict: 'tenantId,key');

      return tenantId;
    } catch (e) {
      rethrow;
    }
  }

  // Get tenant
  Future<TenantModel?> getTenant(String tenantId) async {
    try {
      final tenant = await _client
          .from('tenants')
          .select('id,name,createdAt,adminId')
          .eq('id', tenantId)
          .maybeSingle();
      if (tenant == null) return null;

      final setting = await _client
          .from('tenant_settings')
          .select('value')
          .eq('tenantId', tenantId)
          .eq('key', 'workingHours')
          .maybeSingle();

      return TenantModel.fromJson({
        ...tenant,
        'workingHours': setting != null ? setting['value'] : null,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> tenantExists(String tenantId) async {
    final row = await _client
        .from('tenants')
        .select('id')
        .eq('id', tenantId)
        .maybeSingle();
    return row != null;
  }
}
