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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'] as String,
      email: (json['email'] ?? '') as String,
      tenantId: json['tenantId'] as String?,
      role: json['role'] as String?,
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
