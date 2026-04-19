
import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';

class AppRichTextButton extends StatelessWidget {
  const AppRichTextButton({
    super.key,
    required this.onTap,
    required this.disableLabel,
    required this.activeLabel,
  });

  final GestureTapCallback onTap;
  final String disableLabel;
  final String activeLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: disableLabel,
              style: TextStyle(color: AppColors.white.withValues(alpha: 0.8)),
            ),
            TextSpan(
              text: activeLabel,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}