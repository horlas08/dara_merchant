import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';

class CommonButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final String text;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;

  const CommonButton({
    super.key,
    this.width = double.infinity,
    this.height = 45,
    this.borderRadius = 8.0,
    required this.text,
    this.onPressed,
    this.fontWeight = FontWeight.w900,
    this.fontSize = 15,
    this.textColor = AppColors.white,
    this.borderColor,
    this.borderWidth = 0.0,
    this.backgroundColor = AppColors.lightPrimary,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onPressed,
      child: Container(
        width: width?.w,
        height: height?.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          color: backgroundColor,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth.w)
              : null,
          boxShadow: boxShadow,
        ),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            fontWeight: fontWeight,
            fontSize: fontSize.sp,
            color: textColor,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
