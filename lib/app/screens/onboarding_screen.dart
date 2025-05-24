import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';
import 'package:attendance_flutter/app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 86),
                  SizedBox(
                    height: 550,
                    child: PageView(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        clipBehavior: Clip.none,
                        children: [
                          _buildOnboard(),
                          _buildOnboard(),
                          _buildOnboard(),
                        ]),
                  ),
                  SizedBox(height: 23),
                  SmoothPageIndicator(
                    controller: PageController(initialPage: 0),
                    onDotClicked: (index) {},
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotColor: Color(0XFFD9D9D9),
                      activeDotColor: AppColors.purple500,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  SizedBox(height: 35),
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
                  SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(color: AppColors.purple500),
                      elevation: 0,
                    ),
                    child: Text(
                      'Skip',
                      style: AppTextStyles.labelLarge
                          .copyWith(color: AppColors.purple500),
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

  Column _buildOnboard() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            // color: Colors.yellow,
            height: 374,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: -13,
                  left: -41,
                  child: SvgPicture.asset(
                    'assets/svg/onboarding1.svg',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/svg/onboarding11.svg',
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 48),
        Text(
          'Welcome to Workmate!',
          style: AppTextStyles.headlineSmall,
        ),
        SizedBox(height: 12),
        Text(
          'Make Smart Decisions! Set clear timelines for projects and celebrate your achievements!',
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OnboardingController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  final currentIndex = 0.obs;

  void onPageChanged(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentIndex.value = index;
  }
}
