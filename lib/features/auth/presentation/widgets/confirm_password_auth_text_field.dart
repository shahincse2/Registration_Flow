import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';
import 'package:registration_flow/core/constant/app_icons.dart';

class ConfirmPasswordAuthTextField extends StatelessWidget {
  const ConfirmPasswordAuthTextField({
    super.key,
    required TextEditingController confirmPasswordController,
    required TextEditingController passwordController,
  }) : _confirmPasswordController = confirmPasswordController, _passwordController = passwordController;

  final TextEditingController _confirmPasswordController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Confirm password";
        }
        if (value != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: AppColors.white),
        prefixIcon: Icon(AppIcons.lock, color: AppColors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
      ),
    );
  }
}