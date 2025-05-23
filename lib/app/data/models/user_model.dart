import 'package:cloud_firestore/cloud_firestore.dart';

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

  // factory UserModel.fromFirebaseUser(User user, Map<String, dynamic>? claims) {
  //   return UserModel(
  //     uid: user.uid,
  //     email: user.email ?? '',
  //     tenantId: claims?['tenantId'] as String?,
  //     role: claims?['role'] as String?,
  //   );
  // }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      tenantId: data['tenantId'] as String?,
      role: data['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'tenantId': tenantId,
      'role': role,
    };
  }
}
