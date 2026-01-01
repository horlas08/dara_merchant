import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool isFocused;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool enabled;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? suffixIconColor;
  final VoidCallback? onTap;
  final int? maxLine;
  final double borderRadius;
  final bool? isBorderShow;
  final bool isRequired;
  final Color? backgroundColor;
  final double? contentVerticalPadding;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final double? topLeftBorderRadius;
  final double? topRightBorderRadius;
  final double? bottomLeftBorderRadius;
  final double? bottomRightBorderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;

  const CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.isFocused = false,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.enabled = true,
    this.textStyle,
    this.hintStyle,
    this.suffixIconColor,
    this.onTap,
    this.maxLine = 1,
    this.borderRadius = 8,
    this.isBorderShow = true,
    this.isRequired = false,
    this.backgroundColor,
    this.contentVerticalPadding,
    this.labelStyle,
    this.floatingLabelStyle,
    this.topLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomLeftBorderRadius,
    this.bottomRightBorderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultBorderColor =
        borderColor ?? AppColors.lightTextPrimary.withValues(alpha: 0.10);

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      focusNode: focusNode,
      keyboardType: keyboardType,
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      enabled: enabled,
      style:
          textStyle ??
          TextStyle(
            color: AppColors.lightTextPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
          ),
      maxLines: maxLine,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
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
        alignLabelWithHint: maxLine != 1,

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
          borderSide: BorderSide(color: defaultBorderColor, width: 2.w),
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
      topLeft: Radius.circular(topLeftBorderRadius ?? borderRadius),
      topRight: Radius.circular(topRightBorderRadius ?? borderRadius),
      bottomLeft: Radius.circular(bottomLeftBorderRadius ?? borderRadius),
      bottomRight: Radius.circular(bottomRightBorderRadius ?? borderRadius),
    );
  }
}
