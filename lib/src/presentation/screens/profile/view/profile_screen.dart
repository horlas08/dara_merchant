import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_icon_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';

class ProfileScreen extends StatefulWidget {
  final bool? isProfileMainScreen;

  const ProfileScreen({super.key, this.isProfileMainScreen = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileController userProfileController = Get.find();
  final HomeController homeController = Get.find();

  final bool isProfileMainScreen =
      (Get.arguments != null && Get.arguments is Map<String, dynamic>)
      ? Get.arguments["is_profile_main_screen"] ?? false
      : false;

  void _handleBackNavigation() {
    if (widget.isProfileMainScreen == true || isProfileMainScreen == true) {
      final HomeController homeController = Get.find();
      if (homeController.selectedIndex.value == 0) {
        Get.back();
      } else if (homeController.selectedIndex.value == 2) {
        homeController.selectedIndex.value = 0;
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
    userProfileController.loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, __) {
          if (!didPop) {
            _handleBackNavigation();
          }
        },
        child: Stack(
          children: [
            Obx(() {
              if (userProfileController.isLoading.value) {
                return CommonLoading();
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(PngAssets.profileScreenFrame),
                            Positioned(
                              top: 85,
                              left: 18,
                              child: Text(
                                localization!.profileScreenTitle,
                                style: TextStyle(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 26,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform.translate(
                          offset: Offset(0, -63),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(height: 80),
                                    Text(
                                      userProfileController
                                              .userProfileModel
                                              .value
                                              .data!
                                              .user!
                                              .fullName ??
                                          "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 22,
                                        color: AppColors.lightTextPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "@${userProfileController.userProfileModel.value.data!.user!.username ?? "Unknown"}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: AppColors.lightTextPrimary
                                            .withValues(alpha: 0.80),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Column(
                                        children: [
                                          _buildNavigationSection(
                                            title: localization
                                                .profileScreenProfileSettings,
                                            icon: PngAssets
                                                .profileSettingsProfileIcon,
                                            onTap: () => Get.toNamed(
                                              BaseRoute.profileSettings,
                                            ),
                                          ),
                                          _buildNavigationSection(
                                            title: localization
                                                .profileScreenChangePassword,
                                            icon: PngAssets
                                                .changePasswordProfileIcon,
                                            onTap: () => Get.toNamed(
                                              BaseRoute.changePassword,
                                            ),
                                          ),
                                          Get.find<SettingsService>()
                                                      .getSetting(
                                                        "language_switcher",
                                                      ) ==
                                                  "1"
                                              ? _buildNavigationSection(
                                                  title: localization
                                                      .profileScreenLanguage,
                                                  icon: PngAssets
                                                      .languageProfileIcon,
                                                  onTap: () {
                                                    Get.bottomSheet(
                                                      CommonDropdownBottomSheet(
                                                        title: localization
                                                            .profileScreenSelectLanguageTitle,
                                                        dropdownItems: [
                                                          "English",
                                                        ],
                                                        selectedItem:
                                                            homeController
                                                                .language,
                                                        onValueSelected:
                                                            (value) async {
                                                              await homeController
                                                                  .changeLanguage(
                                                                    value,
                                                                  );
                                                            },
                                                      ),
                                                    );
                                                  },
                                                  isRightSideWidget: true,
                                                  rightSideWidget: Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            homeController
                                                                .language
                                                                .value,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color: AppColors
                                                                  .lightTextPrimary
                                                                  .withValues(
                                                                    alpha: 0.60,
                                                                  ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 16),
                                                          Image.asset(
                                                            PngAssets
                                                                .arrowRightCommonIcon,
                                                            color: AppColors
                                                                .lightTextPrimary
                                                                .withValues(
                                                                  alpha: 0.60,
                                                                ),
                                                            width: 18,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                          _buildNavigationSection(
                                            title: localization
                                                .profileScreenBiometric,
                                            icon:
                                                PngAssets.biometricProfileIcon,
                                            onTap: () async {
                                              await homeController
                                                  .toggleBiometric();
                                            },
                                            isRightSideWidget: true,
                                            rightSideWidget: Obx(
                                              () => Transform.scale(
                                                scale: 0.8,
                                                child: Switch(
                                                  padding: EdgeInsets.zero,
                                                  value: homeController
                                                      .isBiometricEnable
                                                      .value,
                                                  activeThumbColor:
                                                      AppColors.lightPrimary,
                                                  inactiveThumbColor: AppColors
                                                      .lightTextTertiary,
                                                  inactiveTrackColor: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.05),
                                                  onChanged: (_) async {
                                                    await homeController
                                                        .toggleBiometric();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          _buildNavigationSection(
                                            title: localization
                                                .profileScreenLogout,
                                            icon: PngAssets.logoutProfileIcon,
                                            onTap: () =>
                                                Get.find<HomeController>()
                                                    .submitLogout(),
                                            titleColor: AppColors.error,
                                          ),
                                          const SizedBox(height: 40),
                                          CommonIconButton(
                                            onPressed: () =>
                                                _handleBackNavigation(),
                                            backgroundColor: Color(
                                              0xFF4CD080,
                                            ).withValues(alpha: 0.06),
                                            textColor:
                                                AppColors.lightTextPrimary,
                                            iconColor:
                                                AppColors.lightTextPrimary,
                                            borderColor: Color(
                                              0xFF4CD080,
                                            ).withValues(alpha: 0.40),
                                            borderWidth: 2,
                                            text: localization
                                                .profileScreenBackButton,
                                            icon:
                                                PngAssets.arrowLeftProfileIcon,
                                            iconWidth: 22,
                                            iconHeight: 22,
                                            iconAndTextSpace: 10,
                                          ),
                                          const SizedBox(height: 35),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: -50,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      width: 115,
                                      height: 115,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: Image.network(
                                          userProfileController
                                              .userProfileModel
                                              .value
                                              .data!
                                              .user!
                                              .avatar!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
            Obx(
              () => Visibility(
                visible: Get.find<HomeController>().isSignOutLoading.value,
                child: CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationSection({
    required String title,
    required String icon,
    required VoidCallback onTap,
    Color? titleColor,
    bool isRightSideWidget = false,
    Widget? rightSideWidget,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(height: isRightSideWidget == true ? 10 : 20),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(icon, width: 22),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: titleColor ?? AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              if (isRightSideWidget && rightSideWidget != null)
                rightSideWidget
              else
                const SizedBox.shrink(),
            ],
          ),
          SizedBox(height: isRightSideWidget == true ? 10 : 20),
          Divider(
            height: 0,
            color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
          ),
        ],
      ),
    );
  }
}
