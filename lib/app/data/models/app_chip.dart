import 'package:attendance_flutter/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Color? shadowColor;
  const AppChip(
    this.title, {
    required this.isSelected,
    this.shadowColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: ShapeDecoration(
            color: isSelected ? AppColors.purple400 : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadows: [
              BoxShadow(
                color: shadowColor ?? Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Color(0xFF2E2E2E),
                  fontSize: 13,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  height: 1.38,
                  letterSpacing: -0.08,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
