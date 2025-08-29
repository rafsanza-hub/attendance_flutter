class AttendanceModel {
  String? id;
  String? userId;
  DateTime? checkIn;
  DateTime? checkOut;
  String? status;
  double? latitude;
  double? longitude;
  bool? isFaceVerified;

  AttendanceModel({
    this.id,
    this.userId,
    this.checkIn,
    this.checkOut,
    this.status,
    this.latitude,
    this.longitude,
    this.isFaceVerified,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      userId: json['userId'] ?? json['userid'],
      checkIn: json['checkIn'] != null || json['checkin'] != null
          ? DateTime.tryParse((json['checkIn'] ?? json['checkin']) as String)
          : null,
      checkOut: json['checkOut'] != null || json['checkout'] != null
          ? DateTime.tryParse((json['checkOut'] ?? json['checkout']) as String)
          : null,
      status: json['status'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isFaceVerified: json['isFaceVerified'] ?? json['isfaceverified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userId,
      'checkin': checkIn?.toIso8601String(),
      'checkout': checkOut?.toIso8601String(),
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'isfaceverified': isFaceVerified,
    };
  }
}
