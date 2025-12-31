import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFFC107); // Amber
  static const Color secondary = Color(0xFF000000); // Black
  static const Color background = Color(0xFFF5F5F5); // Light Grey
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );
}

class AppStrings {
  static const String appName = 'RentMi';
  static const String loginTitle = 'Login to continue';
  static const String phoneHint = 'Phone Number';
  static const String verifyOtp = 'Verify OTP';
  static const String resendOtp = 'Resend OTP';
}
