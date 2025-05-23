class WorkingHoursModel {
  final String startTime;
  final String endTime;
  final String timezone;
  final List<String> days;

  WorkingHoursModel({
    required this.startTime,
    required this.endTime,
    required this.timezone,
    required this.days,
  });

  factory WorkingHoursModel.fromMap(Map<String, dynamic> map) {
    return WorkingHoursModel(
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      timezone: map['timezone'] ?? 'Asia/Jakarta',
      days: List<String>.from(map['days'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'timezone': timezone,
      'days': days,
    };
  }
}
