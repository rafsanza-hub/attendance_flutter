import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/data/services/leave_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SubmitLeaveController extends GetxController {
  final LeaveService _leaveService = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController categoryC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController durationC = TextEditingController();
  final TextEditingController taskDelegationC = TextEditingController();

  DateTime startDateTemp = DateTime.now();
  DateTime endDateTemp = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  List<String> leaveCategories = [
    'Sick Leave',
    'Annual Leave',
    'Maternity Leave',
    'Paternity Leave',
    'Unpaid Leave',
  ];

  List<String> taskDelegations = [
    'Martin Deo',
    'John Doe',
    'Jane Doe',
  ];

  Future<void> submitLeave() async {
    try {
      await _leaveService.submitLeave(
        startDate: startDate,
        endDate: endDate,
        reason: descriptionC.text,
      );
      Get.back();
      AppLogger.instance.i('Leave submitted successfully');
    } catch (e) {
      AppLogger.instance.e('Error submitting leave: $e');
      Get.snackbar('Error', e.toString());
    }
  }

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Category is required';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  String? validateDuration(String? value) {
    if (value == null || value.isEmpty) {
      return 'Duration is required';
    }
    return null;
  }

  String? validateTaskDelegation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Task Delegation is required';
    }
    return null;
  }

  String? validateEmergencyContact(String? value) {
    if (value == null || value.isEmpty) {
      return 'Emergency Contact is required';
    }
    return null;
  }

  @override
  void onClose() {
    categoryC.dispose();
    descriptionC.dispose();
    durationC.dispose();
    taskDelegationC.dispose();
    super.onClose();
  }
}
