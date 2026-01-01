import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_alert_bottom_sheet.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(PngAssets.welcomeIllustration),
                    Positioned(
                      top: 90,
                      left: 42,
                      child: Image.asset(PngAssets.appLogo, width: 100),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      const SizedBox(height: 110),
                      Text(
                        localization.welcomeTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 0,
                          fontSize: 26,
                          color: AppColors.lightTextPrimary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        localization.welcomeSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 0,
                          fontSize: 17,
                          color: AppColors.lightTextTertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 110),
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              onPressed: () => Get.toNamed(BaseRoute.email),
                              text: localization.welcomeCreateAccountButton,
                              backgroundColor: Color(0xFFE4F8EC),
                              textColor: AppColors.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CommonButton(
                              text: localization.welcomeLoginButton,
                              onPressed: () => Get.toNamed(BaseRoute.login),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
