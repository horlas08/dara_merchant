import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_icon_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/controller/create_invoice_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/view/create_invoice/sub_sections/create_invoice_add_item_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/view/create_invoice/sub_sections/create_invoice_information_section.dart';

class CreateInvoice extends StatefulWidget {
  const CreateInvoice({super.key});

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {
  final CreateInvoiceController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.statusController.text = "Draft";
    controller.status.value = "Draft";
    controller.issueDate.value = "";
    controller.issueDate.value = DateFormat(
      "yyyy-MM-dd",
    ).format(DateTime.now());
    loadData();
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchWallets();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              CommonAppBar(title: localization!.createInvoiceScreenTitle),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? CommonLoading()
                      : ListView(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          children: [
                            SizedBox(height: 30.h),
                            const CreateInvoiceInformationSection(),
                            SizedBox(height: 30.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  localization.createInvoiceScreenInvoiceItems,
                                  style: TextStyle(
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                    color: AppColors.lightTextPrimary,
                                  ),
                                ),
                                CommonIconButton(
                                  backgroundColor: AppColors.transparent,
                                  textColor: AppColors.lightPrimary,
                                  iconColor: AppColors.lightPrimary,
                                  width: 100,
                                  height: 35,
                                  text: localization.createInvoiceScreenAddItem,
                                  icon: PngAssets.addCommonIcon,
                                  iconWidth: 20,
                                  iconHeight: 20,
                                  iconAndTextSpace: 4,
                                  onPressed: () => controller.addItem(),
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            ...controller.items.asMap().entries.map((entry) {
                              final index = entry.key;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: CreateInvoiceAddItemSection(
                                  index: index,
                                  onRemove: () => controller.removeItem(index),
                                ),
                              );
                            }),
                            SizedBox(height: 40.h),
                            CommonButton(
                              width: double.infinity,

                              text: localization
                                  .createInvoiceScreenCreateInvoiceButton,
                              onPressed: () async {
                                if (!controller.validateFields()) {
                                  return;
                                }
                                await controller.createInvoice();
                              },
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isCreateInvoiceLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
