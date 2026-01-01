import 'package:flutter/material.dart';

class AppColors {
  // ------------------ LIGHT THEME ------------------
  // Background Colors
  static const Color lightBackground = Color(0xFFF8F8F8);

  // Primary Colors
  static const Color lightPrimary = Color(0xFF4CD080);

  // Text Colors
  static const Color lightTextPrimary = Color(0xFF1A202C);
  static Color lightTextTertiary = Color(0xFF1A202C).withValues(alpha: 0.30);

  // ------------------ UTILS ------------------

  // Error/Warning/Success
  static const Color error = Color(0xFFDC3C22);
  static const Color warning = Color(0xFFFFAA00);
  static const Color success = Color(0xFF14AE6F);

  // Utility
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
}
