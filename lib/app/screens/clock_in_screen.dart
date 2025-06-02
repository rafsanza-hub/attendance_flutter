import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';
import 'package:attendance_flutter/app/screens/selfie_screen.dart';
import 'package:attendance_flutter/app/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:latlong2/latlong.dart';

class ClockInScreen extends StatelessWidget {
  const ClockInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              child: SizedBox(
                height: 600,
                child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(-6.956060, 108.452004),
                      initialZoom: 19,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(markers: [
                        Marker(
                          width: 200.0,
                          height: 200.0,
                          point: LatLng(-6.956060, 108.452004),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.purple500.withValues(alpha: 0.2),
                              border: Border.all(color: AppColors.purple500),
                            ),
                          ),
                        )
                      ])
                    ]),
              ),
            ),
            Positioned(
              bottom: 79 + MediaQuery.of(context).padding.bottom,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFEFEFE),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 24, bottom: 18, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Clock In Card
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
                                    'You are in the clock-in area!',
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Now you can press clock in in this area',
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
                              right: -20,
                              bottom: -5,
                              child: Container(
                                width: 101,
                                height: 85,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/clock.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            // Decorative Circles
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Profile Card

                      Text(
                        'Profile',
                        style: AppTextStyles.labelMedium,
                      ),
                      SizedBox(height: 6.5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10.5,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: AppColors.gray100,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: AppColors.gray200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10,
                          children: [
                            // Image
                            Container(
                              width: 64,
                              height: 64,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/profile.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name
                                Row(
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Rafsan Zaini Anwar',
                                      style: AppTextStyles.titleMedium.copyWith(
                                        color: const Color(0xFF2D2D2D),
                                      ),
                                    ),
                                    Icon(
                                      Iconsax.verify,
                                      size: 16,
                                      color: AppColors.purple500,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 2),

                                // Date
                                SizedBox(
                                  width: 123,
                                  child: Text(
                                    '29 September 2024',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.purple500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),

                                // Location
                                Row(
                                  spacing: 4,
                                  children: [
                                    Icon(
                                      Iconsax.location_tick,
                                      size: 12,
                                      color: AppColors.purple500,
                                    ),
                                    Text(
                                      'Lat 45.43534 Long 97897.576',
                                      style: AppTextStyles.labelMedium.copyWith(
                                        color: AppColors.gray600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                      SizedBox(height: 15),

                      // Schedule Cards
                      Text(
                        'Schedule',
                        style: AppTextStyles.labelMedium,
                      ),
                      SizedBox(height: 8),
                      // Clock In Button
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 13),
                            decoration: ShapeDecoration(
                              color: AppColors.gray100,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: AppColors.gray200,
                                  strokeAlign: BorderSide.strokeAlignInside,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Clock In',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.gray500,
                                  ),
                                ),
                                Text(
                                  '08:00 AM',
                                  style: AppTextStyles.headlineSmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.5,
                                    height: null,
                                    color: AppColors.black,
                                  ),
                                )
                              ],
                            ),
                          )),

                          // Clock Out Card
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 13),
                              decoration: ShapeDecoration(
                                color: AppColors.gray100,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: AppColors.gray200,
                                    strokeAlign: BorderSide.strokeAlignInside,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Clock Out',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.gray500,
                                    ),
                                  ),
                                  Text(
                                    '05:00 PM',
                                    style: AppTextStyles.headlineSmall.copyWith(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.5,
                                      height: null,
                                      color: AppColors.black,
                                    ),
                                  )
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
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 79 + MediaQuery.of(context).padding.bottom,
                decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14)
                      .copyWith(
                          bottom: MediaQuery.of(context).padding.bottom + 14),
                  child: AppElevatedButton(
                    label: 'Selfie To Clock In',
                    onPressed: () {
                      Get.to(() => SelfieScreen());
                    },
                    backgroundColor: AppColors.purple500,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.5),
                child: Row(
                  children: [
                    InkWell(
                      radius: 30,
                      onTap: () => Get.back(),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: AppColors.purple50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          size: 16,
                          Iconsax.arrow_left_2_copy,
                          color: AppColors.purple500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Clock In Area',
                        style: AppTextStyles.titleLarge.copyWith(
                          fontSize: 18,
                          height: null,
                          letterSpacing: -0.5,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
