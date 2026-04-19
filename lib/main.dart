import 'package:flutter/material.dart';
import 'package:registration_flow/features/auth/presentation/screens/sign_up_screen.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Flow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SignUpScreen(),
    );
  }
}