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
import 'package:qunzo_merchant/src/network/api/api_path.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/set_up_password_controller.dart';
import 'package:qunzo_merchant/src/presentation/widgets/web_view_dynamic.dart';

class SetUpPasswordScreen extends StatefulWidget {
  const SetUpPasswordScreen({super.key});

  @override
  State<SetUpPasswordScreen> createState() => _SetUpPasswordScreenState();
}

class _SetUpPasswordScreenState extends State<SetUpPasswordScreen> {
  final SetUpPasswordController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetFields();
    });
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
                            localization.setUpPasswordTitle,
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
                            Row(
                              children: [
                                Container(
                                  width: 20.w,
                                  height: 2.h,
                                  color: AppColors.lightTextPrimary.withValues(
                                    alpha: 0.10,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  localization.setUpPasswordSectionTitle,
                                  style: TextStyle(
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16.sp,
                                    color: AppColors.lightTextPrimary,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  width: 90.w,
                                  height: 2.h,
                                  color: AppColors.lightTextPrimary.withValues(
                                    alpha: 0.10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.h),
                            Obx(
                              () => CommonAuthTextInputField(
                                isRequired: true,
                                labelText:
                                    localization.setUpPasswordPasswordLabel,
                                controller: controller.passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: controller.isPasswordVisible.value,
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
                                    .setUpPasswordConfirmPasswordLabel,
                                controller:
                                    controller.confirmPasswordController,
                                keyboardType: TextInputType.text,
                                obscureText:
                                    controller.isConfirmPasswordVisible.value,
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
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    checkColor: AppColors.white,
                                    side: BorderSide(
                                      color: AppColors.lightTextTertiary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    activeColor: AppColors.lightPrimary,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                    value: controller
                                        .isTermsAndConditionChecked
                                        .value,
                                    onChanged: (bool? value) {
                                      Future.microtask(() {
                                        controller
                                                .isTermsAndConditionChecked
                                                .value =
                                            value!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller
                                            .isTermsAndConditionChecked
                                            .value = !controller
                                            .isTermsAndConditionChecked
                                            .value;
                                      },
                                      child: Text(
                                        localization.setUpPasswordAgreementText,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0,
                                          fontSize: 14.sp,
                                          color: AppColors.lightTextPrimary,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => WebViewDynamic(
                                            dynamicUrl:
                                                "${ApiPath.baseUrl}${ApiPath.termsAndConditionsEndpoint}",
                                          ),
                                        );
                                      },
                                      child: Text(
                                        localization.setUpPasswordTermsLink,
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
                            SizedBox(height: 30.h),
                            CommonButton(
                              text: localization.setUpPasswordSetupButton,
                              onPressed: () async {
                                if (controller
                                    .passwordController
                                    .text
                                    .isEmpty) {
                                  ToastHelper().showErrorToast(
                                    localization.setUpPasswordPasswordRequired,
                                  );
                                } else if (controller
                                        .passwordController
                                        .text
                                        .isNotEmpty &&
                                    controller.passwordController.text.length <
                                        8) {
                                  ToastHelper().showErrorToast(
                                    localization.setUpPasswordPasswordLength,
                                  );
                                } else if (controller
                                    .confirmPasswordController
                                    .text
                                    .isEmpty) {
                                  ToastHelper().showErrorToast(
                                    localization
                                        .setUpPasswordConfirmPasswordRequired,
                                  );
                                } else if (controller.passwordController.text !=
                                    controller.confirmPasswordController.text) {
                                  ToastHelper().showErrorToast(
                                    localization
                                        .setUpPasswordPasswordsDontMatch,
                                  );
                                } else if (!controller
                                    .isTermsAndConditionChecked
                                    .value) {
                                  ToastHelper().showErrorToast(
                                    localization.setUpPasswordAcceptTerms,
                                  );
                                } else {
                                  controller.setUpPassword();
                                }
                              },
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
