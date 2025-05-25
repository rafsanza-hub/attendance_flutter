import 'package:attendance_flutter/app/widgets/app_elevated_button.dart';
import 'package:attendance_flutter/app/widgets/app_text_field.dart';
import 'package:attendance_flutter/app/widgets/select_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';

class LeaveFormScreen extends GetView<LeaveFormController> {
  const LeaveFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F3F8),
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.5, vertical: 16)
                  .copyWith(top: MediaQuery.of(context).padding.top + 8),
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
          ),

          // Main Content
          Column(
            children: [
              const SizedBox(height: 16),

              // Leave Form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        'Fill Leave Information',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppColors.gray900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Information about leave details',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.gray500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Leave Category
                      AppTextFormField(
                        controller: controller.categoryC,
                        labelText: 'Leave Category',
                        prefixIcon: Iconsax.notification_status,
                        suffixIcon: Iconsax.arrow_down_1_copy,
                        hintText: 'Select Category',
                        readOnly: true,
                        onTap: () {
                          SelectSheet.show(
                            context,
                            controller: controller.categoryC,
                            options: controller.leaveCategories,
                            title: 'Leave Category',
                            subTitle: 'Select Leave Category',
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Leave Duration
                      AppTextFormField(
                        labelText: 'Leave Duration',
                        controller: TextEditingController(),
                        readOnly: true,
                        hintText: 'Select Date',
                        prefixIcon: Iconsax.calendar_2,
                        suffixIcon: Iconsax.arrow_down_1_copy,
                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2030),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Task Delegation
                      AppTextFormField(
                        readOnly: true,
                        labelText: 'Task Delegation',
                        controller: controller.taskDelegationC,
                        hintText: 'Select Category',
                        // value: 'Select Category',
                        prefixIcon: Iconsax.user_octagon,
                        suffixIcon: Iconsax.arrow_down_1_copy,
                        onTap: () {
                          SelectSheet.show(
                            context,
                            controller: controller.taskDelegationC,
                            options: controller.taskDelegations,
                            title: 'Task Delegation',
                            subTitle: 'Select Task Delegation',
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Emergency Contact
                      AppTextFormField(
                        labelText: 'Emergency Contact During Leave Period',
                        hintText: '+62 82150005000',
                        prefixIcon: Iconsax.call_copy,
                      ),
                      const SizedBox(height: 16),
                      // Leave Description
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Leave Description',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.gray600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 100,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.gray400),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gray900.withOpacity(0.05),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: 'Enter Leave Description',
                                hintStyle: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.gray400,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                              ),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.gray900,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          AppElevatedButton(
                            label: 'Submit Now',
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          // Floating Submit Button
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String value,
    required IconData icon,
    IconData? trailingIcon,
    String? prefixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.gray600,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.gray400),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray900.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.gray600,
              ),
              const SizedBox(width: 10),
              if (prefixText != null) ...[
                Text(
                  prefixText,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.gray900,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Iconsax.arrow_right_3_copy,
                  size: 20,
                  color: AppColors.gray600,
                ),
                const SizedBox(width: 4),
              ],
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: value.contains('Select') || value.contains('+62')
                        ? AppColors.gray400
                        : AppColors.gray900,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  size: 20,
                  color: AppColors.gray600,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeaveFormController extends GetxController {
  final TextEditingController categoryC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController dateC = TextEditingController();
  final TextEditingController timeC = TextEditingController();
  final TextEditingController taskDelegationC = TextEditingController();

  List<String> leaveCategories = [
    'Sick Leave',
    'Annual Leave',
    'Maternity Leave',
    'Paternity Leave',
    'Unpaid Leave',
  ];

  List<String> taskDelegations = [
    'Martin Deo',
    'John Doe',
    'Jane Doe',
  ];

  @override
  void onClose() {
    categoryC.dispose();
    descriptionC.dispose();
    dateC.dispose();
    timeC.dispose();
    taskDelegationC.dispose();
    super.onClose();
  }
}
