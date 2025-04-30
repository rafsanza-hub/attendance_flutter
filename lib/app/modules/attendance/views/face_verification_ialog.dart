import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceVerificationDialog extends StatefulWidget {
  @override
  _FaceVerificationDialogState createState() => _FaceVerificationDialogState();
}

class _FaceVerificationDialogState extends State<FaceVerificationDialog> {
  CameraController? _cameraController;
  final faceDetector = GoogleMlKit.vision.faceDetector();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        // Pilih kamera depan kalau ada
        final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () =>
              cameras.first, // Kalau gak ada kamera depan, pakai kamera pertama
        );
        _cameraController =
            CameraController(frontCamera, ResolutionPreset.medium);
        await _cameraController!.initialize();
        setState(() {});
      } else {
        // Tidak ada kamera di device
        Get.snackbar('Error', 'No cameras found');
      }
    } catch (e) {
      print('Camera initialization error: $e');
      Get.snackbar('Error', 'Failed to initialize camera');
    }
  }

  Future<bool> _detectFace() async {
    // Placeholder untuk deteksi wajah
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return AlertDialog(
      content: CameraPreview(_cameraController!),
      actions: [
        ElevatedButton(
          onPressed: () async {
            bool verified = await _detectFace();
            Get.back(result: verified);
          },
          child: Text('Verify'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    faceDetector.close();
    super.dispose();
  }
}
