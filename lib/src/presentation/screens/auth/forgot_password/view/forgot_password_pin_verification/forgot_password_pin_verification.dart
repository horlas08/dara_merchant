import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/helper/mask_email_helper.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/forgot_password/controller/forgot_password_pin_verification_controller.dart';

class ForgotPasswordPinVerification extends StatefulWidget {
  const ForgotPasswordPinVerification({super.key});

  @override
  State<ForgotPasswordPinVerification> createState() =>
      _ForgotPasswordPinVerificationState();
}

class _ForgotPasswordPinVerificationState
    extends State<ForgotPasswordPinVerification> {
  final ForgotPasswordPinVerificationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments?['email'] ?? '';
    final localization = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
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
                            localization.forgotPasswordPinVerificationTitle,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              localization
                                  .forgotPasswordPinVerificationEnterOtp,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20.sp,
                                color: AppColors.lightTextPrimary,
                                letterSpacing: 0,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    localization
                                        .forgotPasswordPinVerificationOtpSentTo,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                      color: AppColors.lightTextTertiary,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  Text(
                                    " ${MaskEmailHelper.maskEmail(email)}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                      color: AppColors.lightPrimary,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Obx(
                              () => Center(
                                child: Text(
                                  localization
                                      .forgotPasswordPinVerificationOtpCountdown(
                                        controller.countdown.value,
                                      ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                    color: AppColors.lightTextPrimary
                                        .withValues(alpha: 0.80),
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Obx(
                              () => PinCodeTextField(
                                keyboardType: TextInputType.number,
                                enabled: controller.isPinEnabled.value,
                                cursorColor: AppColors.lightPrimary,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.sp,
                                  color: AppColors.lightTextPrimary,
                                  letterSpacing: 0,
                                ),
                                controller: controller.pinCodeController,
                                enableActiveFill: controller.isPinEnabled.value,
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
                            ),

                            SizedBox(height: 30.h),
                            CommonButton(
                              onPressed: () async {
                                if (controller.pinCodeController.text.length ==
                                    6) {
                                  await controller.submitResetVerifyOtp(
                                    email: email,
                                  );
                                } else {
                                  ToastHelper().showErrorToast(
                                    localization
                                        .forgotPasswordPinVerificationOtpRequired,
                                  );
                                }
                              },
                              width: double.infinity,
                              text: localization
                                  .forgotPasswordPinVerificationVerifyButton,
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  localization
                                      .forgotPasswordPinVerificationDidNotReceive,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0,
                                    fontSize: 14.sp,
                                    color: AppColors.lightTextTertiary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => controller.submitForgotPassword(
                                    email: email,
                                  ),
                                  child: Text(
                                    localization
                                        .forgotPasswordPinVerificationResend,
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
