import 'dart:async';
import 'package:flutter/material.dart';
import 'package:registration_flow/core/constant/app_colors.dart';
import 'package:registration_flow/core/constant/app_strings.dart';
import 'package:registration_flow/core/utils/messenger.dart';
import 'package:registration_flow/core/widgets/app_background.dart';
import 'package:registration_flow/features/auth/presentation/widgets/auth_button.dart';
import 'package:registration_flow/features/auth/presentation/widgets/auth_card.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int otpLength = 6;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  int secondsRemaining = 60;
  Timer? timer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(otpLength, (index) => TextEditingController());

    focusNodes = List.generate(otpLength, (index) => FocusNode());

    startTimer();
  }

  void startTimer() {
    canResend = false;
    secondsRemaining = 60;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        setState(() {
          canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  void resendOtp() {
    if (!canResend) return;

    // API call here
    startTimer();

    Messenger.showSuccessMessage(context, AppStrings.otpResend);
  }

  String getOtp() {
    return controllers.map((e) => e.text).join();
  }

  void verifyOtp() {
    final otp = getOtp();

    if (otp.length < otpLength) {
      Messenger.showErrorMessage(context, AppStrings.enterOtp);
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(AppStrings.enteredOtp + " $otp")));
  }


  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: AuthCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "OTP Verification",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Enter the 6-digit code sent to your email",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.disableText),
            ),

            const SizedBox(height: 20),

            /// 🔥 OTP INPUT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(otpLength, (index) {
                return SizedBox(
                  width: 45,
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(color: AppColors.white),
                    decoration: const InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                    ),

                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        if (index < otpLength - 1) {
                          FocusScope.of(
                            context,
                          ).requestFocus(focusNodes[index + 1]);
                        } else {
                          FocusScope.of(context).unfocus();
                        }
                      } else {
                        if (index > 0) {
                          FocusScope.of(
                            context,
                          ).requestFocus(focusNodes[index - 1]);
                        }
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            /// 🔥 VERIFY BUTTON
            AuthButton(
              isLoading: false,
              onPressed: verifyOtp,
              text: "VERIFY",
            ),

            const SizedBox(height: 20),

            /// 🔥 TIMER + RESEND
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Resend in $secondsRemaining sec",
                  style: TextStyle(color: AppColors.disableText),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: canResend ? resendOtp : null,
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                      color: canResend ? AppColors.white : AppColors.disableText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    timer?.cancel();
    super.dispose();
  }
}
