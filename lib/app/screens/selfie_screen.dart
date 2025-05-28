import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelfieScreen extends GetView<SelfieController> {
  const SelfieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.isCameraReady.value
            ? Stack(children: [
                CameraPreview(controller.cameraController),
                if (controller.imageFile != null)
                  Positioned.fill(
                    child: Image.file(
                      File(controller.imageFile!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
              ])
            : Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }
}

class SelfieController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> _cameras;
  RxBool isCameraReady = false.obs;
  late XFile? imageFile;

  @override
  void onInit() async {
    super.onInit();
    _cameras = await availableCameras();
    final frontCamera = _cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => _cameras.first,
    );
    cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    await cameraController.initialize();
    isCameraReady.value = true;
  }

  Future<void> takePicture() async {
    if (!cameraController.value.isInitialized) return;

    final XFile file = await cameraController.takePicture();
    imageFile = file;
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
