import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';
import 'package:registration_flow/core/constant/app_icons.dart';
import 'package:registration_flow/core/constant/app_strings.dart';
import 'package:registration_flow/core/utils/messenger.dart';
import 'package:registration_flow/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:registration_flow/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:registration_flow/features/auth/presentation/widgets/auth_button.dart';
import 'package:registration_flow/features/auth/presentation/widgets/auth_card.dart';
import 'package:registration_flow/features/auth/presentation/widgets/password_auth_text_field.dart';
import 'package:registration_flow/features/auth/presentation/widgets/social_media_auth_button.dart';
import 'package:registration_flow/features/auth/presentation/widgets/email_auth_text_field.dart';
import 'package:registration_flow/features/auth/presentation/widgets/build_divider.dart';
import 'package:registration_flow/features/auth/presentation/widgets/forgot_password_button.dart';
import 'package:registration_flow/features/auth/presentation/widgets/app_rich_text_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _rememberMe = false;
  String? _errorMessage;

  Future<bool> _login() async {
    await Future.delayed(const Duration(seconds: 2));
    return _emailController.text == AppStrings.testEmail &&
        _passwordController.text == AppStrings.testPassword;
  }

  void _buildLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final success = await _login();

      if (!mounted) return;

      if (success) {
        Messenger.showSuccessMessage(context, AppStrings.loginSuccessful);
      } else {
        setState(() {
          _errorMessage = AppStrings.invalidEmailOrPassword;
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = "Something went wrong";
      });

      Messenger.showErrorMessage(context, "Login failed");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: AuthCard(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    AppStrings.welcomeBack,
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
                        PasswordAuthTextField(controller: _passwordController),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔹 Remember Me + Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            activeColor: AppColors.white,
                            checkColor: AppColors.primary,
                            side: WidgetStateBorderSide.resolveWith(
                              (states) =>
                                  const BorderSide(color: AppColors.border),
                            ),
                          ),
                          const Text(
                            "Remember Me",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),

                      ForgotPassword(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        label: 'Forgot Password?',
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// LOGIN BUTTON
                  AuthButton(
                    isLoading: _isLoading,
                    onPressed: _buildLogin,
                    text: AppStrings.login,
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

                  /// 🔹 OR DIVIDER
                  BuildDivider(label: 'or',),

                  const SizedBox(height: 20),

                  /// 🔹 SOCIAL LOGIN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMediaAuthButton(
                        onTap: () {
                          //TODO: Navigate to sign in
                        },
                        label: "Google",
                        icon: AppIcons.google,
                      ),
                      const SizedBox(width: 16),
                      SocialMediaAuthButton(
                        onTap: () {
                          //TODO: Navigate to sign in
                          },
                        label: "Facebook",
                        icon: AppIcons.facebook,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// SIGN UP NAVIGATION
                  AppRichTextButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    disableLabel: "Don't have an account? ",
                    activeLabel: 'Sign Up',
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

