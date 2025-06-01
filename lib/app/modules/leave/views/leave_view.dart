import 'package:attendance_flutter/app/modules/leave/controllers/leave_controller.dart';
import 'package:attendance_flutter/app/screens/leave_form_screen.dart';
import 'package:attendance_flutter/app/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';

class LeaveView extends GetView<LeaveController> {
  const LeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F3F8),
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            // Header Gradient
            Container(
              width: double.infinity,
              height: 233,
              decoration: BoxDecoration(
                color: AppColors.purple500,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: MediaQuery.of(context).padding.top,
                    child: Container(
                      width: 101,
                      height: 85,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Time Display

                  // Header Text
                  Positioned(
                    left: 28,
                    top: 69,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Leave Summary',
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Submit Leave',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.purple200,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Main Content
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 148),
                  // Total Leave Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Text(
                            'Total Leave',
                            style: AppTextStyles.titleSmall.copyWith(
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Period 1 Jan 2024 - 30 Dec 2024',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.gray500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Stats
                          Row(
                            children: [
                              // Available
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12)
                                      .copyWith(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.gray25,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.gray50),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const ShapeDecoration(
                                              color: Color(0xFF19B36E),
                                              shape: CircleBorder(),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Available',
                                            style: AppTextStyles.labelMedium
                                                .copyWith(
                                              color: AppColors.gray600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '20',
                                        style:
                                            AppTextStyles.titleLarge.copyWith(
                                          color: AppColors.gray900,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Leave Used
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12)
                                      .copyWith(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.gray25,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.gray50),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const ShapeDecoration(
                                              color: AppColors.purple500,
                                              shape: CircleBorder(),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Leave Used',
                                            style: AppTextStyles.labelMedium
                                                .copyWith(
                                              color: AppColors.gray600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '2',
                                        style:
                                            AppTextStyles.titleLarge.copyWith(
                                          color: AppColors.gray900,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Filter Tabs
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Obx(() {
                        return Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.changeTab(0),
                                child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: controller.isTab1
                                        ? AppColors.purple500
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Review',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: controller.isTab1
                                            ? AppColors.white
                                            : AppColors.gray600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.changeTab(1),
                                child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: controller.isTab2
                                        ? AppColors.purple500
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Approved',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: controller.isTab2
                                            ? AppColors.white
                                            : AppColors.gray600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.changeTab(2),
                                child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: controller.isTab3
                                        ? AppColors.purple500
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Rejected',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: controller.isTab3
                                            ? AppColors.white
                                            : AppColors.gray600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Leave Record
                  _buildLeaveRecord(),
                ],
              ),
            ),
            // Floating Submit Leave Button
            Positioned(
              left: 12,
              right: 12,
              bottom: 16,
              child: AppElevatedButton(
                  label: 'Submit Leave',
                  onPressed: () {
                    Get.to(LeaveFormScreen());
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildLeaveRecord() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Iconsax.calendar_copy,
                  size: 20,
                  color: AppColors.gray600,
                ),
                const SizedBox(width: 4),
                Text(
                  '18 September 2024',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.gray900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.gray200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leave Date',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.gray500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '20 Sept - 22 Sept',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.gray500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Leave',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.gray500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '2 Days',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.gray500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Iconsax.tick_circle,
                      size: 16,
                      color: Color(0xFF19B36E),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Approved at 19 Sept 2024',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Color(0xFF19B36E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'By',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.gray900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.cover,
                        ),
                        shape: CircleBorder(
                          side: BorderSide(
                            width: 0.75,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Elaine',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.gray900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}