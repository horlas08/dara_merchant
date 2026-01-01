import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_section_navigator.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_transaction_details.dart';
import 'package:qunzo_merchant/src/presentation/screens/transactions/model/transactions_model.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/controller/wallet_details_controller.dart';
import 'package:qunzo_merchant/src/presentation/widgets/no_data_found.dart';
import 'package:qunzo_merchant/src/presentation/widgets/transaction_dynamic_icon.dart';
import 'package:qunzo_merchant/src/presentation/widgets/transactions_dynamic_color.dart';

class WalletDetails extends StatefulWidget {
  const WalletDetails({super.key});

  @override
  State<WalletDetails> createState() => _WalletDetailsState();
}

class _WalletDetailsState extends State<WalletDetails> {
  final WalletDetailsController controller = Get.find();
  final walletId = Get.arguments['wallet_id'];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    loadData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadMoreTransactions();
    }
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchWallets(id: walletId);
    await controller.fetchTransactions(isRefresh: true);
    controller.fetchWallets(id: walletId);
    controller.isLoading.value = false;
  }

  Future<void> _onRefresh() async {
    await controller.fetchTransactions(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Obx(
        () => controller.isLoading.value
            ? CommonLoading()
            : RefreshIndicator(
                color: AppColors.lightPrimary,
                onRefresh: _onRefresh,
                child: Column(
                  children: [
                    _buildHeaderSection(),
                    const SizedBox(height: 30),
                    _buildTransactionsList(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    final localization = AppLocalizations.of(context);
    return Column(
      children: [
        CommonAppBar(title: localization!.walletDetailsTitle),
        const SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: 190,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(PngAssets.walletDetailsCard),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Get.bottomSheet(
                    CommonDropdownBottomSheet(
                      notFoundText: localization.walletDetailsWalletNotFound,
                      title: localization.walletDetailsSelectWalletTitle,
                      dropdownItems: controller.walletsList
                          .map((e) => e.name ?? '')
                          .toList(),
                      selectedItem: controller.walletName,
                      onValueSelected: (value) async {
                        final selectedWallet = controller.walletsList
                            .firstWhere(
                              (w) => w.name == value,
                              orElse: () => controller.walletsList.first,
                            );

                        controller.wallet.value = selectedWallet;
                        controller.walletName.value = selectedWallet.name ?? "";
                        controller.walletIcon.value =
                            (selectedWallet.isDefault == true
                                ? selectedWallet.symbol
                                : selectedWallet.icon) ??
                            "";
                        controller.walletId.value = selectedWallet.id
                            .toString();
                        await controller.fetchTransactions(isRefresh: true);
                      },
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 6,
                    right: 14,
                    top: 8,
                    bottom: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.01),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          controller.wallet.value!.isDefault == true
                              ? Container(
                                  padding: EdgeInsets.all(6),
                                  alignment: Alignment.center,
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightPrimary.withValues(
                                      alpha: 0.16,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.lightPrimary,
                                    child: Transform.translate(
                                      offset: Offset(0, -1),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        controller.walletIcon.value,
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          color: AppColors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(6),
                                  alignment: Alignment.center,
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightPrimary.withValues(
                                      alpha: 0.16,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.transparent,
                                    child: Image.network(
                                      controller.walletIcon.value,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Image.asset(
                                              PngAssets.commonErrorIcon,
                                              color: AppColors.error.withValues(
                                                alpha: 0.7,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                ),
                          const SizedBox(width: 10),
                          Text(
                            controller.walletName.value,
                            style: TextStyle(
                              letterSpacing: 0,
                              color: AppColors.lightTextPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        PngAssets.arrowDownInputIcon,
                        color: AppColors.lightTextPrimary.withValues(
                          alpha: 0.60,
                        ),
                        width: 16,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.walletDetailsTotalBalance,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.60),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${controller.wallet.value!.symbol!}${controller.wallet.value!.formattedBalance!}",
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: CommonButton(
            text: localization.walletDetailsWithdrawButton,
            onPressed: () {
              Get.toNamed(
                BaseRoute.withdraw,
                arguments: {
                  "wallet_id": int.tryParse(controller.walletId.value) ?? 0,
                  "is_wallet_find": true,
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsList() {
    final transactions = controller.allTransactions;

    if (controller.isLoading.value && transactions.isEmpty) {
      return CommonLoading();
    }

    if (transactions.isEmpty) {
      return Expanded(child: NoDataFound());
    }
    final localization = AppLocalizations.of(context);

    return Expanded(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 18, left: 18, right: 18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                HomeSectionNavigator(
                  sectionName: localization!.walletDetailsHistory,
                  onTap: () => Get.toNamed(BaseRoute.transactions),
                ),
                const SizedBox(height: 16),
                Divider(
                  height: 0,
                  color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final Transactions transaction = transactions[index];

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
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.10,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        color:
                                            TransactionDynamicColor.getTransactionColor(
                                              transaction.type,
                                            ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Image.asset(
                                          TransactionDynamicIcon.getTransactionIcon(
                                            transaction.type,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transaction.type ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18,
                                              color: AppColors.lightTextPrimary,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            transaction.createdAt!
                                                .split(",")
                                                .first,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              letterSpacing: 0,
                                              fontSize: 16,
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
                                  fontSize: 18,
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
                      return SizedBox(height: 16);
                    },
                    itemCount: transactions.length,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoadingMore.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
