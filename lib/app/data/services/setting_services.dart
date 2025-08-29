import 'package:attendance_flutter/app/data/models/tenant_model.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingServices extends GetxService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> updateWorkingHours(Map<String, dynamic> workingHours) async {
    final tenantId = Get.find<AuthService>().getTenantId();
    if (tenantId == null) {
      throw Exception('Invalid user or tenant');
    }

    await _client.from('tenant_settings').upsert({
      'tenantId': tenantId,
      'key': 'workingHours',
      'value': workingHours,
    }, onConflict: 'tenantId,key');
  }

  Future<WorkingHours> getWorkingHours() async {
    try {
      await Get.find<AuthService>().waitUntilUserLoaded();
      final tenantId = Get.find<AuthService>().getTenantId();
      if (tenantId == null) {
        throw Exception('Invalid user or tenant');
      }

      final row = await _client
          .from('tenant_settings')
          .select('value')
          .eq('tenantId', tenantId)
          .eq('key', 'workingHours')
          .maybeSingle();
      if (row == null) throw Exception('Working hours not set');
      return WorkingHours.fromJson(
          (row['value'] as Map).cast<String, dynamic>());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
