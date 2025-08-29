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

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      totalDays: (json['totalDays'] as num).toInt(),
      status: json['status'] as String,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.tryParse(json['reviewedAt'] as String)
          : null,
      reviewedBy: json['reviewedBy'] as String?,
      reason: json['reason'] as String,
    );
  }
}
