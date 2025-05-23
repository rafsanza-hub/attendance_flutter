import 'package:attendance_flutter/app/data/models/tenant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TenantService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      // Buat tenant
      final tenantId =
          'tenant_${_firestore.collection('tenantsMeta').doc().id}';

      // Buat admin tenant
      final adminUser = await _auth.createUserWithEmailAndPassword(
          email: adminEmail, password: adminPassword);

      // Simpan di firestore
      await _firestore.collection('users').doc(adminUser.user!.uid).set({
        'email': adminEmail,
        'tenantId': tenantId,
        'role': 'admin',
      });

      // Simpan tenant di firestore
      await _firestore.collection('tenantsMeta').doc(tenantId).set({
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
        'adminId': adminUser.user!.uid,
      });

      // Simpan Pengaturan waktu
      await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('settings')
          .doc('workingHours')
          .set({
        'key': 'workingHours',
        'value': {
          'startTime': startTime,
          'endTime': endTime,
          'timezone': 'Asia/Jakarta',
          'days': ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'],
        },
      });

      return tenantId;
    } catch (e) {
      rethrow;
    }
  }

  // Get tenant
  Future<TenantModel?> getTenant(String tenantId) async {
    try {
      final doc =
          await _firestore.collection('tenantsMeta').doc(tenantId).get();
      if (!doc.exists) return null;

      final settingsDoc =
          await _firestore.collection('tenants').doc(tenantId).get();

      return TenantModel.fromJson({
        ...doc.data()!,
        'id': doc.id,
        'workingHours':
            settingsDoc.exists ? settingsDoc.data()!['value'] : null,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> tenantExists(String tenantId) async {
    final doc = await _firestore.collection('tenantMeta').doc(tenantId).get();
    return doc.exists;
  }
}
