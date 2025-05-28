import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';
import 'package:attendance_flutter/app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            height: 1000,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.purple500,
                  AppColors.purple300,
                ],
              ),
            ),
          ),

          // Main Content
          Positioned.fill(
            top: 135 + 44,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: Container(
                color: AppColors.white,
                padding: const EdgeInsets.only(top: 69, left: 24, right: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Info
                      Text(
                        'Rafsan Zaini Anwar',
                        style: AppTextStyles.titleLarge.copyWith(
                          fontSize: 18,
                          height: null,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Junior Full Stack Developer',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.purple500,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Sections
                      _buildSection(
                        title: 'CONTACT',
                        items: [
                          _buildItem(Iconsax.sms, 'Tonald@gmail.com'),
                          _buildItem(Iconsax.location, 'Taman Anggrek'),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildSection(
                        title: 'ACCOUNT',
                        items: [
                          _buildItem(Iconsax.user, 'Personal Data'),
                          _buildItem(Iconsax.box, 'Office Assets'),
                          _buildItem(Iconsax.money, 'Payroll & Tax'),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildSection(
                        title: 'SETTINGS',
                        items: [
                          _buildItem(Iconsax.lock, 'Change Password'),
                          _buildItem(Iconsax.info_circle, 'Versioning'),
                          _buildItem(Iconsax.message_question, 'FAQ and Help'),
                          _buildItem(Iconsax.logout, 'Logout',
                              iconColor: Color(0xFFF14E4E)),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Profile Picture
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/profile.jpg"),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 2,
                    color: AppColors.white,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // AppBar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    radius: 30,
                    onTap: () => Get.to(MainScreen()),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        size: 16,
                        Iconsax.arrow_left_2_copy,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'My Profile',
                      style: AppTextStyles.titleLarge.copyWith(
                        fontSize: 18,
                        height: null,
                        letterSpacing: -0.5,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.labelMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.gray700,
            height: null,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20 - 12),
          decoration: BoxDecoration(
            color: Color(0xFFF4F6F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(IconData icon, String text,
      {Color? iconColor = AppColors.purple500}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.gray600,
              ),
            ),
          ),
          Icon(
            Iconsax.arrow_right_3_copy,
            size: 16,
            color: Color(0xFFB6C2D7),
          ),
        ],
      ),
    );
  }
}
