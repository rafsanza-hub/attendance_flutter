import 'package:attendance_flutter/app/modules/submit_leave/controllers/submit_leave_controller.dart';
import 'package:attendance_flutter/app/widgets/app_elevated_button.dart';
import 'package:attendance_flutter/app/widgets/app_outlined_button.dart';
import 'package:attendance_flutter/app/widgets/app_text_field.dart';
import 'package:attendance_flutter/app/widgets/select_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SubmitLeaveView extends GetView<SubmitLeaveController> {
  const SubmitLeaveView({super.key});

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
                      'Submit Leave',
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
                  child: Form(
                    key: controller.formKey,
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
                          validator: controller.validateCategory,
                        ),
                        const SizedBox(height: 16),
                        // Leave Duration
                        AppTextFormField(
                          labelText: 'Leave Duration',
                          controller: controller.durationC,
                          readOnly: true,
                          hintText: 'Select Duration',
                          prefixIcon: Iconsax.calendar_2,
                          suffixIcon: Iconsax.arrow_down_1_copy,
                          onTap: () async {
                            await showModalBottomSheet(
                              backgroundColor: AppColors.white,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(24).copyWith(
                                      top: 32,
                                      bottom: MediaQuery.of(context)
                                          .padding
                                          .bottom),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Leave Duration',
                                        style:
                                            AppTextStyles.titleLarge.copyWith(
                                          color: AppColors.gray900,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Select Leave Duration',
                                        style:
                                            AppTextStyles.bodyMedium.copyWith(
                                          color: AppColors.gray500,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SfDateRangePicker(
                                        onSelectionChanged:
                                            (DateRangePickerSelectionChangedArgs
                                                args) {
                                          if (args.value is PickerDateRange &&
                                              args.value.startDate != null &&
                                              args.value.endDate != null) {
                                            controller.startDateTemp =
                                                args.value.startDate;
                                            controller.endDateTemp =
                                                args.value.endDate;
                                          }

                                          if (args.value is DateTime) {
                                            controller.startDateTemp =
                                                args.value as DateTime;
                                            controller.endDateTemp =
                                                args.value as DateTime;
                                          }
                                        },
                                        view: DateRangePickerView.month,
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                        viewSpacing: 1,
                                        backgroundColor: AppColors.white,
                                        confirmText: 'Submit',
                                        monthViewSettings:
                                            DateRangePickerMonthViewSettings(
                                          showTrailingAndLeadingDates: true,
                                          dayFormat: 'EEE',
                                          viewHeaderHeight: 33,
                                          viewHeaderStyle:
                                              DateRangePickerViewHeaderStyle(
                                            // backgroundColor: AppColors.gray200,
                                            textStyle: AppTextStyles.labelLarge
                                                .copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                        headerStyle: DateRangePickerHeaderStyle(
                                          backgroundColor: AppColors.white,
                                          textStyle: AppTextStyles.titleMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        monthCellStyle:
                                            DateRangePickerMonthCellStyle(
                                          textStyle:
                                              AppTextStyles.labelLarge.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        headerHeight: 24 + 21 + 21,
                                        maxDate: DateTime(2030),
                                        minDate: DateTime(2025),
                                        enablePastDates: false,
                                        startRangeSelectionColor:
                                            AppColors.purple500,
                                        endRangeSelectionColor:
                                            AppColors.purple500,
                                        selectionTextStyle:
                                            AppTextStyles.labelLarge.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      SizedBox(height: 21),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppElevatedButton(
                                              label: 'Submit Date',
                                              onPressed: () {
                                                controller.startDate =
                                                    controller.startDateTemp;
                                                controller.endDate =
                                                    controller.endDateTemp;
                                                controller.durationC.text =
                                                    '${DateFormat('dd MMM yyyy').format(controller.startDateTemp)} - ${DateFormat('dd MMM yyyy').format(controller.endDateTemp)}';
                                                Get.back();
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 14),
                                          Expanded(
                                            child: AppOutlinedButton(
                                              label: 'Close',
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          validator: controller.validateDuration,
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
                          validator: controller.validateTaskDelegation,
                        ),
                        const SizedBox(height: 16),
                        // Emergency Contact
                        AppTextFormField(
                          labelText: 'Emergency Contact During Leave Period',
                          hintText: '+62 82150005000',
                          prefixIcon: Iconsax.call_copy,
                          validator: controller.validateEmergencyContact,
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
                                    color: AppColors.gray900
                                        .withValues(alpha: 0.05),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: controller.descriptionC,
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
                                validator: controller.validateDescription,
                              ),
                            ),
                            const SizedBox(height: 24),
                            AppElevatedButton(
                              label: 'Submit Now',
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.submitLeave();
                                }
                              },
                            )
                          ],
                        ),
                      ],
                    ),
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

  // Widget _buildFormField({
  //   required String label,
  //   required String value,
  //   required IconData icon,
  //   IconData? trailingIcon,
  //   String? prefixText,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: AppTextStyles.bodySmall.copyWith(
  //           color: AppColors.gray600,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       const SizedBox(height: 4),
  //       Container(
  //         height: 44,
  //         padding: const EdgeInsets.symmetric(horizontal: 12),
  //         decoration: BoxDecoration(
  //           color: AppColors.white,
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: AppColors.gray400),
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColors.gray900.withOpacity(0.05),
  //               blurRadius: 2,
  //               offset: const Offset(0, 1),
  //             ),
  //           ],
  //         ),
  //         child: Row(
  //           children: [
  //             Icon(
  //               icon,
  //               size: 20,
  //               color: AppColors.gray600,
  //             ),
  //             const SizedBox(width: 10),
  //             if (prefixText != null) ...[
  //               Text(
  //                 prefixText,
  //                 style: AppTextStyles.bodyMedium.copyWith(
  //                   color: AppColors.gray900,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //               const SizedBox(width: 4),
  //               Icon(
  //                 Iconsax.arrow_right_3_copy,
  //                 size: 20,
  //                 color: AppColors.gray600,
  //               ),
  //               const SizedBox(width: 4),
  //             ],
  //             Expanded(
  //               child: Text(
  //                 value,
  //                 style: AppTextStyles.bodyMedium.copyWith(
  //                   color: value.contains('Select') || value.contains('+62')
  //                       ? AppColors.gray400
  //                       : AppColors.gray900,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ),
  //             if (trailingIcon != null)
  //               Icon(
  //                 trailingIcon,
  //                 size: 20,
  //                 color: AppColors.gray600,
  //               ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
