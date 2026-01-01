import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_auth_text_field.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/forgot_password/controller/reset_password_controller.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final ResetPasswordController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments?['email'] ?? '';
    final String otp = Get.arguments?['otp'] ?? '';
    final localization = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: ScreenUtil().screenHeight,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image.asset(PngAssets.authHeaderFrame),
                        Padding(
                          padding: EdgeInsets.only(left: 40.w, bottom: 32.h),
                          child: Text(
                            localization.resetPasswordTitle,
                            style: TextStyle(
                              letterSpacing: 0,
                              fontWeight: FontWeight.w900,
                              fontSize: 22.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 70.h),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 18.w),
                        padding: EdgeInsets.only(
                          top: 3.h,
                          left: 18.w,
                          right: 18.w,
                          bottom: 30.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                          ),
                          color: AppColors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            Obx(
                              () => CommonAuthTextInputField(
                                isRequired: true,
                                labelText:
                                    localization.resetPasswordPasswordLabel,
                                controller: controller.passwordController,
                                obscureText: controller.isPasswordVisible.value,
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.w,
                                    right: 8.w,
                                  ),
                                  child: Image.asset(
                                    PngAssets.authPasswordIcon,
                                    color: AppColors.lightTextPrimary
                                        .withValues(alpha: 0.80),
                                    width: 20.w,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () =>
                                      controller.isPasswordVisible.toggle(),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 12.w,
                                      right: 16.w,
                                    ),
                                    child: Image.asset(
                                      controller.isPasswordVisible.value
                                          ? PngAssets.authEyeShowIcon
                                          : PngAssets.authEyeHideIcon,
                                      color: AppColors.lightTextPrimary,
                                      width: 20.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Obx(
                              () => CommonAuthTextInputField(
                                isRequired: true,
                                labelText: localization
                                    .resetPasswordConfirmPasswordLabel,
                                controller:
                                    controller.confirmPasswordController,
                                obscureText:
                                    controller.isConfirmPasswordVisible.value,
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.w,
                                    right: 8.w,
                                  ),
                                  child: Image.asset(
                                    PngAssets.authPasswordIcon,
                                    color: AppColors.lightTextPrimary
                                        .withValues(alpha: 0.80),
                                    width: 20.w,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () => controller
                                      .isConfirmPasswordVisible
                                      .toggle(),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 12.w,
                                      right: 16.w,
                                    ),
                                    child: Image.asset(
                                      controller.isConfirmPasswordVisible.value
                                          ? PngAssets.authEyeShowIcon
                                          : PngAssets.authEyeHideIcon,
                                      color: AppColors.lightTextPrimary,
                                      width: 20.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            CommonButton(
                              onPressed: () async {
                                if (controller
                                    .passwordController
                                    .text
                                    .isEmpty) {
                                  ToastHelper().showErrorToast(
                                    localization.resetPasswordPasswordRequired,
                                  );
                                  return;
                                } else if (controller
                                        .passwordController
                                        .text
                                        .isNotEmpty &&
                                    controller.passwordController.text.length <
                                        8) {
                                  ToastHelper().showErrorToast(
                                    localization.resetPasswordPasswordLength,
                                  );
                                  return;
                                } else if (controller
                                    .confirmPasswordController
                                    .text
                                    .isEmpty) {
                                  ToastHelper().showErrorToast(
                                    localization
                                        .resetPasswordConfirmPasswordRequired,
                                  );
                                  return;
                                } else if (controller.passwordController.text !=
                                    controller.confirmPasswordController.text) {
                                  ToastHelper().showErrorToast(
                                    localization
                                        .resetPasswordPasswordsDontMatch,
                                  );
                                  return;
                                } else {
                                  await controller.submitResetPassword(
                                    email: email,
                                    otp: otp,
                                  );
                                }
                              },
                              text: localization.resetPasswordButton,
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  localization.resetPasswordAlreadyHaveAccount,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0,
                                    fontSize: 14.sp,
                                    color: AppColors.lightTextTertiary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamed(BaseRoute.login);
                                  },
                                  child: Text(
                                    localization.resetPasswordLoginLink,
                                    style: TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      color: AppColors.lightPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.isLoading.value,
                child: const CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
