import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/login/controller/two_factor_auth_controller.dart';

class TwoFactorAuth extends StatefulWidget {
  const TwoFactorAuth({super.key});

  @override
  State<TwoFactorAuth> createState() => _TwoFactorAuthState();
}

class _TwoFactorAuthState extends State<TwoFactorAuth> {
  final TwoFactorAuthController controller =
      Get.find<TwoFactorAuthController>();

  @override
  Widget build(BuildContext context) {
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
                            localization.twoFactorAuthTitle,
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                localization.twoFactorAuthEnterOtp,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20.sp,
                                  color: AppColors.lightTextPrimary,
                                  letterSpacing: 0,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              PinCodeTextField(
                                keyboardType: TextInputType.number,
                                cursorColor: AppColors.lightPrimary,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.sp,
                                  color: AppColors.lightTextPrimary,
                                  letterSpacing: 0,
                                ),
                                controller: controller.pinCodeController,
                                pinTheme: PinTheme(
                                  borderWidth: 1.5.w,
                                  activeBorderWidth: 1.5.w,
                                  disabledBorderWidth: 1.5.w,
                                  inactiveBorderWidth: 1.5.w,
                                  shape: PinCodeFieldShape.box,
                                  fieldHeight: 48.h,
                                  fieldWidth: 45.w,
                                  activeColor: AppColors.lightPrimary
                                      .withValues(alpha: 0.80),
                                  activeFillColor: AppColors.transparent,
                                  inactiveColor: AppColors.lightTextPrimary
                                      .withValues(alpha: 0.10),
                                  inactiveFillColor: AppColors.transparent,
                                  selectedColor: AppColors.lightPrimary
                                      .withValues(alpha: 0.80),
                                  selectedFillColor: AppColors.transparent,
                                  disabledColor: AppColors.lightTextPrimary
                                      .withValues(alpha: 0.10),
                                  selectedBorderWidth: 1.5.w,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                appContext: context,
                                length: 6,
                              ),
                              SizedBox(height: 30.h),
                              CommonButton(
                                onPressed: () async {
                                  if (controller
                                          .pinCodeController
                                          .text
                                          .length ==
                                      6) {
                                    await controller.submitTwoFaVerification();
                                  } else {
                                    ToastHelper().showErrorToast(
                                      localization.twoFactorAuthOtpRequired,
                                    );
                                  }
                                },
                                width: double.infinity,
                                text: localization.twoFactorAuthVerifyButton,
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    localization.twoFactorAuthBackToLogin,
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
                                      localization.twoFactorAuthLoginLink,
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
                              SizedBox(height: 30.h),
                            ],
                          ),
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
