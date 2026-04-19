import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';
import 'package:registration_flow/core/constant/app_icons.dart';
import 'package:registration_flow/core/constant/app_strings.dart';

class PasswordAuthTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordAuthTextField({super.key, required this.controller});

  @override
  State<PasswordAuthTextField> createState() => _PasswordAuthTextFieldState();
}

class _PasswordAuthTextFieldState extends State<PasswordAuthTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      validator: (value) {
        if (value == null || value.isEmpty) return AppStrings.enterPassword;
        if (value.length < AppStrings.passwordLength) return AppStrings.min6Characters;
        return null;
      },
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        labelText: AppStrings.password,
        labelStyle: const TextStyle(color: AppColors.white),
        prefixIcon: const Icon(AppIcons.lock, color: AppColors.white),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          icon: Icon(
            _isObscure ? AppIcons.visibilityOff : AppIcons.visibility,
            color: AppColors.white,
          ),
        ),
        errorStyle: TextStyle(color: AppColors.error),
        enabled: true,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}