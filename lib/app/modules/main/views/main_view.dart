import 'package:attendance_flutter/app/modules/attendance/views/attendance_view.dart';
import 'package:attendance_flutter/app/modules/dashboard/views/dashboard_view.dart';
import 'package:attendance_flutter/app/modules/main/controllers/main_controller.dart';
import 'package:attendance_flutter/app/modules/login/views/login_view.dart';
import 'package:attendance_flutter/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            DashboardView(),
            AttendanceView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) => controller.changeTab(value),
          elevation: 0,
          destinations: [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              selectedIcon: Icon(Iconsax.home_15),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.clock),
              selectedIcon: Icon(Iconsax.call_incoming5),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.profile_circle),
              label: 'Home',
              selectedIcon: Icon(Iconsax.profile_circle5),
            ),
          ],
        );
      }),
    );
  }
}
