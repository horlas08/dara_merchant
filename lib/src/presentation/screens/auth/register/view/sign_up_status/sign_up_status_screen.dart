import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/svg_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_alert_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/sign_up_status_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/auth_id_verification/sub_sections/submit_valid_id_verification.dart';

class SignUpStatusScreen extends StatefulWidget {
  const SignUpStatusScreen({super.key});

  @override
  State<SignUpStatusScreen> createState() => _SignUpStatusScreenState();
}

class _SignUpStatusScreenState extends State<SignUpStatusScreen> {
  final SignUpStatusController controller = Get.find();
  final bool isPasswordSetup = Get.arguments?["is_password_set_up"] ?? false;
  final bool isPersonalInfo = Get.arguments?["is_personal_info"] ?? false;
  final bool isIdVerification = Get.arguments?["is_id_verification"] ?? false;
  final bool isLogInState = Get.arguments?["is_login_state"] ?? false;
  final RxBool emailVerified = false.obs;
  final RxBool setUpPassword = false.obs;
  final localization = AppLocalizations.of(Get.context!)!;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await loadEmailVerified();
    await loadSetUpPassword();
    if (isPasswordSetup || isPersonalInfo || isIdVerification || isLogInState) {
      await controller.fetchUser();
    }
  }

  // Load Email Verified for current user
  Future<void> loadEmailVerified() async {
    final isEmailVerified = await SettingsService.getEmailVerified();
    if (isEmailVerified != null) {
      emailVerified.value = isEmailVerified;
    }
  }

  // Load Set Up Password for current user
  Future<void> loadSetUpPassword() async {
    final isSetUpPassword = await SettingsService.getSetUpPassword();
    if (isSetUpPassword != null) {
      setUpPassword.value = isSetUpPassword;
    }
  }

  // Check if all steps are completed
  bool get allStepsCompleted {
    final personalInfoCompleted =
        controller.userModel.value.data?.user!.boardingSteps?.personalInfo ==
        true;
    final idVerificationCompleted =
        controller.userModel.value.data?.user!.boardingSteps?.idVerification ==
        false;
    final isKycVerification = controller.userModel.value.data?.user!.kyc == 2;

    return getEmailVerificationStatus() &&
        getPasswordSetupStatus() &&
        personalInfoCompleted &&
        idVerificationCompleted &&
        isKycVerification;
  }

  // Get current status
  bool getEmailVerificationStatus() {
    if (isLogInState || isPersonalInfo || isIdVerification) {
      return controller
              .userModel
              .value
              .data
              ?.user!
              .boardingSteps
              ?.emailVerification ==
          true;
    } else {
      return emailVerified.value;
    }
  }

  bool getPasswordSetupStatus() {
    if (isLogInState || isPersonalInfo || isIdVerification) {
      return controller
              .userModel
              .value
              .data
              ?.user!
              .boardingSteps
              ?.passwordSetup ==
          true;
    } else {
      return setUpPassword.value;
    }
  }

  // Get ID verification
  String? get idVerificationStatusText {
    final idVerification =
        controller.userModel.value.data?.user!.boardingSteps?.idVerification;
    final kycVerification = controller.userModel.value.data?.user!.kyc;
    return (idVerification == false && kycVerification == 2)
        ? localization.signUpStatusStatusInReview
        : (idVerification == false && kycVerification == 3)
        ? localization.signUpStatusStatusRejected
        : null;
  }

  // Next Step
  Future<void> _handleNextStep() async {
    try {
      final emailVerificationDone = getEmailVerificationStatus();
      final passwordSetupDone = getPasswordSetupStatus();
      final personalInfoDone =
          controller.userModel.value.data?.user!.boardingSteps?.personalInfo ==
          true;
      final kycStatus = controller.userModel.value.data?.user!.kyc;

      if (emailVerificationDone &&
          passwordSetupDone &&
          personalInfoDone &&
          kycStatus == 3) {
        Get.to(() => SubmitValidIdVerification());
      } else if (emailVerificationDone &&
          passwordSetupDone &&
          personalInfoDone) {
        Get.to(() => SubmitValidIdVerification());
      } else if (emailVerificationDone && passwordSetupDone) {
        Get.toNamed(BaseRoute.personalInfo);
      } else if (emailVerificationDone) {
        Get.toNamed(BaseRoute.setUpPassword);
      }
    } catch (e) {
      ToastHelper().showErrorToast(
        localization.signUpStatusErrorProcessingStep,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          body: Stack(
            children: [
              RefreshIndicator(
                color: AppColors.lightPrimary,
                onRefresh: () async {
                  controller.isLoading.value = true;
                  await controller.fetchUser();
                },
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return CommonLoading();
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                _buildHeaderSection(),
                                SizedBox(height: 70.h),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 18.w,
                                    ),
                                    padding: EdgeInsets.only(
                                      top: 3.h,
                                      left: 18.w,
                                      right: 18.w,
                                      bottom: 20.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.r),
                                        topRight: Radius.circular(30.r),
                                      ),
                                      color: AppColors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20.h),
                                        Text(
                                          localization
                                              .signUpStatusSetupNextStepTitle,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20.sp,
                                            color: AppColors.lightTextPrimary,
                                          ),
                                        ),
                                        SizedBox(height: 30.h),
                                        _buildMainContent(context),
                                        SizedBox(height: 30.h),
                                        _buildActionButton(context),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isFcmTokenLoading.value,
                  child: CommonLoading(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.asset(PngAssets.authHeaderFrame),
        Padding(
          padding: EdgeInsets.only(left: 40.w, bottom: 32.h),
          child: Text(
            localization.signUpStatusCurrentStatusTitle,
            style: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w900,
              fontSize: 22.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          _buildStep(
            step: 1,
            title: localization.signUpStatusStepEmail,
            isCompleted: getEmailVerificationStatus(),
            icon: SvgAssets.authEmailIcon,
          ),
          _buildStep(
            step: 2,
            title: localization.signUpStatusStepSetupPassword,
            isCompleted: getPasswordSetupStatus(),
            icon: SvgAssets.authSetUpPasswordIcon,
          ),
          _buildStep(
            step: 3,
            title: localization.signUpStatusStepPersonalInfo,
            isCompleted:
                controller
                    .userModel
                    .value
                    .data
                    ?.user!
                    .boardingSteps
                    ?.personalInfo ==
                true,
            icon: SvgAssets.authPersonalInfoIcon,
          ),
          _buildStep(
            step: 4,
            title: localization.signUpStatusStepIdVerification,
            isCompleted:
                controller
                    .userModel
                    .value
                    .data
                    ?.user!
                    .boardingSteps
                    ?.idVerification ==
                true,
            icon: SvgAssets.authIdVerificationIcon,
            statusText: idVerificationStatusText,
            statusColor: AppColors.warning,
          ),
          if (controller.userModel.value.data?.user?.kyc == 3)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                (controller
                                .userModel
                                .value
                                .data
                                ?.user
                                ?.merchant
                                ?.rejectionReason !=
                            null &&
                        controller
                                .userModel
                                .value
                                .data
                                ?.user
                                ?.merchant
                                ?.rejectionReason
                                ?.trim()
                                .isNotEmpty ==
                            true)
                    ? controller
                              .userModel
                              .value
                              .data!
                              .user!
                              .merchant!
                              .rejectionReason ??
                          ""
                    : localization.signUpStatusNoReasonProvided,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  letterSpacing: 0,
                  fontSize: 13,
                  color: AppColors.lightTextTertiary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildActionButton(BuildContext context) {
    return Obx(() {
      final userData = controller.userModel.value.data;
      final boardingSteps = userData?.user!.boardingSteps;
      final isCompleted = boardingSteps?.completed ?? false;
      final isPersonalInfo = boardingSteps?.personalInfo ?? false;
      final isReview = controller.userModel.value.data?.user?.kyc == 2;
      final isRejected = controller.userModel.value.data?.user?.kyc == 3;

      return Column(
        children: [
          if (!allStepsCompleted && !isCompleted)
            Obx(
              () => CommonButton(
                onPressed: _handleNextStep,
                width: double.infinity,
                text: controller.userModel.value.data?.user?.kyc == 3
                    ? localization.signUpStatusSubmitAgainButton
                    : localization.signUpStatusNextButton,
              ),
            ),

          if (isCompleted)
            CommonButton(
              onPressed: () => controller.postFcmNotification(),
              width: double.infinity,
              text: localization.signUpStatusDashboardButton,
            ),

          if (isPersonalInfo && !(isReview || isRejected || isCompleted)) ...[
            SizedBox(height: 15.h),
            CommonButton(
              onPressed: () {
                Get.toNamed(
                  BaseRoute.personalInfo,
                  arguments: {"is_personal_info_edit": true},
                );
              },
              text: localization.signUpStatusBackButton,
              backgroundColor: Color(0xFFE4F8EC),
              textColor: AppColors.lightTextPrimary,
            ),
            SizedBox(height: 20.h),
          ],
        ],
      );
    });
  }

  Widget _buildStep({
    required int step,
    required String title,
    required bool isCompleted,
    required String icon,
    String? statusText,
    Color? statusColor,
  }) {
    final bool isIdVerificationInReview =
        step == 4 &&
        controller.userModel.value.data?.user?.boardingSteps?.idVerification ==
            false &&
        (controller.userModel.value.data?.user?.kyc == 2);
    final bool isIdVerificationRejected =
        step == 4 &&
        controller.userModel.value.data?.user?.boardingSteps?.idVerification ==
            false &&
        (controller.userModel.value.data?.user?.kyc == 3);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Column(
                children: [
                  Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isIdVerificationInReview
                          ? AppColors.warning.withValues(alpha: 0.06)
                          : isIdVerificationRejected
                          ? AppColors.error.withValues(alpha: 0.06)
                          : isCompleted
                          ? AppColors.lightPrimary.withValues(alpha: 0.08)
                          : Color(0xFF2D2D2D).withValues(alpha: 0.06),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(11.w),
                      child: SvgPicture.asset(
                        icon,
                        colorFilter: ColorFilter.mode(
                          isIdVerificationInReview
                              ? AppColors.warning.withValues(alpha: 0.30)
                              : isIdVerificationRejected
                              ? AppColors.error.withValues(alpha: 0.30)
                              : isCompleted
                              ? AppColors.lightPrimary
                              : Color(0xFF2D2D2D).withValues(alpha: 0.30),
                          BlendMode.srcIn,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  if (step != 4)
                    Container(
                      width: 2.5.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: isCompleted
                            ? AppColors.lightPrimary.withValues(alpha: 0.60)
                            : Color(0xFF2D2D2D).withValues(alpha: 0.20),
                      ),
                    ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Transform.translate(
              offset: Offset(0, 11.h),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: isCompleted
                      ? AppColors.lightTextPrimary
                      : Color(0xFF2D2D2D).withValues(alpha: 0.30),
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
        if (isCompleted)
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(PngAssets.idVerificationSuccess, width: 35.w),
          ),
        if (statusText != null) ...[
          Transform.translate(
            offset: Offset(0, 11.h),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Text(
                statusText,
                style: TextStyle(
                  letterSpacing: 0,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: isIdVerificationInReview
                      ? AppColors.warning
                      : AppColors.error,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
