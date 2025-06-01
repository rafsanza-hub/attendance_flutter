import 'package:attendance_flutter/app/modules/attendance/views/attendance_view.dart';
import 'package:attendance_flutter/app/modules/home/views/home_view.dart';
import 'package:attendance_flutter/app/modules/leave/views/leave_view.dart';
import 'package:attendance_flutter/app/modules/main/controllers/main_controller.dart';
import 'package:attendance_flutter/app/screens/leave_screen.dart';
import 'package:attendance_flutter/app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

// class MainView extends GetView<MainController> {
//   const MainView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> pages = [
//       DashboardView(),
//       LeaveRequestView(),
//       ProfileView(),
//     ];

//     return Scaffold(
//       body: Obx(() => pages[controller.currentIndex.value]),
//       bottomNavigationBar: _buildAnimatedNotchBar(),
//     );
//   }

//   Widget _buildAnimatedNotchBar() {
//     return AnimatedNotchBottomBar(
//       notchColor: Colors.blue,
//       bottomBarItems: [
//         BottomBarItem(
//           inActiveItem: Icon(Iconsax.home_2_copy, color: Colors.grey),
//           activeItem: Icon(Iconsax.home_2, color: Colors.white),
//           itemLabel: 'Home',
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(Iconsax.scan, color: Colors.grey),
//           activeItem: Icon(Iconsax.scan, color: Colors.white),
//           itemLabel: 'Profile',
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(Iconsax.user, color: Colors.grey),
//           activeItem: Icon(Iconsax.user, color: Colors.white),
//           itemLabel: 'Profile',
//         ),
//       ],
//       onTap: controller.changeIndex,
//       notchBottomBarController: NotchBottomBarController(index: 1),
//       kIconSize: 24,
//       kBottomRadius: 15,
//       color: Colors.white,
//       showShadow: true,
//       bottomBarWidth: 300,
//       showLabel: true,
//       elevation: 0,
//       shadowElevation: 0,
//     );
//   }
// }

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomeView(),
            AttendanceView(),
            LeaveView(),
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
