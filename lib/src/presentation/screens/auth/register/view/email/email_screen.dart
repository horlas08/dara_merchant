import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_auth_text_field.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/email_controller.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final EmailController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.clearSignUpStatus();
  }

  @override
  Widget build(BuildContext context) {
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
                            localization.emailTitle,
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
                            CommonAuthTextInputField(
                              isRequired: true,
                              labelText: localization.emailLabel,
                              autofillHints: const [AutofillHints.email],
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                  left: 15.w,
                                  right: 8.w,
                                ),
                                child: Image.asset(
                                  PngAssets.authEmailIcon,
                                  color: AppColors.lightTextPrimary.withValues(
                                    alpha: 0.80,
                                  ),
                                  width: 20.w,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            CommonButton(
                              text: localization.emailContinueButton,
                              onPressed: () {
                                if (controller
                                    .emailController
                                    .text
                                    .isNotEmpty) {
                                  controller.sendVerifyEmail();
                                } else {
                                  ToastHelper().showErrorToast(
                                    localization.emailRequired,
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  localization.emailAlreadyHaveAccount,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0,
                                    fontSize: 14.sp,
                                    color: AppColors.lightTextTertiary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Text(
                                    localization.emailLoginLink,
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
