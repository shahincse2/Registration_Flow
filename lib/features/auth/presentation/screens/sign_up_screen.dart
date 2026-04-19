import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';
import 'package:registration_flow/core/constant/app_icons.dart';
import 'package:registration_flow/core/constant/app_strings.dart';
import 'package:registration_flow/core/utils/messenger.dart';
import 'package:registration_flow/core/widgets/app_background.dart';
import 'package:registration_flow/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:registration_flow/features/auth/presentation/widgets/auth_button.dart';
import 'package:registration_flow/features/auth/presentation/widgets/auth_card.dart';
import 'package:registration_flow/features/auth/presentation/widgets/confirm_password_auth_text_field.dart';
import 'package:registration_flow/features/auth/presentation/widgets/password_auth_text_field.dart';
import 'package:registration_flow/features/auth/presentation/widgets/social_media_auth_button.dart';
import 'package:registration_flow/features/auth/presentation/widgets/email_auth_text_field.dart';
import 'package:registration_flow/features/auth/presentation/widgets/build_divider.dart';
import 'package:registration_flow/features/auth/presentation/widgets/app_rich_text_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return AppBackground(child: AuthCard(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 16),

            /// FORM
            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Name
                  EmailAuthTextField(
                    controller: _nameController,
                    label: "Name",
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  /// Email
                  EmailAuthTextField(
                    controller: _emailController,
                    label: AppStrings.email,
                    icon: AppIcons.email,
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
                  const SizedBox(height: 16),

                  /// Password
                  PasswordAuthTextField(controller: _passwordController),
                  const SizedBox(height: 16),

                  /// Confirm Password
                  ConfirmPasswordAuthTextField(
                    confirmPasswordController: _confirmPasswordController,
                    passwordController: _passwordController,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// BUTTON
            AuthButton(
              isLoading: _isLoading,
              onPressed: _buildSignUp,
              text: "SIGN UP",
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
            BuildDivider(label: 'or',),

            const SizedBox(height: 20),

            /// Social Login
            /// 🔹 Social Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaAuthButton(
                  onTap: () {
                    if (kDebugMode) {
                      print('Google Button Tapped');
                    }
                  },
                  label: 'Google',
                  icon: Icons.g_mobiledata,
                ),
                const SizedBox(width: 16,),
                SocialMediaAuthButton(
                  onTap: () {
                    if (kDebugMode) {
                      print('Facebook Button Tapped');
                    }
                  },
                  label: 'Facebook',
                  icon: Icons.facebook_outlined,
                ),
              ],
            ),


            const SizedBox(height: 20),

            /// SIGN IN NAVIGATION
            AppRichTextButton(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            }, disableLabel: "Already have an account? ", activeLabel: "Sign In"),
            const SizedBox(height: 8,),
          ],
        ),
      ),
    ));
  }

//TODO: Validate Sign Up Form
  void _buildSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if(mounted) {
      Messenger.showSuccessMessage(context, "Account Created Successfully");
    }
  }


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
