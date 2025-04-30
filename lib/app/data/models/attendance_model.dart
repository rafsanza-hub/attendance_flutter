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
      userId: json['userId'],
      checkIn: json['checkIn']?.toDate(),
      checkOut: json['checkOut']?.toDate(),
      status: json['status'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isFaceVerified: json['isFaceVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'isFaceVerified': isFaceVerified,
    };
  }
}
