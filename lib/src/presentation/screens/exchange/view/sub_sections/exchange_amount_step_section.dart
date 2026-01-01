import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_wallet_bottom_sheet.dart';
import 'package:qunzo_merchant/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/exchange/controller/exchange_controller.dart';

class ExchangeAmountStepSection extends StatelessWidget {
  const ExchangeAmountStepSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeController controller = Get.find();
    final localization = AppLocalizations.of(context)!;

    return Obx(() {
      if (controller.isLoading.value) {
        return Expanded(child: CommonLoading());
      }

      return Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.lightTextPrimary.withValues(
                          alpha: 0.10,
                        ),
                        width: 1.5.w,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildDynamicValue(
                          label: localization.exchangeFromWalletLabel,
                          value: controller.fromWallet.value!.name ?? "",
                          suffix: Image.asset(
                            PngAssets.arrowDownInputIcon,
                            width: 13.w,
                          ),
                          onTap: () {
                            Get.bottomSheet(
                              CommonDropdownWalletBottomSheet(
                                dropdownTitle:
                                    localization.exchangeSelectFromWalletTitle,
                                notFoundText:
                                    localization.exchangeFromWalletsNotFound,
                                dropdownItems:
                                    controller.fromExchangeWalletsList,
                                bottomSheetHeight: 450.h,
                                currentlySelectedValue:
                                    controller.fromWallet.value!.name ?? "",
                                onItemSelected: (value) async {
                                  final selectedWallet = controller
                                      .fromExchangeWalletsList
                                      .firstWhere((w) => w.name == value);
                                  controller.fromWallet.value = selectedWallet;
                                  controller.calculateExchange();
                                },
                              ),
                            );
                          },
                        ),
                        Divider(
                          height: 0,
                          color: AppColors.lightTextPrimary.withValues(
                            alpha: 0.10,
                          ),
                          thickness: 2,
                        ),
                        _buildDynamicValue(
                          label: localization.exchangeToWalletLabel,
                          value: controller.toWallet.value!.name ?? "",
                          suffix: Image.asset(
                            PngAssets.arrowDownInputIcon,
                            width: 13.w,
                          ),
                          onTap: () {
                            Get.bottomSheet(
                              CommonDropdownWalletBottomSheet(
                                dropdownTitle:
                                    localization.exchangeSelectToWalletTitle,
                                notFoundText:
                                    localization.exchangeToWalletsNotFound,
                                dropdownItems: controller.toExchangeWalletsList,
                                bottomSheetHeight: 450.h,
                                currentlySelectedValue:
                                    controller.toWallet.value!.name ?? "",
                                onItemSelected: (value) async {
                                  final selectedWallet = controller
                                      .toExchangeWalletsList
                                      .firstWhere((w) => w.name == value);
                                  controller.toWallet.value = selectedWallet;
                                  controller.calculateExchange();
                                },
                              ),
                            );
                          },
                        ),
                        Divider(
                          height: 0,
                          color: AppColors.lightTextPrimary.withValues(
                            alpha: 0.10,
                          ),
                          thickness: 2,
                        ),
                        _buildDynamicValue(
                          label: localization.exchangeAmountLabel,
                          controller: controller.amountController,
                          isEditable: true,
                          suffix: Text(
                            controller.fromWallet.value?.code ?? "",
                            style: TextStyle(
                              letterSpacing: 0,
                              fontSize: 14.sp,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.30,
                              ),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: controller.fromExchangeWalletsList.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      localization.exchangeMinMaxLabel(
                        controller.fromWallet.value!.code!,
                        controller.fromWallet.value!.exchangeLimit!.max!,
                        controller.fromWallet.value!.exchangeLimit!.min!,
                      ),
                      style: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                localization.exchangeRateLabel,
                style: TextStyle(
                  letterSpacing: 0,
                  fontSize: 14.sp,
                  color: AppColors.lightTextTertiary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Obx(() {
                final fromCode = controller.fromWallet.value?.code ?? "";
                final toCode = controller.toWallet.value?.code ?? "";
                final rate = controller.exchangeRate.value;

                return Text(
                  "1 $fromCode = ${rate.toStringAsFixed(DynamicDecimalsHelper().getDynamicDecimals(currencyCode: controller.toWallet.value!.name!, siteCurrencyCode: Get.find<SettingsService>().getSetting("site_currency")!, siteCurrencyDecimals: Get.find<SettingsService>().getSetting("site_currency_decimals")!, isCrypto: controller.toWallet.value!.isCrypto!))} $toCode",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightTextPrimary,
                    letterSpacing: 0,
                    fontSize: 15.sp,
                  ),
                );
              }),
              SizedBox(height: 40.h),
              CommonButton(
                text: localization.exchangeButton,
                onPressed: () => controller.nextStepWithValidation(),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDynamicValue({
    required String label,
    required Widget suffix,
    String? value,
    GestureTapCallback? onTap,
    TextEditingController? controller,
    bool isEditable = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
        child: Row(
          children: [
            SizedBox(
              width: 90.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontSize: 13.sp,
                      color: AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                    child: VerticalDivider(
                      thickness: 2,
                      width: 0,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: isEditable
                  ? TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 14.sp,
                        color: AppColors.lightTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    )
                  : Text(
                      value ?? "",
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 14.sp,
                        color: AppColors.lightTextPrimary,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
            ),
            suffix,
          ],
        ),
      ),
    );
  }
}
