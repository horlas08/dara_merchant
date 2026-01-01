import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_section_navigator.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_transaction_details.dart';
import 'package:qunzo_merchant/src/presentation/widgets/no_data_found.dart';
import 'package:qunzo_merchant/src/presentation/widgets/transaction_dynamic_icon.dart';
import 'package:qunzo_merchant/src/presentation/widgets/transactions_dynamic_color.dart';

class HomeTransactionsSection extends StatelessWidget {
  const HomeTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final localization = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.only(top: 18.w, left: 18.w, right: 18.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        children: [
          HomeSectionNavigator(
            sectionName: localization.homeRecentTransactions,
            onTap: () => Get.toNamed(BaseRoute.transactions),
          ),
          SizedBox(height: 16.h),
          Divider(
            height: 0,
            color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
          ),
          SizedBox(height: 16.h),
          controller.transactionsModel.value.data!.transactions!.isEmpty
              ? SizedBox(
                  height: ScreenUtil().screenHeight * 0.2,
                  child: NoDataFound(),
                )
              : ListView.separated(
                  padding: EdgeInsets.only(bottom: 30.h),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final transaction = controller
                        .transactionsModel
                        .value
                        .data!
                        .transactions![index];

                    final calculateDecimals = DynamicDecimalsHelper()
                        .getDynamicDecimals(
                          currencyCode: transaction.trxCurrencyCode!,
                          siteCurrencyCode: Get.find<SettingsService>()
                              .getSetting("site_currency")!,
                          siteCurrencyDecimals: Get.find<SettingsService>()
                              .getSetting("site_currency_decimals")!,
                          isCrypto: transaction.isCrypto!,
                        );

                    final symbol = transaction.trxCurrencySymbol ?? '';
                    final amountValue =
                        double.tryParse(
                          transaction.amount!.replaceAll(",", ""),
                        ) ??
                        0.0;

                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Get.bottomSheet(
                          HomeTransactionDetails(transaction: transaction),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.lightTextPrimary.withValues(
                              alpha: 0.10,
                            ),
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: 42.w,
                                    height: 42.w,
                                    decoration: BoxDecoration(
                                      color:
                                          TransactionDynamicColor.getTransactionColor(
                                            transaction.type,
                                          ),
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: Image.asset(
                                        TransactionDynamicIcon.getTransactionIcon(
                                          transaction.type,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction.type ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15.sp,
                                            color: AppColors.lightTextPrimary,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          transaction.createdAt!
                                              .split(",")
                                              .first,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            fontSize: 13.sp,
                                            color: AppColors.lightTextPrimary
                                                .withValues(alpha: 0.30),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              "$symbol${amountValue.toStringAsFixed(calculateDecimals)}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.sp,
                                color: transaction.isPlus == true
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12.h);
                  },
                  itemCount: controller
                      .transactionsModel
                      .value
                      .data!
                      .transactions!
                      .length,
                ),
        ],
      ),
    );
  }
}
