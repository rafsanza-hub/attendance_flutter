import 'package:attendance_flutter/app/data/models/tenant_model.dart';
import 'package:attendance_flutter/app/data/services/login_service.dart';
import 'package:attendance_flutter/app/data/services/tenant_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TenantController extends GetxController {
  final TenantService _tenantService = Get.find();
  final nameController = TextEditingController();
  final adminEmailController = TextEditingController();
  final adminPasswordController = TextEditingController();
  final startTimeController = TextEditingController(text: '08:00');
  final endTimeController = TextEditingController(text: '17:00');
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> createTenant() async {
    try {
      isLoading.value = true;
      final tenatId = await _tenantService.createTenant(
        name: nameController.text,
        adminEmail: adminEmailController.text,
        adminPassword: adminPasswordController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
      );

      Get.snackbar('success', 'Tenant created: $tenatId');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      nameController.clear();
      adminEmailController.clear();
      adminPasswordController.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
