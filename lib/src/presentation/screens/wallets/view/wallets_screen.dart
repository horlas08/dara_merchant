import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_icon_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/controller/wallets_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/view/sub_sections/delete_wallet_bottom_sheet.dart';
import 'package:qunzo_merchant/src/presentation/widgets/no_data_found.dart';

class WalletsScreen extends StatefulWidget {
  final bool? isWalletMainScreen;

  const WalletsScreen({super.key, this.isWalletMainScreen = false});

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  final WalletsController controller = Get.put(WalletsController());
  final HomeController homeController = Get.find();
  final bool isWalletMainScreen =
      (Get.arguments != null && Get.arguments is Map<String, dynamic>)
      ? Get.arguments["is_wallet_main_screen"] ?? false
      : false;

  final List<String> defaultWalletImages = [
    PngAssets.walletOne,
    PngAssets.walletTwo,
    PngAssets.walletThree,
    PngAssets.walletFour,
    PngAssets.walletFive,
  ];

  Future<void> _handleBackNavigation() async {
    if (widget.isWalletMainScreen == true || isWalletMainScreen == true) {
      if (homeController.selectedIndex.value == 0) {
        Get.back();
      } else if (homeController.selectedIndex.value == 1) {
        homeController.selectedIndex.value = 0;
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, __) {
        if (!didPop) {
          _handleBackNavigation();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          appBar: CommonDefaultAppBar(),
          body: Column(
            children: [
              CommonAppBar(
                title: localization!.walletsScreenTitle,
                showRightSideWidget: true,
                isBackLogicApply: true,
                backLogicFunction: () {
                  _handleBackNavigation();
                },
                rightSideWidget: GestureDetector(
                  onTap: () => Get.toNamed(BaseRoute.createNewWallet),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.asset(PngAssets.addCircleCommonIcon),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return CommonLoading();
                  }

                  final wallets = controller.walletsList;

                  if (wallets.isEmpty) {
                    return NoDataFound();
                  }

                  final walletImages = List.generate(
                    wallets.length,
                    (index) =>
                        defaultWalletImages[index % defaultWalletImages.length],
                  );

                  return RefreshIndicator(
                    color: AppColors.lightPrimary,
                    onRefresh: () => controller.fetchWallets(),
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 30, top: 30),
                      itemCount: wallets.length,
                      itemBuilder: (context, index) {
                        final wallet = wallets[index];
                        final image = walletImages[index];

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              BaseRoute.walletsDetails,
                              arguments: {"wallet_id": wallet.id},
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 210,
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(image),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 18,
                                    top: 18,
                                    right: 18,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              wallet.name ?? "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20,
                                                color: AppColors.white,
                                                overflow: TextOverflow.ellipsis,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              wallet.code ?? "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: AppColors.white,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            wallet.symbol ?? "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16,
                                              color: AppColors.white,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                  ),
                                  child: Text(
                                    "${wallet.symbol}${wallet.formattedBalance}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 24,
                                      color: AppColors.white,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 18,
                                    right: 18,
                                    bottom: 18,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonIconButton(
                                        backgroundColor: AppColors.black
                                            .withValues(alpha: 0.16),
                                        borderRadius: 6,
                                        fontSize: 14,
                                        width: 115,
                                        height: 35,
                                        text: localization
                                            .walletsScreenWithdrawButton,
                                        icon: PngAssets.walletCardWithdrawIcon,
                                        iconWidth: 16,
                                        iconHeight: 16,
                                        iconAndTextSpace: 5,
                                        onPressed: () {
                                          Get.toNamed(
                                            BaseRoute.withdraw,
                                            arguments: {
                                              "wallet_id": wallet.id,
                                              "is_wallet_find": true,
                                            },
                                          );
                                        },
                                      ),
                                      if (wallet.isDefault == false)
                                        CommonButton(
                                          borderRadius: 6,
                                          width: 70,
                                          height: 35,
                                          fontSize: 14,
                                          backgroundColor: AppColors.error,
                                          text: localization
                                              .walletsScreenDeleteButton,
                                          onPressed: () {
                                            Get.bottomSheet(
                                              DeleteWalletBottomSheet(
                                                walletId: wallet.id.toString(),
                                              ),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
