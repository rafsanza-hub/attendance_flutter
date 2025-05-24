// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 460,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.19,
                  1,
                ],
                colors: [
                  AppColors.purple500,
                  AppColors.white,
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                color: AppColors.white,
                width: double.infinity,
                height: 636,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
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
                    SizedBox(height: 24),
                    AppTextFormField(
                      labelText: 'Email',
                      prefixIcon: Iconsax.sms_copy,
                      hintText: 'Enter your email',
                    ),
                    SizedBox(height: 12),
                    AppTextFormField(
                      labelText: 'Email',
                      prefixIcon: Iconsax.finger_scan_copy,
                      hintText: 'Enter your password',
                      suffixIcon: Iconsax.eye_slash_copy,
                      onSuffixIconPressed: () {},
                    ),
                    SizedBox(height: 12),
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
                        SizedBox(width: 8),
                        Text(
                          'Remember Me',
                          style: AppTextStyles.bodySmall,
                        ),
                        Spacer(),
                        Text(
                          'Forgot Password',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.purple500),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    AppElevatedButton(
                      label: 'Sign In',
                      onPressed: () {},
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(width: 16),
                        Text(
                          'OR',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.gray400),
                        ),
                        SizedBox(width: 16),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 32),
                    AppOutlinedButton(
                      label: 'Sign in With Employee ID',
                      icon: Iconsax.user_octagon,
                      onPressed: () {},
                    ),
                    SizedBox(height: 12),
                    AppOutlinedButton(
                      label: 'Sign in With Employee ID',
                      icon: Iconsax.user_octagon,
                      onPressed: () {},
                    ),
                    SizedBox(height: 22),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.labelSmall,
                          children: [
                            TextSpan(
                              text: 'Don’t have an account? ',
                              style: AppTextStyles.labelSmall
                                  .copyWith(color: AppColors.gray600),
                            ),
                            TextSpan(
                              text: 'Sign Up Here',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
