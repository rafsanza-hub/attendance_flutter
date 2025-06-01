import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:get/get.dart';
import '../../../data/models/leave_model.dart';
import '../../../data/services/leave_service.dart';

class LeaveController extends GetxController {
  final LeaveService _leaveService = Get.find<LeaveService>();
  final leaves = <LeaveModel>[].obs;
  final availableLeaves = 0.obs;
  final usedLeaves = 0.obs;
  final periodStart = Rxn<DateTime>();
  final periodEnd = Rxn<DateTime>();
  final selectedTab = 0.obs;

  bool get isTab1 => selectedTab.value == 0;
  bool get isTab2 => selectedTab.value == 1;
  bool get isTab3 => selectedTab.value == 2;

  @override
  void onInit() {
    super.onInit();
    loadLeaveSummary();
    loadLeaves();
  }

  void changeTab(int index) {
    selectedTab.value = index;
    loadLeaves();
  }

  Future<void> loadLeaveSummary() async {
    try {
      final summary = await _leaveService.getLeaveSummary();
      availableLeaves.value = summary['available'];
      usedLeaves.value = summary['used'];
      periodStart.value = summary['periodStart'];
      periodEnd.value = summary['periodEnd'];
    } catch (e) {
      AppLogger.instance.e(e);
    }
  }

  Future<void> loadLeaves() async {
    String? status;
    if (isTab1) status = 'review';
    if (isTab2) status = 'approved';
    if (isTab3) status = 'rejected';
    final result = await _leaveService.getLeaves(
      forAdmin: false,
      status: status,
    );
    leaves.assignAll(result);
  }
}
