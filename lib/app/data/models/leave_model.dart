import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveModel {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final String status;
  final DateTime submittedAt;
  final DateTime? reviewedAt;
  final String? reviewedBy;
  final String reason;

  LeaveModel({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.status,
    required this.submittedAt,
    this.reviewedAt,
    this.reviewedBy,
    required this.reason,
  });

  factory LeaveModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeaveModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      totalDays: data['totalDays'] ?? 0,
      status: data['status'] ?? '',
      submittedAt: (data['submittedAt'] as Timestamp).toDate(),
      reviewedAt: (data['reviewedAt'] as Timestamp?)?.toDate(),
      reviewedBy: data['reviewedBy'],
      reason: data['reason'] ?? '',
    );
  }
}