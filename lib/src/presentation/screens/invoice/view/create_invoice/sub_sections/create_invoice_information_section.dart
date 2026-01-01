import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/common_single_date_picker.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_wallet_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/controller/create_invoice_controller.dart';

class CreateInvoiceInformationSection extends StatefulWidget {
  const CreateInvoiceInformationSection({super.key});

  @override
  State<CreateInvoiceInformationSection> createState() =>
      _CreateInvoiceInformationSectionState();
}

class _CreateInvoiceInformationSectionState
    extends State<CreateInvoiceInformationSection> {
  final CreateInvoiceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization!.createInvoiceInformationTitle,
          style: TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            color: AppColors.lightTextPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.only(
            left: 18.w,
            right: 18.w,
            bottom: 24.h,
            top: 2.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              CommonTextField(
                isRequired: true,
                backgroundColor: AppColors.transparent,
                labelText: localization.createInvoiceInformationInvoiceTo,
                controller: controller.invoiceToController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.h),
              CommonTextField(
                isRequired: true,
                backgroundColor: AppColors.transparent,
                labelText: localization.createInvoiceInformationEmailAddress,
                controller: controller.emailAddressToController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              CommonTextField(
                isRequired: true,
                backgroundColor: AppColors.transparent,
                labelText: localization.createInvoiceInformationAddress,
                controller: controller.addressController,
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: 16.h),
              CommonTextField(
                isRequired: true,
                backgroundColor: AppColors.transparent,
                onTap: () {
                  Get.bottomSheet(
                    CommonDropdownWalletBottomSheet(
                      dropdownTitle: localization
                          .createInvoiceInformationSelectWalletTitle,
                      notFoundText:
                          localization.createInvoiceInformationWalletsNotFound,
                      dropdownItems: controller.walletsList,
                      bottomSheetHeight: 450.h,
                      currentlySelectedValue:
                          controller.wallet.value?.name ?? "",
                      onItemSelected: (value) async {
                        final selectedWallet = controller.walletsList
                            .firstWhere((w) => w.name == value);
                        controller.wallet.value = selectedWallet;
                        controller.walletController.text =
                            controller.wallet.value?.name ?? "";
                      },
                    ),
                  );
                },
                labelText:
                    localization.createInvoiceInformationSelectWalletTitle,
                controller: controller.walletController,
                readOnly: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Image.asset(PngAssets.arrowDownInputIcon, width: 10.w),
                ),
              ),
              SizedBox(height: 16.h),
              CommonTextField(
                isRequired: true,
                backgroundColor: AppColors.transparent,
                onTap: () {
                  Get.bottomSheet(
                    CommonDropdownBottomSheet(
                      notFoundText:
                          localization.createInvoiceInformationWalletsNotFound,
                      title: localization
                          .createInvoiceInformationSelectStatusTitle,
                      dropdownItems: ["Draft", "Published"],
                      selectedItem: controller.status,
                      onValueSelected: (value) {
                        controller.status.value = value;
                        controller.statusController.text = value;
                      },
                    ),
                  );
                },
                labelText: localization.createInvoiceInformationStatus,
                controller: controller.statusController,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Image.asset(PngAssets.arrowDownInputIcon, width: 10.w),
                ),
                readOnly: true,
              ),
              SizedBox(height: 16),
              CommonSingleDatePicker(
                isRequired: true,
                labelText: localization.createInvoiceInformationIssueDate,
                fillColor: AppColors.transparent,
                onDateSelected: (DateTime value) {
                  final dateFormate = DateFormat("yyyy-MM-dd").format(value);
                  controller.issueDate.value = "";
                  controller.issueDate.value = dateFormate;
                },
                initialDate: DateTime.now(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
