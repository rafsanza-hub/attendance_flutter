import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as imglib;
import 'package:path_provider/path_provider.dart';
import 'package:quiver/collection.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class FaceRecognitionView extends GetView<FaceRecognitionController> {
  const FaceRecognitionView({super.key});

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
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              CameraPreview(controller.cameraController),
                              if (controller.scanResults.value != null)
                                CustomPaint(
                                  painter: FaceDetectorPainter(
                                    Size(
                                      controller.cameraController.value
                                          .previewSize!.height,
                                      controller.cameraController.value
                                          .previewSize!.width,
                                    ),
                                    controller.scanResults.value!,
                                  ),
                                ),
                            ],
                          )
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
                      // Display recognition result
                      if (controller.predRes.value.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            controller.predRes.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      // Selfie button or Save Embedding button
                      GestureDetector(
                        onTap: controller.imageFile.value == null
                            ? controller.takePicture
                            : controller.showSaveDialog,
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
                                controller.startImageStream();
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

class FaceRecognitionController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> _cameras;
  RxBool isCameraReady = false.obs;
  Rxn<XFile> imageFile = Rxn<XFile>();
  RxString predRes = ''.obs;
  Rxn<Multimap<String, Face>> scanResults = Rxn<Multimap<String, Face>>();
  RxBool faceFound = false.obs;
  late tfl.Interpreter interpreter;
  dynamic data = {};
  File? jsonFile;
  Directory? tempDir;
  bool isDetecting = false;
  List? currentEmbedding;
  final TextEditingController nameController = TextEditingController();
  final double threshold = 1.0;

  @override
  void onInit() {
    super.onInit();
    _initCamera();
    _initModel();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );
      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await cameraController.initialize();
      isCameraReady.value = true;
      await _initStorage();
      startImageStream();
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize camera: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> _initModel() async {
    try {
      var interpreterOptions = tfl.InterpreterOptions();
      interpreter = await tfl.Interpreter.fromAsset(
        'assets/mobilefacenet.tflite',
        options: interpreterOptions,
      );
    } catch (e) {
      AppLogger.instance.e('Error loading model: $e');
      Get.snackbar('Error', 'Failed to load model: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> _initStorage() async {
    tempDir = await getApplicationDocumentsDirectory();
    String embPath = '${tempDir!.path}/emb.json';
    jsonFile = File(embPath);
    if (jsonFile!.existsSync()) {
      data = json.decode(jsonFile!.readAsStringSync());
    }
  }

  void startImageStream() {
    if (!cameraController.value.isInitialized) return;
    cameraController.startImageStream((CameraImage image) async {
      if (isDetecting) return;
      isDetecting = true;

      try {
        dynamic results = await detect(image, getDetectionMethod());
        Multimap<String, Face> finalResult = Multimap<String, Face>();

        if (results == null || results.isEmpty) {
          faceFound.value = false;
          predRes.value = 'Tidak dikenali';
        } else {
          faceFound.value = true;
          imglib.Image convertedImage =
              convertCameraImage(image, CameraLensDirection.front);
          for (Face face in results) {
            double x = face.boundingBox.left - 10;
            double y = face.boundingBox.top - 10;
            double w = face.boundingBox.width + 10;
            double h = face.boundingBox.height + 10;
            imglib.Image croppedImage = imglib.copyCrop(
              convertedImage,
              x: x.round(),
              y: y.round(),
              width: w.round(),
              height: h.round(),
            );
            croppedImage = imglib.copyResizeCropSquare(croppedImage, size: 112);
            String res = recog(croppedImage);
            finalResult.add(res, face);
          }
        }

        scanResults.value = finalResult;
      } catch (e) {
        Get.snackbar('Error', 'Detection failed: $e',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } finally {
        isDetecting = false;
      }
    });
  }

  Future<void> takePicture() async {
    if (!cameraController.value.isInitialized || imageFile.value != null)
      return;

    try {
      await cameraController.stopImageStream();
      final XFile file = await cameraController.takePicture();
      imageFile.value = file;
    } catch (e) {
      Get.snackbar('Error', 'Failed to take picture: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void showSaveDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Save Face Data'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Enter Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty && currentEmbedding != null) {
                data[nameController.text] = currentEmbedding;
                jsonFile!.writeAsStringSync(json.encode(data));
                Get.snackbar('Success', 'Face data saved',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white);
                nameController.clear();
                imageFile.value = null;
                Get.back();
                startImageStream();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  String recog(imglib.Image img) {
    List input = imageToByteListFloat32(img, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    List output = List.filled(1 * 192, null, growable: false).reshape([1, 192]);
    interpreter.run(input, output);
    output = output.reshape([192]);
    currentEmbedding = List.from(output);
    return compare(currentEmbedding!);
  }

  String compare(List currEmb) {
    double minDist = 999;
    String pred = 'Tidak dikenali';
    for (String label in data.keys) {
      double currDist = euclideanDistance(data[label], currEmb);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        pred = label;
      }
    }
    predRes.value = pred.toUpperCase();
    return pred;
  }

  @override
  void onClose() {
    cameraController.stopImageStream();
    cameraController.dispose();
    interpreter.close();
    super.onClose();
  }
}

// Utility functions
Future<CameraDescription> getCamera(CameraLensDirection dir) async {
  return await availableCameras().then(
    (List<CameraDescription> cameras) => cameras.firstWhere(
      (camera) => camera.lensDirection == dir,
    ),
  );
}

InputImageMetadata buildMetaData(
    CameraImage image, InputImageRotation rotation) {
  return InputImageMetadata(
    size: Size(image.width.toDouble(), image.height.toDouble()),
    rotation: rotation,
    format: InputImageFormat.nv21,
    bytesPerRow: image.planes[0].bytesPerRow,
  );
}

Future<dynamic> detect(
    CameraImage image, Function(InputImage) handleDetection) async {
  try {
    CameraDescription description = await getCamera(CameraLensDirection.front);
    InputImageRotation rotation =
        rotationIntToImageRotation(description.sensorOrientation);
    return handleDetection(
      InputImage.fromBytes(
        bytes: image.planes[0].bytes,
        metadata: buildMetaData(image, rotation),
      ),
    );
  } catch (e) {
    debugPrint('Detection error: $e');
    return null;
  }
}

InputImageRotation rotationIntToImageRotation(int rotation) {
  switch (rotation) {
    case 0:
      return InputImageRotation.rotation0deg;
    case 90:
      return InputImageRotation.rotation90deg;
    case 180:
      return InputImageRotation.rotation180deg;
    default:
      assert(rotation == 270);
      return InputImageRotation.rotation270deg;
  }
}

Float32List imageToByteListFloat32(
    imglib.Image image, int inputSize, double mean, double std) {
  var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  var buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image.getPixel(j, i);
      buffer[pixelIndex++] = (pixel.r - mean) / std;
      buffer[pixelIndex++] = (pixel.g - mean) / std;
      buffer[pixelIndex++] = (pixel.b - mean) / std;
    }
  }
  return convertedBytes.buffer.asFloat32List();
}

double euclideanDistance(List e1, List e2) {
  double sum = 0.0;
  for (int i = 0; i < e1.length; i++) {
    sum += pow((e1[i] - e2[i]), 2);
  }
  return sqrt(sum);
}

imglib.Image convertCameraImage(CameraImage image, CameraLensDirection dir) {
  int width = image.width;
  int height = image.height;
  var img = imglib.Image(width: width, height: height);
  const int hexFF = 0xFF000000;
  final int uvyButtonStride = image.planes[1].bytesPerRow;
  final int? uvPixelStride = image.planes[1].bytesPerPixel;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      final int uvIndex =
          uvPixelStride! * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
      final int index = y * width + x;
      final yp = image.planes[0].bytes[index];
      final up = image.planes[1].bytes[uvIndex];
      final vp = image.planes[2].bytes[uvIndex];
      int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
      int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
          .round()
          .clamp(0, 255);
      int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
      img.setPixelRgba(x, y, r, g, b, 255); // 255 = alpha / opacity
    }
  }
  var img1 = (dir == CameraLensDirection.front)
      ? imglib.copyRotate(img, angle: -90)
      : imglib.copyRotate(img, angle: 90);
  return img1;
}

Function(InputImage) getDetectionMethod() {
  final faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: false,
      enableLandmarks: false,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  return faceDetector.processImage;
}

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.imageSize, this.results);
  final Size imageSize;
  final Multimap<String, Face> results;
  late double scaleX, scaleY;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.blue;
    for (String label in results.keys) {
      for (Face face in results[label]) {
        scaleX = size.width / imageSize.width;
        scaleY = size.height / imageSize.height;
        canvas.drawRRect(
          _scaleRect(
            rect: face.boundingBox,
            imageSize: imageSize,
            widgetSize: size,
            scaleX: scaleX,
            scaleY: scaleY,
          ),
          paint,
        );
        TextSpan span = const TextSpan(
          style: TextStyle(color: Colors.orange, fontSize: 15),
          text: '',
        );
        TextPainter textPainter = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            size.width - (60 + face.boundingBox.left.toDouble()) * scaleX,
            (face.boundingBox.top.toDouble() - 10) * scaleY,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.results != results;
  }
}

RRect _scaleRect({
  required Rect rect,
  required Size imageSize,
  required Size widgetSize,
  double? scaleX,
  double? scaleY,
}) {
  return RRect.fromLTRBR(
    (widgetSize.width - rect.left.toDouble() * scaleX!),
    rect.top.toDouble() * scaleY!,
    widgetSize.width - rect.right.toDouble() * scaleX,
    rect.bottom.toDouble() * scaleY,
    const Radius.circular(10),
  );
}
