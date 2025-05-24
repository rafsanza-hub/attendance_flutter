import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';
import 'package:attendance_flutter/app/screens/profile_screen.dart';
import 'package:attendance_flutter/app/widgets/app_elevated_button.dart';
import 'package:attendance_flutter/app/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            SizedBox(height: 44),
            Container(
              height: 56,
              width: 56,
              color: AppColors.purple500,
            ),
            SizedBox(height: 12),
            Text(
              'Work Mate',
              style: AppTextStyles.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                height: 26 / 20,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Register Using Your Credentials',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 12,
                height: 14 / 12,
              ),
            ),
            SizedBox(height: 24),
            Form(
              child: Column(
                children: [
                  AppTextFormField(
                    labelText: 'Email',
                    prefixIcon: Iconsax.sms_copy,
                    hintText: 'Enter your email',
                  ),
                  SizedBox(height: 16),
                  AppTextFormField(
                    labelText: 'Phone Number',
                    prefixIcon: Iconsax.call_copy,
                    hintText: 'Enter your phone number',
                  ),
                  SizedBox(height: 16),
                  AppTextFormField(
                    labelText: 'Company ID',
                    prefixIcon: Iconsax.sms_copy,
                    hintText: 'Enter your email',
                  ),
                  SizedBox(height: 16),
                  AppTextFormField(
                    labelText: 'Password',
                    prefixIcon: Iconsax.finger_scan_copy,
                    hintText: 'Enter your password',
                  ),
                  SizedBox(height: 16),
                  AppTextFormField(
                    labelText: 'Confirm Password',
                    prefixIcon: Iconsax.finger_scan_copy,
                    hintText: 'Confirm your password',
                  ),
                  SizedBox(height: 36),
                  AppElevatedButton(
                    label: 'Sign Up',
                    onPressed: () {
                      Get.to(ProfileScreen());
                    },
                  ),
                  SizedBox(height: 73),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.labelSmall,
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: AppTextStyles.labelSmall
                                .copyWith(color: AppColors.gray600),
                          ),
                          TextSpan(
                            text: 'Sign in h  ere',
                            style: AppTextStyles.labelSmall
                                .copyWith(color: AppColors.purple500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(RegisterScreen()),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
