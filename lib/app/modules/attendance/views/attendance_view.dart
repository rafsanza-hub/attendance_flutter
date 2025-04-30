import 'package:attendance_flutter/app/modules/attendance/views/face_verification_ialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Attendance')),
      body: Obx(() => ListView.builder(
            itemCount: controller.attendances.length,
            itemBuilder: (context, index) {
              final attendance = controller.attendances[index];
              return ListTile(
                title: Text('Check-in: ${attendance.checkIn ?? 'N/A'}'),
                subtitle: Text(
                    'Status: ${attendance.status ?? 'N/A'}\nLocation: (${attendance.latitude ?? 'N/A'}, ${attendance.longitude ?? 'N/A'})'),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context, builder: (_) => FaceVerificationDialog()),
        child: Icon(Icons.check),
      ),
    );
  }
}
