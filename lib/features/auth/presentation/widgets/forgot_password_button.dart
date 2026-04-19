import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key, required this.onTap, required this.label,
  });
  final GestureTapCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}