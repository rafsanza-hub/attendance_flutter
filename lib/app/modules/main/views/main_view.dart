import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:attendance_flutter/app/modules/LeaveRequest/views/leave_request_view.dart';
import 'package:attendance_flutter/app/modules/dashboard/views/dashboard_view.dart';
import 'package:attendance_flutter/app/modules/main/controllers/main_controller.dart';
import 'package:attendance_flutter/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DashboardView(),
      LeaveRequestView(),
      ProfileView(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: _buildAnimatedNotchBar(),
    );
  }

  Widget _buildAnimatedNotchBar() {
    return AnimatedNotchBottomBar(
      notchColor: Colors.blue,
      bottomBarItems: [
        BottomBarItem(
          inActiveItem: Icon(Iconsax.home_2_copy, color: Colors.grey),
          activeItem: Icon(Iconsax.home_2, color: Colors.white),
          itemLabel: 'Home',
        ),
        BottomBarItem(
          inActiveItem: Icon(Iconsax.scan, color: Colors.grey),
          activeItem: Icon(Iconsax.scan, color: Colors.white),
          itemLabel: 'Profile',
        ),
        BottomBarItem(
          inActiveItem: Icon(Iconsax.user, color: Colors.grey),
          activeItem: Icon(Iconsax.user, color: Colors.white),
          itemLabel: 'Profile',
        ),
      ],
      onTap: controller.changeTab,
      notchBottomBarController: NotchBottomBarController(index: 1),
      kIconSize: 24,
      kBottomRadius: 15,
      color: Colors.white,
      showShadow: true,
      bottomBarWidth: 300,
      showLabel: true,
      elevation: 0,
      shadowElevation: 0,
    );
  }
}
