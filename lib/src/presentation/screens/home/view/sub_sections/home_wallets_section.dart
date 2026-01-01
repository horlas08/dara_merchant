import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_icon_button.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_section_navigator.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/model/wallets_model.dart';

class HomeWalletsSection extends StatefulWidget {
  const HomeWalletsSection({super.key});

  @override
  State<HomeWalletsSection> createState() => _HomeWalletsSectionState();
}

class _HomeWalletsSectionState extends State<HomeWalletsSection> {
  final HomeController homeController = Get.find();
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<String> defaultWalletImages = [
    PngAssets.walletOne,
    PngAssets.walletTwo,
    PngAssets.walletThree,
    PngAssets.walletFour,
    PngAssets.walletFive,
  ];

  List<String> walletImages = [];

  @override
  void initState() {
    super.initState();

    final wallets = homeController.walletsModel.value.data?.wallets ?? [];

    walletImages = List.generate(
      wallets.length,
      (index) => defaultWalletImages[index % defaultWalletImages.length],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final List<Wallets> wallets =
        homeController.walletsModel.value.data?.wallets ?? [];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: HomeSectionNavigator(
            sectionName: localization.homeMyWallets,
            onTap: () => Get.toNamed(BaseRoute.wallets),
          ),
        ),
        SizedBox(height: 10.h),
        if (wallets.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Text(
              localization.homeNoWalletsFound,
              style: TextStyle(
                color: AppColors.lightTextTertiary,
                fontSize: 14.sp,
              ),
            ),
          )
        else
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: wallets.length,
            options: CarouselOptions(
              height: 180.h,
              enlargeCenterPage: true,
              enableInfiniteScroll: wallets.length > 1,
              viewportFraction: 0.85,
              onPageChanged: (index, reason) {
                homeController.currentWalletIndex.value = index;
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final image = walletImages[index];
              final Wallets wallet = wallets[index];

              return InkWell(
                onTap: () {
                  Get.toNamed(
                    BaseRoute.walletsDetails,
                    arguments: {"wallet_id": wallet.id, "wallet_image": image},
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wallet.name ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20.sp,
                                    color: AppColors.white,
                                    overflow: TextOverflow.ellipsis,
                                    letterSpacing: 0,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  wallet.code ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.white,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 28.w,
                              height: 28.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.r),
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2.w,
                                ),
                              ),
                              child: Transform.translate(
                                offset: const Offset(0, -1),
                                child: Text(
                                  wallet.symbol ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13.sp,
                                    color: AppColors.white,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${wallet.symbol}${wallet.formattedBalance}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 24.sp,
                            color: AppColors.white,
                            letterSpacing: 0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        CommonIconButton(
                          onPressed: () {
                            Get.toNamed(
                              BaseRoute.withdraw,
                              arguments: {
                                "wallet_id": wallet.id,
                                "is_wallet_find": true,
                              },
                            );
                          },
                          width: 110,
                          height: 32,
                          text: localization.homeWalletWithdrawButton,
                          icon: PngAssets.walletCardWithdrawIcon,
                          iconWidth: 18,
                          iconHeight: 18,
                          iconAndTextSpace: 5,
                          fontSize: 14,
                          backgroundColor: AppColors.black.withValues(
                            alpha: 0.16,
                          ),
                          borderRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        SizedBox(height: 14.h),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(wallets.length, (index) {
              final bool isActive =
                  homeController.currentWalletIndex.value == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.white
                      : AppColors.lightPrimary.withValues(alpha: 0.24),
                  border: Border.all(
                    color: isActive
                        ? AppColors.lightPrimary
                        : Colors.transparent,
                    width: 2.w,
                  ),
                  borderRadius: BorderRadius.circular(50.r),
                ),
              );
            }),
          );
        }),
      ],
    );
  }
}
