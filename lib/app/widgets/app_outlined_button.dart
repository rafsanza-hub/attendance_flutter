import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:attendance_flutter/app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppOutlinedButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final IconData? icon;
  const AppOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(color: AppColors.purple500),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null
              ? Icon(
                  Iconsax.user_octagon,
                  color: AppColors.purple500,
                  size: 24,
                )
              : SizedBox(),
          SizedBox(width: 8),
          Text(
            label,
            style:
                AppTextStyles.labelLarge.copyWith(color: AppColors.purple500),
          ),
        ],
      ),
    );
  }
}
