import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';

class DrawerSection extends StatefulWidget {
  const DrawerSection({super.key});

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
  final HomeController homeController = Get.find();
  final localization = AppLocalizations.of(Get.context!)!;

  late final List<Map<String, dynamic>> navigationItemList = [
    {
      "icon": PngAssets.dashboardEndDrawerIcon,
      "navigation": localization.drawerDashboard,
    },
    {
      "icon": PngAssets.myWalletsEndDrawerIcon,
      "navigation": localization.drawerMyWallets,
    },
    {
      "icon": PngAssets.qrCodeEndDrawerIcon,
      "navigation": localization.drawerQrCode,
    },
    {
      "icon": PngAssets.exchangeEndDrawerIcon,
      "navigation": localization.drawerExchange,
    },
    {
      "icon": PngAssets.apiAccessKeyEndDrawerIcon,
      "navigation": localization.drawerApiAccessKey,
    },
    {
      "icon": PngAssets.transactionEndDrawerIcon,
      "navigation": localization.drawerTransactions,
    },
    {
      "icon": PngAssets.withdrawEndDrawerIcon,
      "navigation": localization.drawerWithdraw,
    },
    {
      "icon": PngAssets.invoiceEndDrawerIcon,
      "navigation": localization.drawerInvoice,
    },
    {
      "icon": PngAssets.notificationEndDrawerIcon,
      "navigation": localization.drawerNotifications,
    },
    {
      "icon": PngAssets.supportEndDrawerIcon,
      "navigation": localization.drawerSupportTicket,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Container(
            width: 320,
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(PngAssets.appLogo, width: 110),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Image.asset(
                          PngAssets.closeCommonIcon,
                          width: 30,
                          color: AppColors.lightTextPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 12),
                            Divider(
                              height: 0,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.10,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      },
                      padding: EdgeInsets.zero,
                      itemCount: navigationItemList.length,
                      itemBuilder: (context, index) {
                        final item = navigationItemList[index];
                        return Obx(() {
                          final bool isSelected =
                              homeController.selectedDrawerIndex.value == index;

                          return InkWell(
                            onTap: () {
                              homeController.selectedDrawerIndex.value = index;

                              final nav = item["navigation"];

                              if (nav == localization.drawerDashboard) {
                                Get.back();
                              } else if (nav ==
                                  localization.drawerNotifications) {
                                Get.toNamed(BaseRoute.notification);
                              } else if (nav == localization.drawerMyWallets) {
                                Get.toNamed(
                                  BaseRoute.wallets,
                                  arguments: {"is_wallet_main_screen": false},
                                );
                              } else if (nav == localization.drawerExchange) {
                                Get.toNamed(BaseRoute.exchange);
                              } else if (nav == localization.drawerQrCode) {
                                Get.toNamed(BaseRoute.qrCode);
                              } else if (nav ==
                                  localization.drawerApiAccessKey) {
                                Get.toNamed(BaseRoute.apiAccessKey);
                              } else if (nav ==
                                  localization.drawerTransactions) {
                                Get.toNamed(BaseRoute.transactions);
                              } else if (nav ==
                                  localization.drawerSupportTicket) {
                                Get.toNamed(BaseRoute.supportTicket);
                              } else if (nav == localization.drawerWithdraw) {
                                Get.toNamed(BaseRoute.withdraw);
                              } else if (nav == localization.drawerInvoice) {
                                Get.toNamed(BaseRoute.invoice);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    item["icon"],
                                    width: 22,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    item["navigation"],
                                    style: TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: isSelected
                                          ? AppColors.lightPrimary
                                          : AppColors.lightTextPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: homeController.isSignOutLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
