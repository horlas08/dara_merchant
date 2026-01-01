import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return AnimatedContainer(
      width: double.infinity,
      duration: const Duration(milliseconds: 300),
      height: 350,
      curve: Curves.easeOutQuart,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 40,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavigationSection(
                  title: localization.settingsProfileSetting,
                  iconPath: PngAssets.profileSettingIcon,
                  onTap: () {
                    Get.back();
                    Get.toNamed(BaseRoute.profileSettings);
                  },
                ),
                const Spacer(),
                _buildNavigationSection(
                  title: localization.settingsChangePassword,
                  iconPath: PngAssets.changePasswordIcon,
                  onTap: () {
                    Get.back();
                    Get.toNamed(BaseRoute.changePassword);
                  },
                ),
                const Spacer(),
                _buildNavigationSection(
                  title: localization.settingsIdVerification,
                  iconPath: PngAssets.idVerificationIcon,
                  onTap: () {
                    Get.back();
                    Get.toNamed(BaseRoute.kycHistory);
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible:
                      Get.find<SettingsService>().getSetting(
                        "fa_verification",
                      ) ==
                      "1",
                  child: _buildNavigationSection(
                    title: localization.settingsTwoFa,
                    iconPath: PngAssets.twoFaAuthenticationIcon,
                    onTap: () {
                      Get.back();
                      Get.toNamed(BaseRoute.twoFaAuthentication);
                    },
                  ),
                ),
                Visibility(
                  visible:
                      Get.find<SettingsService>().getSetting(
                        "fa_verification",
                      ) ==
                      "1",
                  child: Spacer(),
                ),
                _buildNavigationSection(
                  title: localization.settingsSupport,
                  iconPath: PngAssets.supportIcon,
                  onTap: () {
                    Get.back();
                    Get.toNamed(BaseRoute.supportTicket);
                  },
                ),
                const Spacer(),
                _buildNavigationSection(
                  title: localization.settingsLogout,
                  iconPath: PngAssets.logoutIcon,
                  onTap: () {
                    Get.back();
                    Get.find<HomeController>().submitLogout();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationSection({
    required String title,
    required String iconPath,
    required GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xFF043844).withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Image.asset(iconPath),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                  letterSpacing: 0,
                  color: AppColors.lightTextPrimary.withValues(alpha: 0.80),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
