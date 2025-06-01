import 'package:attendance_flutter/app/modules/main/controllers/main_controller.dart';
import 'package:attendance_flutter/app/screens/attendance_screen.dart';
import 'package:attendance_flutter/app/screens/home_screen.dart';
import 'package:attendance_flutter/app/screens/leave_screen.dart';
import 'package:attendance_flutter/app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomeScreen(),
            AttendanceScreen(),
            LeaveScreen(),
            ProfileScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedIconTheme: const IconThemeData(color: Colors.blue),
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.home_2), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.calendar_2), label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.note), label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.user), label: 'Profile'),
            ]);
      }),
    );
  }
}

// class MainController extends GetxController {
//   final RxInt currentIndex = 0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     Get.put(LeaveController());
//     Get.lazyPut<SelfieController>(() => SelfieController());
//     Get.lazyPut<LeaveFormController>(() => LeaveFormController());
//   }

//   void changeIndex(int index) {
//     currentIndex.value = index;
//   }
// }
