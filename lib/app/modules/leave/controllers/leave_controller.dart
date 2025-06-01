import 'package:get/get.dart';

class LeaveController extends GetxController {
  final RxInt tabIndex = 0.obs;

  void changeTab(int index) {
    tabIndex.value = index;
  }

  bool get isTab1 => tabIndex.value == 0;
  bool get isTab2 => tabIndex.value == 1;
  bool get isTab3 => tabIndex.value == 2;
}
