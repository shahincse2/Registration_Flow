import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';

class BuildDivider extends StatelessWidget {
  const BuildDivider({
    super.key, required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.white.withValues(alpha: 0.5),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            label,
            style: TextStyle(color: AppColors.white),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.white.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
