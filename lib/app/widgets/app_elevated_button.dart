import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  const AppElevatedButton({
    super.key,
    this.onPressed,
    required this.label,
    this.backgroundColor = AppColors.purple500,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed  ,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50),
        elevation: 0,
      ),
      child: Text(
        label,
        style: textStyle ??
            AppTextStyles.labelLarge.copyWith(
              color: AppColors.white,
            ),
      ),
    );
  }
}
