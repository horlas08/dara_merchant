import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/presentation/screens/transactions/controller/transactions_controller.dart';

class TransactionFilterBottomSheet extends StatefulWidget {
  const TransactionFilterBottomSheet({super.key});

  @override
  State<TransactionFilterBottomSheet> createState() =>
      _TransactionFilterBottomSheetState();
}

class _TransactionFilterBottomSheetState
    extends State<TransactionFilterBottomSheet> {
  final TransactionsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      curve: Curves.easeOutQuart,
      height: 350.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 40,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.lightTextPrimary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              SizedBox(height: 30.h),
              CommonTextField(
                labelText: localization!.transactionFilterTransactionId,
                controller: controller.transactionIdController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  localization.transactionFilterStatus,
                  style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.w900,
                    fontSize: 16.sp,
                    color: AppColors.lightTextPrimary,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Obx(() {
                return Column(
                  children: List.generate(controller.statusList.length, (
                    index,
                  ) {
                    final status = controller.statusList[index];
                    final isSelected =
                        controller.selectedStatusIndex.value == index;

                    return InkWell(
                      onTap: () {
                        if (controller.selectedStatusIndex.value == index) {
                          controller.selectedStatusIndex.value = -1;
                        } else {
                          controller.selectedStatusIndex.value = index;
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          children: [
                            Container(
                              width: 18.w,
                              height: 18.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.success
                                      : AppColors.lightTextPrimary.withValues(
                                          alpha: 0.2,
                                        ),
                                  width: 2.w,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 10.w,
                                        height: 10.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.success,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              status,
                              style: TextStyle(
                                letterSpacing: 0,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? AppColors.lightTextPrimary
                                    : AppColors.lightTextPrimary.withValues(
                                        alpha: 0.6,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
              SizedBox(height: 20.h),
              CommonButton(
                onPressed: () {
                  controller.updateStatusFilter();
                  controller.isFilter.value = true;
                  controller.fetchDynamicTransactions();
                  Get.back();
                },
                width: double.infinity,
                text: localization.transactionFilterApplyButton,
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
