import 'package:cloud_firestore/cloud_firestore.dart';

class TenantModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final String? adminId;
  final WorkingHours? workingHours;

  TenantModel({
    required this.id,
    required this.name,
    required this.createdAt,
    this.adminId,
    this.workingHours,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) {
    return TenantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      adminId: json['adminId'] as String?,
      workingHours: json['workingHours'] != null
          ? WorkingHours.fromJson(json['workingHours'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
      'adminId': adminId,
      'workingHours': workingHours?.toJson(),
    };
  }
}

class WorkingHours {
  final String startTime;
  final String endTime;
  final String timezone;
  final List<String> days;

  WorkingHours({
    required this.startTime,
    required this.endTime,
    required this.timezone,
    required this.days,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      timezone: json['timezone'] as String,
      days: List<String>.from(json['days'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'timezone': timezone,
      'days': days,
    };
  }
}
