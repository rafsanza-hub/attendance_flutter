import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'dart:ui'; // Kept for ImageFilter.blur

import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';

class SelectSheet extends StatefulWidget {
  final TextEditingController controller;
  final List<String> options;

  final String title;
  final String subTitle;

  const SelectSheet({
    super.key,
    required this.controller,
    required this.options,
    required this.title,
    required this.subTitle,
  });

  static void show(
    BuildContext context, {
    required TextEditingController controller,
    required List<String> options,
    required String title,
    required String subTitle,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.purple500.withOpacity(0.1),
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: SelectSheet(
          title: title,
          subTitle: subTitle,
          controller: controller,
          options: options,
        ),
      ),
    );
  }

  @override
  State<SelectSheet> createState() => _SelectSheetState();
}

class _SelectSheetState extends State<SelectSheet> {
  void onSelect(String delegation) {
    widget.controller.text = delegation;
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border(
          top: BorderSide(color: AppColors.gray200, width: 1),
          left: BorderSide(color: AppColors.gray200, width: 1),
          right: BorderSide(color: AppColors.gray200, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            widget.title,
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.subTitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.gray500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          ...widget.options.map(
            (option) {
              return _DelegationOption(
                name: option,
                onTap: onSelect,
                selectedTitle: widget.controller.text,
              );
            },
          ).toList(),

          SizedBox(height: 30)
        ],
      ),
    );
  }
}

class _DelegationOption extends StatefulWidget {
  final String name;
  final Function(String)? onTap;
  final String selectedTitle;

  const _DelegationOption({
    required this.name,
    required this.onTap,
    required this.selectedTitle,
  });

  @override
  State<_DelegationOption> createState() => _DelegationOptionState();
}

class _DelegationOptionState extends State<_DelegationOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            setState(() {
              widget.onTap!(widget.name);
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: widget.selectedTitle == widget.name
                ? AppColors.purple50
                : AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: widget.selectedTitle == widget.name
                    ? AppColors.purple500
                    : AppColors.gray400),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${widget.name}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.gray900,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: widget.selectedTitle == widget.name
                      ? AppColors.purple500
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.gray400,
                    width: 1,
                  ),
                ),
                child: Icon(
                  widget.selectedTitle == widget.name ? Icons.check : null,
                  size: 16,
                  color: AppColors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
