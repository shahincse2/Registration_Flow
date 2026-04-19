import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';

class ButtonLoader extends StatelessWidget {
  const ButtonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: AppColors.white,
      ),
    );
  }
}