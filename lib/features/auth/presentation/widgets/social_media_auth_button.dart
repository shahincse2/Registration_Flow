import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';

class SocialMediaAuthButton extends StatelessWidget {
  const SocialMediaAuthButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  final VoidCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.white),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: AppColors.white)),
          ],
        ),
      ),
    );
  }
}
