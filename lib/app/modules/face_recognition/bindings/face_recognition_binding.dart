import 'package:attendance_flutter/app/modules/face_recognition/controllers/face_recognition_controller.dart';
import 'package:get/get.dart';

class FaceRecognitionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceRecognitionController>(
      () => FaceRecognitionController(),
    );
  }
}
