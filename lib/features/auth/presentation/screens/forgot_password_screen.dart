import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:registration_flow/core/constant/app_colors.dart';
import 'package:registration_flow/core/constant/app_icons.dart';
import 'package:registration_flow/core/constant/app_strings.dart';
import 'package:registration_flow/core/utils/auth_helpers.dart';
import 'package:registration_flow/core/utils/messenger.dart';
import 'package:registration_flow/core/widgets/app_background.dart';
import 'package:registration_flow/features/auth/presentation/screens/otp_screen.dart';
import 'package:registration_flow/features/auth/presentation/widgets/app_rich_text_button.dart';
import 'package:registration_flow/features/auth/presentation/widgets/auth_button.dart';
import 'package:registration_flow/features/auth/presentation/widgets/auth_card.dart';
import 'package:registration_flow/features/auth/presentation/widgets/email_auth_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      overlayStyle: SystemUiOverlayStyle.light,
      child: AuthCard(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Enter your email to receive OTP",
                style: TextStyle(color: AppColors.disableText, fontSize: 14),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              /// FORM
              Form(
                key: _formKey,
                child: EmailAuthTextField(
                  controller: _emailController,
                  label: AppStrings.email,
                  icon: AppIcons.email,
                  //TODO: Change your email validation method and move another file
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterEmail;
                    }
                    if (!value.contains('@')) {
                      return AppStrings.invalidEmail;
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// BUTTON
              AuthButton(
                isLoading: _isLoading,
                onPressed: _sendOtpValidation,
                text: AppStrings.sendOtpButton,
              ),

              /// ERROR
              if (_errorMessage != null) ...[
                const SizedBox(height: 10),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: AppColors.error),
                ),
              ],

              const SizedBox(height: 20),

              /// BACK TO SIGN IN
              AppRichTextButton(
                onTap: () {
                  Navigator.pop(context);
                },
                disableLabel: AppStrings.rememberPassword,
                activeLabel: AppStrings.signIn,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendOtpValidation() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await AuthHelper.sendOtp();

    if (!mounted) return;

    if (success) {
      Messenger.showSuccessMessage(context, AppStrings.otpSentMessage);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(),
        ),
      );
    } else {
      setState(() {
        _errorMessage = AppStrings.otpSentFailed;
      });
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
