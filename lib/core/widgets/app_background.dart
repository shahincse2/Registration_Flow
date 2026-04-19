import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:registration_flow/core/constant/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  /// Optional custom gradient
  final List<Color>? gradientColors;

  /// Control status bar style manually (optional)
  final SystemUiOverlayStyle? overlayStyle;

  /// Auto detect based on background brightness
  final bool autoOverlay;

  /// Center content or not
  final bool isCenter;

  const AppBackground({
    super.key,
    required this.child,
    this.gradientColors,
    this.overlayStyle,
    this.autoOverlay = true,
    this.isCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? [AppColors.primary, AppColors.secondary];

    /// 🎯 Auto detect light/dark
    final isDarkBackground =
        ThemeData.estimateBrightnessForColor(colors.first) == Brightness.dark;

    final SystemUiOverlayStyle finalStyle =
        overlayStyle ??
        (autoOverlay
            ? (isDarkBackground
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark)
            : SystemUiOverlayStyle.light);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: finalStyle,
        child: SafeArea(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: isCenter ? Center(child: child) : child,
          ),
        ),
      ),
    );
  }
}
