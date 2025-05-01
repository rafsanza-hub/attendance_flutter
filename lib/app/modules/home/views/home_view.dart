import 'package:attendance_flutter/app/modules/attendance/views/attendance_view.dart';
import 'package:attendance_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:attendance_flutter/app/modules/login/views/login_view.dart';
import 'package:attendance_flutter/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            AttendanceView(),
            LoginView(),
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
              icon: Icon(Iconsax.call_incoming),
              selectedIcon: Icon(Iconsax.call_incoming5),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.call_incoming),
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
