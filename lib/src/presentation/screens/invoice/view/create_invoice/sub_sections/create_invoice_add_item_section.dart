import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/controller/create_invoice_controller.dart';

class CreateInvoiceAddItemSection extends StatelessWidget {
  final int index;
  final VoidCallback onRemove;

  const CreateInvoiceAddItemSection({
    super.key,
    required this.index,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final CreateInvoiceController controller = Get.find();
    final localization = AppLocalizations.of(context);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              CommonTextField(
                isRequired: true,
                backgroundColor: AppColors.transparent,
                labelText: localization!.createInvoiceAddItemItemName,
                controller: controller.items[index].itemNameController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.h),
              CommonTextField(
                isRequired: true,
                backgroundColor: AppColors.transparent,
                labelText: localization.createInvoiceAddItemQuantity,
                controller: controller.items[index].quantityController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CommonTextField(
                isRequired: true,
                backgroundColor: AppColors.transparent,
                labelText: localization.createInvoiceAddItemUnitPrice,
                controller: controller.items[index].unitPriceController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CommonTextField(
                isRequired: true,
                backgroundColor: AppColors.transparent,
                labelText: localization.createInvoiceAddItemSubTotal,
                controller: controller.items[index].subTotalController,
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
        Positioned(
          top: 18.h,
          right: 18.w,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.all(8.r),
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Image.asset(PngAssets.invoiceDeleteIcon),
            ),
          ),
        ),
      ],
    );
  }
}
