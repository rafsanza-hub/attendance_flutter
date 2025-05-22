import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String? tenantId;
  final String? role;

  UserModel({
    required this.uid,
    required this.email,
    this.tenantId,
    this.role,
  });

  factory UserModel.fromFirebaseUser(User user, Map<String, dynamic>? claims) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      tenantId: claims?['tenantId'] as String?,
      role: claims?['role'] as String?,
    );
  }
}
