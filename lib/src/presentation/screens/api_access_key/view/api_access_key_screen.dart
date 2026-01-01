import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_alert_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/api_access_key/controller/api_access_key_controller.dart';

class ApiAccessKeyScreen extends StatelessWidget {
  const ApiAccessKeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiAccessKeyController controller = Get.find();
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Column(
        children: [
          CommonAppBar(title: localization.apiAccessKeyTitle),
          const SizedBox(height: 60),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return CommonLoading();
              }

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 18),
                padding: EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      CommonTextField(
                        isRequired: true,
                        controller: controller.publicKeyController,
                        labelText: localization.apiAccessKeyPublicKeyLabel,
                        readOnly: true,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: controller.publicKeyController.text,
                              ),
                            );
                            ToastHelper().showSuccessToast(
                              localization.apiAccessKeyPublicKeyCopied,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 16),
                            child: Image.asset(
                              PngAssets.commonAccountCopyIcon,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.40,
                              ),
                              width: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CommonTextField(
                        isRequired: true,
                        controller: controller.secretKeyController,
                        labelText: localization.apiAccessKeySecretKeyLabel,
                        readOnly: true,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: controller.secretKeyController.text,
                              ),
                            );
                            ToastHelper().showSuccessToast(
                              localization.apiAccessKeySecretKeyCopied,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 16),
                            child: Image.asset(
                              PngAssets.commonAccountCopyIcon,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.40,
                              ),
                              width: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CommonButton(
                        text: localization.apiAccessKeyRegenerateButton,
                        onPressed: () {
                          Get.bottomSheet(
                            CommonAlertBottomSheet(
                              title:
                                  localization.apiAccessKeyGenerateAlertTitle,
                              message:
                                  localization.apiAccessKeyGenerateAlertMessage,
                              onConfirm: () {
                                Get.back();
                                controller.generateApiAccessKey();
                              },
                              onCancel: () => Get.back(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
