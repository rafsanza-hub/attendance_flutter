import 'package:attendance_flutter/app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen(
      (user) async {
        if (user != null) {
          final doc = await _firestore.collection('users').doc(user.uid).get();
          if (doc.exists) {
            currentUser.value = UserModel.fromFirestore(doc);
          } else {
            currentUser.value =
                UserModel(uid: user.uid, email: user.email ?? '');
          }
        } else {
          currentUser.value = null;
        }
      },
    );
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('Login failed: No user found');
      }
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        await _auth.signOut();
        throw Exception('User not registered. Contact your admin.');
      }
      final userData = doc.data() as Map<String, dynamic>;
      if (userData['role'] != 'superadmin' && userData['tenantId'] == null) {
        await _auth.signOut();
        throw Exception('No tenant assigned. Contact your admin.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  String? getTenantId() => currentUser.value?.tenantId;

  String? getRole() => currentUser.value?.role;

  bool isSuperAdmin() => getRole() == 'superadmin';

  bool isAdmin() => getRole() == 'admin';
}
