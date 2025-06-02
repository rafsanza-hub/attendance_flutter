import 'package:attendance_flutter/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:attendance_flutter/app/routes/app_pages.dart';
import 'package:attendance_flutter/app/screens/clock_in_screen.dart';
import 'package:attendance_flutter/app/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F3F8),
      body: Stack(
        children: [
          // Header Gradient
          Container(
            width: double.infinity,
            height: 233,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.purple500,
                  AppColors.purple600,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 17,
                  top: 57,
                  child: Container(
                    width: 101,
                    height: 85,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/clock.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Time Display

                // Header Text
                Positioned(
                  left: 28,
                  top: 71,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Let’s Clock-In!',
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Don’t miss your clock in schedule',
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
                // Total Working Hour Card
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
                          'Total Working Hour',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.gray900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Paid Period 1 Sept 2024 - 30 Sept 2024',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Stats
                        Row(
                          children: [
                            // Today
                            Expanded(
                              child: Container(
                                height: 72,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.gray25,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.gray50),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Iconsax.clock_copy,
                                          size: 16,
                                          color: AppColors.gray600,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Today',
                                          style:
                                              AppTextStyles.bodySmall.copyWith(
                                            color: AppColors.gray600,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '00:00 Hrs',
                                      style: AppTextStyles.titleLarge.copyWith(
                                        color: AppColors.gray900,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // This Pay Period
                            Expanded(
                              child: Container(
                                height: 72,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.gray25,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.gray50),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Iconsax.calendar_copy,
                                          size: 16,
                                          color: AppColors.gray600,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'This Pay Period',
                                          style:
                                              AppTextStyles.bodySmall.copyWith(
                                            color: AppColors.gray600,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '32:00 Hrs',
                                      style: AppTextStyles.titleLarge.copyWith(
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
                        const SizedBox(height: 12),
                        // Clock In Button
                        AppElevatedButton(
                          label: 'Clock In',
                          onPressed: () {
                            Get.toNamed(Routes.CLOCK_IN);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Attendance Records
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.attendances.length,
                          itemBuilder: (context, index) {
                            final attendance = controller.attendances[index];
                            return _buildAttendanceRecord(
                              date: '27 September 2024',
                              totalHours: '${attendance.checkIn!.hour} hrs',
                              clockInOut:
                                  '${attendance.checkIn!.hour}:${attendance.checkIn!.minute}  —  ${attendance.checkOut ?? '-'}',
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16)),
                      // Record 1
                      _buildAttendanceRecord(
                        date: '27 September 2024',
                        totalHours: '08:00:00 hrs',
                        clockInOut: '09:00 AM  — 05:00 PM',
                      ),
                      const SizedBox(height: 16),
                      // Record 2
                      _buildAttendanceRecord(
                        date: '26 September 2024',
                        totalHours: '08:00:00 hrs',
                        clockInOut: '09:00 AM  — 05:00 PM',
                      ),
                      const SizedBox(height: 16),
                      // Record 3
                      _buildAttendanceRecord(
                        date: '25 September 2024',
                        totalHours: '08:10:00 hrs',
                        clockInOut: '09:00 AM  — 05:10 PM',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceRecord({
    required String date,
    required String totalHours,
    required String clockInOut,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gray200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Total Hours
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Hours',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.gray600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      totalHours,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.gray500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // Clock In & Out
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clock in & Out',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.gray600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      clockInOut,
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
        ],
      ),
    );
  }
}
