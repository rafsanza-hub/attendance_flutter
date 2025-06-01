import 'package:get/get.dart';

import '../controllers/submit_leave_controller.dart';

class SubmitLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitLeaveController>(
      () => SubmitLeaveController(),
    );
  }
}
