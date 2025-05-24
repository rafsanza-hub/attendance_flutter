import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
                  Text(
                    'Email',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.gray600),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    style: AppTextStyles.bodyMedium,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        prefixIcon: Icon(size: 20, Iconsax.sms_copy),
                        hintText: 'Enter your email',
                        hintStyle: AppTextStyles.bodyMedium,
                        labelStyle: AppTextStyles.bodyMedium,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.gray400, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.purple400, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.gray400, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Password',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.gray600),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    style: AppTextStyles.bodyMedium,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        prefixIcon: Icon(size: 20, Iconsax.sms_copy),
                        hintText: 'Enter your email',
                        hintStyle: AppTextStyles.bodyMedium,
                        labelStyle: AppTextStyles.bodyMedium,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.gray400, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.purple400, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.gray400, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        )),
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
                  ElevatedButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple500,
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 0,
                    ),
                    child: Text(
                      'Next',
                      style: AppTextStyles.labelLarge
                          .copyWith(color: AppColors.white),
                    ),
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
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(color: AppColors.purple500),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.user_octagon,
                          color: AppColors.purple500,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Sign in With Employee ID',
                          style: AppTextStyles.labelLarge
                              .copyWith(color: AppColors.purple500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(color: AppColors.purple500),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.user_octagon,
                          color: AppColors.purple500,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Sign in With Employee ID',
                          style: AppTextStyles.labelLarge
                              .copyWith(color: AppColors.purple500),
                        ),
                      ],
                    ),
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
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
