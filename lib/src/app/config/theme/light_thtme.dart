import 'package:flutter/material.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';

class LightTheme {
  ThemeData lightTheme(context) => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    fontFamily: "Plus Jakarta Sans",
  );
}
