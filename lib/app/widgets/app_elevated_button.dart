import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  const AppElevatedButton({
    super.key,
    this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.purple500,
        minimumSize: const Size(double.infinity, 50),
        elevation: 0,
      ),
      child: Text(
        label,
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }
}
