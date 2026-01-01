import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/services/biometric_auth_service.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_alert_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_auth_text_field.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/login/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
    final localization = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        Get.bottomSheet(
          CommonAlertBottomSheet(
            title: localization.exitAppTitle,
            message: localization.exitAppMessage,
            onConfirm: () => exit(0),
            onCancel: () => Get.back(),
          ),
        );
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
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
                              localization.loginTitle,
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
                              AutofillGroup(
                                child: Column(
                                  children: [
                                    CommonAuthTextInputField(
                                      isRequired: true,
                                      labelText: localization.loginEmailLabel,
                                      autofillHints: const [
                                        AutofillHints.email,
                                      ],
                                      controller: controller.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                          left: 15.w,
                                          right: 8.w,
                                        ),
                                        child: Image.asset(
                                          PngAssets.authEmailIcon,
                                          color: AppColors.lightTextPrimary
                                              .withValues(alpha: 0.80),
                                          width: 20.w,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Obx(
                                      () => CommonAuthTextInputField(
                                        isRequired: true,
                                        labelText:
                                            localization.loginPasswordLabel,
                                        autofillHints: const [
                                          AutofillHints.password,
                                        ],
                                        controller:
                                            controller.passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText:
                                            controller.isPasswordVisible.value,
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
                                              .isPasswordVisible
                                              .toggle(),
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
                                    SizedBox(height: 10.h),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () => Get.toNamed(
                                          BaseRoute.forgotPassword,
                                        ),
                                        child: Text(
                                          localization.loginForgotPassword,
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                            color: AppColors.lightPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30.h),
                                    CommonButton(
                                      onPressed: () async {
                                        if (controller
                                            .emailController
                                            .text
                                            .isEmpty) {
                                          ToastHelper().showErrorToast(
                                            localization.loginEmailRequired,
                                          );
                                        } else if (controller
                                            .passwordController
                                            .text
                                            .isEmpty) {
                                          ToastHelper().showErrorToast(
                                            localization.loginPasswordRequired,
                                          );
                                        } else {
                                          await controller.submitSignIn();
                                        }
                                      },
                                      width: double.infinity,
                                      text: localization.loginButton,
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          localization.loginDontHaveAccount,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0,
                                            fontSize: 14.sp,
                                            color: AppColors.lightTextTertiary,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              Get.toNamed(BaseRoute.email),
                                          child: Text(
                                            localization.loginCreateAccount,
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
                                    SizedBox(height: 60.h),
                                    GestureDetector(
                                      onTap: () async {
                                        await Future.delayed(
                                          const Duration(milliseconds: 100),
                                        );

                                        final savedEmail =
                                            await SettingsService.getLoggedInUserEmail();
                                        final savedPassword =
                                            await SettingsService.getLoggedInUserPassword();

                                        if (savedEmail == null ||
                                            savedPassword == null) {
                                          ToastHelper().showErrorToast(
                                            localization
                                                .loginFirstSignInRequired,
                                          );

                                          return;
                                        }

                                        if (!controller
                                            .isBiometricEnable
                                            .value) {
                                          ToastHelper().showErrorToast(
                                            localization
                                                .loginBiometricNotEnabled,
                                          );

                                          return;
                                        }

                                        final bioAuth = BiometricAuthService();
                                        bool success = await bioAuth
                                            .authenticateWithBiometrics();

                                        if (success) {
                                          controller.biometricEmail.value =
                                              savedEmail;
                                          controller.biometricPassword.value =
                                              savedPassword;
                                          await controller.submitSignIn(
                                            useBiometric: true,
                                          );
                                        }
                                      },
                                      child: Image.asset(
                                        PngAssets.fingerprintCommonIcon,
                                        color: AppColors.lightPrimary,
                                        width: 55.w,
                                      ),
                                    ),
                                    SizedBox(height: 30.h),
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}
