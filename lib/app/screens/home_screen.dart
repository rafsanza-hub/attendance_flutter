import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F3F8),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.gray200,
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12)
                  .copyWith(top: MediaQuery.of(context).padding.top + 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // User Info
                  Row(
                    children: [
                      // Profile Picture
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/profile.jpg'),
                            fit: BoxFit.cover,
                          ),
                          shape: CircleBorder(),
                        ),
                      ),
                      const SizedBox(width: 9),
                      // Name and Title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rafsan Zaini Anwar',
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: AppColors.gray900,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Placeholder for verified badge or icon
                              Container(
                                width: 20,
                                height: 20,
                                child: const Icon(
                                  Iconsax.verify,
                                  size: 20,
                                  color: AppColors.purple500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Junior Full Stack Developer',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.purple500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Action Icons
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const ShapeDecoration(
                          color: AppColors.purple50,
                          shape: CircleBorder(),
                        ),
                        child: const Icon(
                          Iconsax.message_2,
                          size: 24,
                          color: AppColors.purple500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const ShapeDecoration(
                          color: AppColors.purple50,
                          shape: CircleBorder(),
                        ),
                        child: const Icon(
                          Iconsax.notification,
                          size: 24,
                          color: AppColors.purple500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Work Summary Card
                  Container(
                    width: double.infinity,
                    height: 96,
                    decoration: BoxDecoration(
                      color: AppColors.purple500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        // Text Content
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Work Summary',
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Today task & presence activity',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.purple100,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Placeholder Image
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 101,
                            height: 85,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/cctv.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Decorative Circles
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Today Meeting Section
                  Container(
                    width: double.infinity,
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
                        Row(
                          children: [
                            Text(
                              'Today Meeting',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: AppColors.gray900,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.purple100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.purple500,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Your schedule for the day',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Meeting Item 1
                        _buildMeetingItem(
                          title: 'Townhall Meeting',
                          time: '01:30 AM - 02:00 AM',
                          avatars: [
                            'https://placehold.co/24x24',
                            'https://placehold.co/24x24',
                            'https://placehold.co/24x24',
                          ],
                          onJoin: () {},
                        ),
                        const SizedBox(height: 12),
                        // Meeting Item 2
                        _buildMeetingItem(
                          title: 'Dashboard Report',
                          time: '01:30 AM - 02:00 AM',
                          avatars: [
                            'https://placehold.co/24x24',
                            'https://placehold.co/24x24',
                            'https://placehold.co/24x24',
                          ],
                          onJoin: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Today Task Section
                  Container(
                    width: double.infinity,
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
                        Row(
                          children: [
                            Text(
                              'Today Task',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: AppColors.gray900,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.purple100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.purple500,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'The tasks assigned to you for today',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Task Item
                        _buildTaskItem(
                          title: 'Wiring Dashboard Analytics',
                          status: 'In Progress',
                          priority: 'High',
                          avatars: [
                            'https://placehold.co/24x24',
                            'https://placehold.co/24x24',
                            'https://placehold.co/24x24',
                          ],
                          progress: 0.85,
                          dueDate: '27 April',
                          comments: '2',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingItem({
    required String title,
    required String time,
    required List<String> avatars,
    required VoidCallback onJoin,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Icon
              Container(
                width: 24,
                height: 24,
                decoration: const ShapeDecoration(
                  color: AppColors.purple500,
                  shape: CircleBorder(),
                ),
                child: const Icon(
                  Iconsax.calendar_copy,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 6),
              // Title
              SizedBox(
                width: 140,
                child: Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.gray900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              // Time
              Row(
                children: [
                  const Icon(
                    Iconsax.clock_copy,
                    size: 16,
                    color: AppColors.gray600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    time,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.gray600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatars
              Row(
                children: [
                  ...avatars.take(3).map((url) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(url),
                              fit: BoxFit.cover,
                            ),
                            shape: const CircleBorder(
                              side: BorderSide(
                                width: 0.92,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                  if (avatars.length > 3)
                    Text(
                      '+${avatars.length - 3}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.gray900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              // Join Button
              ElevatedButton(
                onPressed: onJoin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple600,
                  foregroundColor: AppColors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  minimumSize: const Size(74, 24),
                ),
                child: Text(
                  'Join Meet',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem({
    required String title,
    required String status,
    required String priority,
    required List<String> avatars,
    required double progress,
    required String dueDate,
    required String comments,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const ShapeDecoration(
                  color: AppColors.purple500,
                  shape: CircleBorder(),
                ),
                child: const Icon(
                  Iconsax.task_copy,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 280,
                child: Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.gray900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Status and Priority
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Iconsax.clock,
                      size: 10,
                      color: AppColors.gray300,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      status,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.gray600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.error500,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Iconsax.flag,
                      size: 10,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      priority,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.purple500,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Avatars and Metadata
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ...avatars.take(3).map((url) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(url),
                              fit: BoxFit.cover,
                            ),
                            shape: const CircleBorder(
                              side: BorderSide(
                                width: 0.92,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Iconsax.calendar_2,
                          size: 16,
                          color: AppColors.gray300,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          dueDate,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.gray900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Iconsax.message,
                          size: 16,
                          color: AppColors.gray300,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          comments,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.gray900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
