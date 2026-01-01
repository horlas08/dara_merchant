import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet_two.dart';
import 'package:qunzo_merchant/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/controller/withdraw_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/model/withdraw_account_model.dart';

class WithdrawAmountStepSection extends StatelessWidget {
  const WithdrawAmountStepSection({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawController controller = Get.find();
    final localization = AppLocalizations.of(context);

    return Obx(
      () => controller.isLoading.value
          ? CommonLoading()
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  _buildWalletSection(controller, context),
                  const SizedBox(height: 30),
                  _buildAccountAndAmountSection(controller, context),
                  const SizedBox(height: 30),
                  CommonButton(
                    width: double.infinity,
                    text: localization!.withdrawAmountStepContinueButton,
                    onPressed: () {
                      controller.nextStepWithValidation();
                    },
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
    );
  }

  Widget _buildAccountAndAmountSection(WithdrawController controller, context) {
    final localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              _buildDynamicValue(
                label: localization!.withdrawAmountStepAccount,
                value: controller.withdrawAccount.value?.methodName ?? "",
                suffix: Image.asset(PngAssets.arrowDownInputIcon, width: 15),
                onTap: () {
                  Get.bottomSheet(
                    CommonDropdownBottomSheetTwo(
                      title: localization
                          .withdrawAmountStepSelectWithdrawAccountTitle,
                      notFoundText: localization
                          .withdrawAmountStepWithdrawAccountNotFound,
                      dropdownItems: controller.accountList
                          .map((item) => "${item.id}|${item.methodName}")
                          .toList(),
                      height: 450,
                      selectedItem: controller.withdrawAccountName,
                      showOnlyDisplayName: true,
                      onValueSelected: (value) async {
                        final parts = value.split('|');

                        if (parts.length >= 2) {
                          final id = int.parse(parts[0]);

                          final selectedWithdrawAccount = controller.accountList
                              .firstWhere(
                                (item) => item.id == id,
                                orElse: () => Accounts(),
                              );

                          controller.withdrawAccount.value =
                              selectedWithdrawAccount;
                          controller.withdrawAccountName.value = value;
                          controller.amountController.clear();
                        }
                      },
                    ),
                    isScrollControlled: true,
                  );
                },
              ),
              Divider(
                height: 0,
                color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
                thickness: 2,
              ),
              _buildDynamicValue(
                label: localization.withdrawAmountStepAmount,
                controller: controller.amountController,
                isEditable: true,
                suffix: Text(
                  controller.wallet.value?.code ?? "",
                  style: TextStyle(
                    letterSpacing: 0,
                    fontSize: 16,
                    color: AppColors.lightTextPrimary.withValues(alpha: 0.30),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          final withdrawAccount = controller.withdrawAccount.value;
          final hasAccount =
              withdrawAccount != null &&
              controller.withdrawAccountName.isNotEmpty;

          if (!hasAccount) {
            return const SizedBox.shrink();
          }

          final calculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
            currencyCode: withdrawAccount.currency ?? "",
            siteCurrencyCode:
                Get.find<SettingsService>().getSetting("site_currency") ?? "",
            siteCurrencyDecimals:
                Get.find<SettingsService>().getSetting(
                  "site_currency_decimals",
                ) ??
                "2",
            isCrypto: withdrawAccount.method?.isCrypto ?? false,
          );

          final min =
              double.tryParse(
                withdrawAccount.method?.minWithdraw ?? "0",
              )?.toStringAsFixed(calculateDecimals) ??
              "0.00";

          final max =
              double.tryParse(
                withdrawAccount.method?.maxWithdraw ?? "0",
              )?.toStringAsFixed(calculateDecimals) ??
              "0.00";

          return Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              localization.withdrawAmountStepMinMaxAmount(
                withdrawAccount.currency!,
                max,
                min,
              ),
              style: TextStyle(
                letterSpacing: 0,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: AppColors.error,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildWalletSection(WithdrawController controller, context) {
    final localization = AppLocalizations.of(context);
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          CommonDropdownBottomSheet(
            title: localization!.withdrawAmountStepSelectWalletTitle,
            notFoundText: localization.withdrawAmountStepWalletsNotFound,
            dropdownItems: controller.walletsList
                .map((item) => item.name!)
                .toList(),
            height: 450,
            selectedItem: controller.walletName,
            onValueSelected: (value) async {
              final selectedWallet = controller.walletsList.firstWhere(
                (item) => item.name == value,
                orElse: () {
                  return controller.walletsList.first;
                },
              );

              controller.wallet.value = selectedWallet;
              controller.walletName.value = selectedWallet.name ?? "";
              controller.withdrawAccountName.value = "";
              controller.withdrawAccount.value = null;
              controller.accountList.clear();
              controller.amountController.clear();
              controller.isWithdrawAccountLoading.value = true;
              await controller.fetchWithdrawAccounts();
              controller.isWithdrawAccountLoading.value = false;
            },
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(PngAssets.walletCard),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.wallet.value?.name ?? "",
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 14,
                        color: AppColors.lightTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(PngAssets.arrowDownInputIcon, width: 15),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "${controller.wallet.value!.symbol}${controller.wallet.value!.formattedBalance}",
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontSize: 16,
                      color: AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                    child: VerticalDivider(
                      thickness: 2,
                      width: 0,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: isEditable
                  ? TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 18,
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
                        fontSize: 18,
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
