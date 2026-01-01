import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/exchange/controller/exchange_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';

class ExchangeSuccessStepSection extends StatefulWidget {
  const ExchangeSuccessStepSection({super.key});

  @override
  State<ExchangeSuccessStepSection> createState() =>
      _ExchangeSuccessStepSectionState();
}

class _ExchangeSuccessStepSectionState
    extends State<ExchangeSuccessStepSection> {
  final ExchangeController controller = Get.find();
  final settingsService = Get.find<SettingsService>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final calculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
      currencyCode: controller.toWallet.value!.code!,
      siteCurrencyCode: settingsService.getSetting("site_currency")!,
      siteCurrencyDecimals: settingsService.getSetting(
        "site_currency_decimals",
      )!,
      isCrypto:
          controller.successExchangeData.value!["transaction"]["is_crypto"],
    );

    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color(0xFF2C874F)),
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: ScreenUtil().screenHeight,
                  child: Image.asset(
                    PngAssets.withdrawSuccessShape,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().screenHeight * 0.85,
                  child: Image.asset(
                    PngAssets.withdrawSuccessFrame,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: ScreenUtil().screenHeight - 40.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              PngAssets.exchangeSuccessImage,
                              width: 70.w,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              localization.exchangeSuccessTitle,
                              style: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.w900,
                                fontSize: 20.sp,
                                color: AppColors.lightTextPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              localization.exchangeSuccessSubtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                color: AppColors.lightTextPrimary.withValues(
                                  alpha: 0.30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Container(
                          margin: EdgeInsets.only(top: 50.h),
                          width: 315.w,
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.10,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildSuccessDynamicContent(
                                title: localization.exchangeSuccessAmount,
                                content:
                                    "${double.tryParse(controller.amountController.text)?.toStringAsFixed(calculateDecimals)} ${controller.successExchangeData.value!["transaction"]["pay_currency"]}",
                                contentColor: AppColors.lightTextPrimary,
                              ),
                              SizedBox(height: 15.h),
                              _buildSuccessDynamicContent(
                                title:
                                    localization.exchangeSuccessTransactionId,
                                content: controller
                                    .successExchangeData
                                    .value!["transaction"]["tnx"],
                                contentColor: AppColors.lightTextPrimary,
                              ),
                              SizedBox(height: 15.h),
                              _buildSuccessDynamicContent(
                                title:
                                    localization.exchangeSuccessConvertedAmount,
                                content:
                                    "${double.tryParse(controller.successExchangeData.value!["transaction"]["amount"].toString())?.toStringAsFixed(calculateDecimals)} "
                                    "(${controller.successExchangeData.value!["transaction"]["receive_currency"]})",
                                contentColor: AppColors.lightTextPrimary,
                              ),
                              SizedBox(height: 15.h),
                              _buildSuccessDynamicContent(
                                title: localization.exchangeSuccessCharge,
                                content:
                                    "${double.tryParse(controller.successExchangeData.value!["transaction"]["charge"].toString())?.toStringAsFixed(calculateDecimals)} ${controller.successExchangeData.value!["transaction"]["pay_currency"]}",
                                contentColor: AppColors.error,
                              ),
                              SizedBox(height: 15.h),
                              _buildSuccessDynamicContent(
                                title: localization.exchangeSuccessDate,
                                content: controller
                                    .successExchangeData
                                    .value!["transaction"]["created_at"],
                                contentColor: AppColors.lightTextPrimary,
                              ),
                              SizedBox(height: 15.h),
                              _buildSuccessDynamicContent(
                                title: localization.exchangeSuccessFinalAmount,
                                content:
                                    "${double.tryParse(controller.successExchangeData.value!["transaction"]["final_amount"].toString())?.toStringAsFixed(calculateDecimals)} ${controller.successExchangeData.value!["transaction"]["pay_currency"]}",
                                contentColor: AppColors.lightTextPrimary,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: CommonButton(
                            onPressed: () {
                              Get.delete<ExchangeController>();
                              Get.offNamed(BaseRoute.navigation);
                              Get.find<HomeController>().loadData();
                            },
                            textColor: AppColors.white,
                            text: localization.exchangeSuccessBackHomeButton,
                            backgroundColor: AppColors.lightPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: CommonButton(
                            onPressed: () async {
                              controller.clearFields();
                              controller.currentStep.value = 0;
                              controller.isLoading.value = true;
                              await controller.fetchWallets();
                              controller.isLoading.value = false;
                            },
                            textColor: AppColors.lightTextPrimary.withValues(
                              alpha: 0.60,
                            ),
                            text:
                                localization.exchangeSuccessExchangeAgainButton,
                            backgroundColor: AppColors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSuccessDynamicContent({
    required String title,
    required String content,
    required Color contentColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13.sp,
            color: AppColors.lightTextPrimary.withValues(alpha: 0.60),
            letterSpacing: 0,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: Text(
              content,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
                color: contentColor,
                letterSpacing: 0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}
