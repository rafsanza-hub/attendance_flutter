import 'package:attendance_flutter/app/modules/face_recognition/views/face_recognition_view.dart';
import 'package:get/get.dart';

class FaceRecognitionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceRecognitionController>(
      () => FaceRecognitionController(),
    );
  }
}
