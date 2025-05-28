import 'dart:ui';

import 'package:attendance_flutter/app/screens/register_screen.dart';
import 'package:attendance_flutter/app/widgets/app_elevated_button.dart';
import 'package:attendance_flutter/app/widgets/app_outlined_button.dart';
import 'package:attendance_flutter/app/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Sign In',
              style: AppTextStyles.headlineSmall,
            ),
          ),
          Center(
            child: Text(
              'Sign in to my account',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.gray600,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const AppTextFormField(
            labelText: 'Email',
            prefixIcon: Iconsax.sms_copy,
            hintText: 'Enter your email',
          ),
          const SizedBox(height: 12),
          const AppTextFormField(
            labelText: 'Password',
            prefixIcon: Iconsax.finger_scan_copy,
            hintText: 'Enter your password',
            suffixIcon: Iconsax.eye_slash_copy,
            obscureText: true,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 0.8,
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: Checkbox(
                    value: true,
                    onChanged: (value) {},
                    activeColor: AppColors.purple50,
                    checkColor: AppColors.purple500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => BorderSide(
                        color: AppColors.purple500,
                        strokeAlign: 1,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Remember Me',
                style: AppTextStyles.bodySmall,
              ),
              const Spacer(),
              Text(
                'Forgot Password',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.purple500),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppElevatedButton(
            label: 'Sign In',
            onPressed: () {},
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              const Expanded(child: Divider()),
              const SizedBox(width: 16),
              Text(
                'OR',
                style:
                    AppTextStyles.bodySmall.copyWith(color: AppColors.gray400),
              ),
              const SizedBox(width: 16),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 32),
          AppOutlinedButton(
            label: 'Sign in With Employee ID',
            icon: Iconsax.user_octagon,
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          AppOutlinedButton(
            label: 'Sign in With Fingerprint',
            icon: Iconsax.finger_scan_copy,
            onPressed: () {},
          ),
          const SizedBox(height: 22),
          Center(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.labelSmall,
                children: [
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.gray600),
                  ),
                  TextSpan(
                    text: 'Sign Up Here',
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.purple500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context); // Close the bottom sheet
                        Get.to(const RegisterScreen());
                      },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
        ],
      ),
    );
  }

  // Helper
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.purple500.withOpacity(0.1),
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: LoginBottomSheet()),
    );
  }
}
