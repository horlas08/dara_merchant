import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/controller/create_new_wallet_controller.dart';

class CreateNewWallet extends StatefulWidget {
  const CreateNewWallet({super.key});

  @override
  State<CreateNewWallet> createState() => _CreateNewWalletState();
}

class _CreateNewWalletState extends State<CreateNewWallet> {
  final CreateNewWalletController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              CommonAppBar(title: localization!.createNewWalletTitle),
              const SizedBox(height: 60),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? CommonLoading()
                      : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 18),
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              CommonTextField(
                                isRequired: true,
                                hintText:
                                    localization.createNewWalletSelectCurrency,
                                controller: controller.currencyController,
                                onTap: () {
                                  Get.bottomSheet(
                                    CommonDropdownBottomSheet(
                                      notFoundText: localization
                                          .createNewWalletNoCurrencyFound,
                                      title: localization
                                          .createNewWalletSelectCurrencyTitle,
                                      dropdownItems: controller.currenciesList
                                          .map((item) => item.fullName!)
                                          .toList(),
                                      selectedItem: controller.currency,
                                      onValueSelected: (value) {
                                        final selectedCurrency = controller
                                            .currenciesList
                                            .firstWhere(
                                              (item) => item.fullName == value,
                                            );
                                        controller.currency.value =
                                            selectedCurrency.fullName ?? "";
                                        controller.currencyController.text =
                                            selectedCurrency.fullName ?? "";

                                        controller.currencyId.value =
                                            selectedCurrency.id.toString();
                                      },
                                    ),
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                  );
                                },
                                readOnly: true,
                                labelText:
                                    localization.createNewWalletCurrencyLabel,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                  ),
                                  child: Image.asset(
                                    PngAssets.arrowDownInputIcon,
                                    width: 10,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              CommonButton(
                                onPressed: () => controller.createWallet(),
                                width: double.infinity,
                                text: localization.createNewWalletCreateButton,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isCreateWalletLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
