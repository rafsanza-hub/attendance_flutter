import 'package:attendance_flutter/app/data/models/tenant_model.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SettingServices extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = Get.find<AuthService>();

  Future<void> updateWorkingHours(Map<String, dynamic> workingHours) async {
    final tenantId = Get.find<AuthService>().getTenantId();
    if (tenantId == null) {
      throw Exception('Invalid user or tenant');
    }

    await _firestore
        .collection('tenants')
        .doc(tenantId)
        .collection('settings')
        .doc('workingHours')
        .set({'value': workingHours}, SetOptions(merge: true));
  }

  Future<WorkingHours> getWorkingHours() async {
    try {
      print('alalal');
     await Get.find<AuthService>().waitUntilUserLoaded();
      final tenantId = Get.find<AuthService>().getTenantId();
      print('tenantId: $tenantId');
      if (tenantId == null) {
        print('lalalala');
        throw Exception('Invalid user or tenant');
      }

      print('alalal');
      final doc = await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('settings')
          .doc('workingHours')
          .get();
      print('alala' + doc.data().toString());
      if (!doc.exists) throw Exception('Working hours not set');
      return WorkingHours.fromJson(doc.data()!['value']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
