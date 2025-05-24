// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function()? onSuffixIconPressed;

  const AppTextFormField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.onSuffixIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.gray600),
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: AppTextStyles.bodyMedium,
          cursorHeight: 20,
          decoration: InputDecoration(
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: onSuffixIconPressed,
                      icon: Icon(
                        size: 20,
                        suffixIcon,
                      ))
                  : null,
              suffixIconColor: AppColors.purple500,
              prefixIconColor: AppColors.purple500,
              contentPadding: EdgeInsets.all(12),
              prefixIcon:
                  prefixIcon != null ? Icon(size: 20, prefixIcon) : null,
              hintText: hintText,
              hintStyle: AppTextStyles.bodyMedium,
              labelStyle: AppTextStyles.bodyMedium,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.gray400, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.purple400, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.gray400, width: 1),
                borderRadius: BorderRadius.circular(8),
              )),
          validator: validator,
        ),
      ],
    );
  }
}
