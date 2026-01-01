import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/presentation/screens/change_password/controller/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              CommonAppBar(title: localization.changePasswordScreenTitle),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Obx(
                        () => CommonTextField(
                          isRequired: true,
                          labelText:
                              localization.changePasswordCurrentPasswordLabel,
                          controller: controller.currentPasswordController,
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.text,
                          obscureText:
                              controller.isCurrentPasswordVisible.value,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                controller.isCurrentPasswordVisible.toggle(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 16,
                              ),
                              child: Image.asset(
                                controller.isCurrentPasswordVisible.value
                                    ? PngAssets.eyeCommonIcon
                                    : PngAssets.eyeHideCommonIcon,
                                color: AppColors.lightTextPrimary,
                                width: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => CommonTextField(
                          isRequired: true,
                          controller: controller.newPasswordController,
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.text,
                          labelText:
                              localization.changePasswordNewPasswordLabel,
                          obscureText: controller.isNewPasswordVisible.value,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                controller.isNewPasswordVisible.toggle(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 16,
                              ),
                              child: Image.asset(
                                controller.isNewPasswordVisible.value
                                    ? PngAssets.eyeCommonIcon
                                    : PngAssets.eyeHideCommonIcon,
                                color: AppColors.lightTextPrimary,
                                width: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => CommonTextField(
                          isRequired: true,
                          controller: controller.confirmPasswordController,
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.text,
                          labelText:
                              localization.changePasswordConfirmPasswordLabel,
                          obscureText:
                              controller.isConfirmPasswordVisible.value,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                controller.isConfirmPasswordVisible.toggle(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 16,
                              ),
                              child: Image.asset(
                                controller.isConfirmPasswordVisible.value
                                    ? PngAssets.eyeCommonIcon
                                    : PngAssets.eyeHideCommonIcon,
                                color: AppColors.lightTextPrimary,
                                width: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      CommonButton(
                        onPressed: () async {
                          if (!controller.validatePassword()) {
                            return;
                          }

                          await controller.changePassword();
                        },
                        width: double.infinity,
                        text: localization.changePasswordSaveChangesButton,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
