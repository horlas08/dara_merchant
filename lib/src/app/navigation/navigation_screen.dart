import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/svg_assets.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/home_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/drawer/drawer_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/settings_bottom_sheet.dart';
import 'package:qunzo_merchant/src/presentation/screens/profile/view/profile_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/view/wallets_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController homeController = Get.find<HomeController>();

  late List<Widget> pageStacks;

  @override
  void initState() {
    super.initState();
    homeController.setScaffoldKey(_scaffoldKey);

    pageStacks = [
      HomeScreen(),
      WalletsScreen(isWalletMainScreen: true),
      ProfileScreen(isProfileMainScreen: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final labelList = [
      localization.navigationHome,
      localization.navigationWallets,
      localization.navigationProfile,
      localization.navigationSetting,
    ];

    final iconList = [
      SvgAssets.homeBottomSheetIcon,
      SvgAssets.walletsBottomSheetIcon,
      SvgAssets.profileBottomSheetIcon,
      SvgAssets.settingsBottomSheetIcon,
    ];

    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        body: pageStacks[homeController.selectedIndex.value],
        drawer: DrawerSection(),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: 90,
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive
                ? AppColors.lightPrimary
                : AppColors.lightTextPrimary.withValues(alpha: 0.30);

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconList[index],
                  width: 28,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                const SizedBox(height: 6),
                Text(
                  labelList[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 0,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.visible,
                    color: color,
                  ),
                ),
              ],
            );
          },
          backgroundColor: AppColors.white,
          activeIndex: homeController.selectedIndex.value,
          gapLocation: GapLocation.none,
          onTap: (index) {
            if (index == 3) {
              Get.bottomSheet(SettingsBottomSheet());
            } else {
              homeController.selectedIndex.value = index;
            }
          },
          shadow: BoxShadow(
            offset: const Offset(0, -4),
            blurRadius: 40,
            spreadRadius: 0,
            color: AppColors.black.withValues(alpha: 0.10),
          ),
        ),
      ),
    );
  }
}
