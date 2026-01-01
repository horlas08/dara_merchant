import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_transaction_details.dart';
import 'package:qunzo_merchant/src/presentation/screens/transactions/controller/transactions_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/transactions/view/sub_sections/transaction_filter_bottom_sheet.dart';
import 'package:qunzo_merchant/src/presentation/screens/transactions/view/sub_sections/transaction_type_list.dart';
import 'package:qunzo_merchant/src/presentation/widgets/no_data_found.dart';
import 'package:qunzo_merchant/src/presentation/widgets/transaction_dynamic_icon.dart';
import 'package:qunzo_merchant/src/presentation/widgets/transactions_dynamic_color.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with WidgetsBindingObserver {
  final TransactionsController controller = Get.put(TransactionsController());
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    loadData();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        controller.hasMorePages.value &&
        !controller.isPageLoading.value) {
      controller.loadMoreTransactions();
    }
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchTransactions();
    controller.isLoading.value = false;
  }

  Future<void> refreshData() async {
    if (controller.hasActiveFilters()) {
      controller.isLoading.value = true;
      await controller.fetchDynamicTransactions();
      controller.isLoading.value = false;
    } else {
      controller.isLoading.value = true;
      await controller.fetchTransactions();
      controller.isLoading.value = false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                CommonAppBar(
                  title: localization!.transactionsScreenTitle,
                  showRightSideWidget: true,
                  rightSideWidget: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(TransactionFilterBottomSheet());
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.r),
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Image.asset(PngAssets.commonFilterIcon),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return CommonLoading();
                    }

                    return Column(
                      children: [
                        SizedBox(height: 30.h, child: TransactionTypeList()),
                        SizedBox(height: 20.h),
                        Divider(
                          indent: 18.w,
                          endIndent: 18.w,
                          height: 0,
                          color: AppColors.lightTextPrimary.withValues(
                            alpha: 0.10,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        _buildTransactionsList(),
                      ],
                    );
                  }),
                ),
              ],
            ),
            Visibility(
              visible:
                  controller.isTransactionsLoading.value ||
                  controller.isPageLoading.value,
              child: const CommonLoading(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    final transactions =
        controller.transactionsModel.value.data?.transactions ?? [];

    if (controller.isLoading.value) {
      return Expanded(child: CommonLoading());
    }

    if (transactions.isEmpty) {
      return Expanded(child: NoDataFound());
    }

    return Expanded(
      child: RefreshIndicator(
        color: AppColors.lightPrimary,
        onRefresh: () => refreshData(),
        child: controller.isLoading.value
            ? CommonLoading()
            : Container(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: ListView.separated(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 30.h, top: 20.h),
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
                      borderRadius: BorderRadius.circular(8.r),
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
                                            fontSize: 16.sp,
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
              ),
      ),
    );
  }
}
