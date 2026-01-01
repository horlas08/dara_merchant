import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';

class CommonAuthTextInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool readOnly;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final Color? backgroundColor;
  final List<String>? autofillHints;
  final VoidCallback? onTap;
  final double? borderRadius;
  final double? topLeftBorderRadius;
  final double? topRightBorderRadius;
  final double? bottomLeftBorderRadius;
  final double? bottomRightBorderRadius;
  final bool isRequired;

  const CommonAuthTextInputField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.readOnly = false,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.floatingLabelStyle,
    this.backgroundColor,
    this.autofillHints,
    this.onTap,
    this.borderRadius,
    this.topLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomLeftBorderRadius,
    this.bottomRightBorderRadius,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      readOnly: readOnly,
      autofillHints: autofillHints,
      onTap: onTap,
      style:
          textStyle ??
          TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
            color: AppColors.lightTextPrimary,
          ),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
        filled: true,
        fillColor: backgroundColor ?? AppColors.white,
        hintText: hintText,
        hintStyle:
            hintStyle ??
            TextStyle(
              color: AppColors.lightTextTertiary,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
        label: labelText != null && isRequired
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(labelText!),
                  Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              )
            : (labelText != null ? Text(labelText!) : null),
        labelStyle:
            labelStyle ??
            TextStyle(
              color: AppColors.lightTextTertiary,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
        floatingLabelStyle:
            floatingLabelStyle ??
            TextStyle(
              color: AppColors.lightTextTertiary,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _getBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
            width: 2.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _getBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.lightPrimary.withValues(alpha: 0.80),
            width: 2.w,
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(
        topLeftBorderRadius?.r ?? borderRadius?.r ?? 8.r,
      ),
      topRight: Radius.circular(
        topRightBorderRadius?.r ?? borderRadius?.r ?? 8.r,
      ),
      bottomLeft: Radius.circular(
        bottomLeftBorderRadius?.r ?? borderRadius?.r ?? 8.r,
      ),
      bottomRight: Radius.circular(
        bottomRightBorderRadius?.r ?? borderRadius?.r ?? 8.r,
      ),
    );
  }
}
