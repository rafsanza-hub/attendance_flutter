import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelfieScreen extends GetView<SelfieController> {
  const SelfieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              // Camera preview or captured image
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: controller.imageFile.value != null
                    ? Image.file(
                        File(controller.imageFile.value!.path),
                        fit: BoxFit.cover,
                      )
                    : controller.isCameraReady.value
                        ? CameraPreview(controller.cameraController)
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
              ),

              // Header with close button
              Positioned(
                top: 16,
                left: 16,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),

              // Camera controls at bottom
              if (controller.isCameraReady.value)
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // Selfie button
                      GestureDetector(
                        onTap: controller.takePicture,
                        child: Container(
                          height: 72,
                          width: 72,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Retake/Save buttons when image is captured
                      if (controller.imageFile.value != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Retake button
                            TextButton(
                              onPressed: () {
                                controller.imageFile.value = null;
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black54,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Text(
                                'Retake',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Save button
                            TextButton(
                              onPressed: () {
                                // Add your save logic here
                                Get.back(result: controller.imageFile.value);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class SelfieController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> _cameras;
  RxBool isCameraReady = false.obs;
  Rxn<XFile> imageFile = Rxn<XFile>();

  @override
  void onInit() {
    super.onInit();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );
      cameraController = CameraController(frontCamera, ResolutionPreset.high);
      await cameraController.initialize();
      isCameraReady.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize camera',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> takePicture() async {
    if (!cameraController.value.isInitialized || imageFile.value != null)
      return;

    try {
      final XFile file = await cameraController.takePicture();
      imageFile.value = file;
    } catch (e) {
      Get.snackbar('Error', 'Failed to take picture',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
