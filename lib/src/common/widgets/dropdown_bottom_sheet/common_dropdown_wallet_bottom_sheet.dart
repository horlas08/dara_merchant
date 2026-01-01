import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';

class CommonDropdownWalletBottomSheet extends StatefulWidget {
  final double bottomSheetHeight;
  final List<dynamic> dropdownItems;
  final String? currentlySelectedValue;
  final Function(String) onItemSelected;
  final String notFoundText;
  final String dropdownTitle;

  const CommonDropdownWalletBottomSheet({
    super.key,
    required this.dropdownItems,
    required this.bottomSheetHeight,
    this.currentlySelectedValue,
    required this.onItemSelected,
    required this.notFoundText,
    required this.dropdownTitle,
  });

  @override
  State<CommonDropdownWalletBottomSheet> createState() =>
      _CommonDropdownWalletBottomSheetState();
}

class _CommonDropdownWalletBottomSheetState
    extends State<CommonDropdownWalletBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      height: widget.bottomSheetHeight,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
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
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: AppColors.lightTextPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
          SizedBox(height: 16.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.dropdownTitle,
                  style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp,
                    color: AppColors.lightTextPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    PngAssets.closeCommonIcon,
                    width: 28.w,
                    color: AppColors.lightTextPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.white,
                  AppColors.lightTextPrimary.withValues(alpha: 0.1),
                  AppColors.white,
                ],
              ),
            ),
          ),
          widget.dropdownItems.isEmpty
              ? _buildEmptyState(notFoundText: widget.notFoundText)
              : _buildItemsList(),
        ],
      ),
    );
  }

  Widget _buildEmptyState({required String notFoundText}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.search_off_rounded,
          size: 38.w,
          color: AppColors.lightTextTertiary,
        ),
        SizedBox(height: 5),
        Text(
          notFoundText,
          style: TextStyle(
            letterSpacing: 0,
            fontSize: 14.sp,
            color: AppColors.lightTextPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildItemsList() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: 16.h);
        },
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 18.h,
          top: 20.h,
        ),
        itemCount: widget.dropdownItems.length,
        itemBuilder: (context, index) {
          final item = widget.dropdownItems[index];
          final isSelected = widget.currentlySelectedValue == item.name;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.lightPrimary.withValues(alpha: 0.06)
                  : AppColors.lightBackground,
              borderRadius: BorderRadius.circular(16.r),
              border: isSelected
                  ? Border.all(
                      color: AppColors.lightPrimary.withValues(alpha: 0.30),
                      width: 1.5.w,
                    )
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                splashColor: AppColors.lightPrimary.withValues(alpha: 0.06),
                highlightColor: Colors.transparent,
                onTap: () {
                  widget.onItemSelected(item.name!);
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            item.isDefault == true
                                ? Container(
                                    width: 32.w,
                                    height: 32.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.symbol!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          color: AppColors.lightPrimary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50.r),
                                    child: Container(
                                      width: 32.w,
                                      height: 32.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          50.r,
                                        ),
                                      ),
                                      child: Image.network(
                                        item.icon!,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Image.asset(
                                                PngAssets.commonErrorIcon,
                                                color: AppColors.error
                                                    .withValues(alpha: 0.7),
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name!,
                                  style: TextStyle(
                                    letterSpacing: 0,
                                    fontSize: 15.sp,
                                    color: isSelected
                                        ? AppColors.lightPrimary
                                        : AppColors.lightTextPrimary,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "${item.formattedBalance!} ${item.code}",
                                  style: TextStyle(
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.sp,
                                    color: AppColors.lightTextTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Image.asset(
                          PngAssets.commonDropdownTickIcon,
                          width: 20.w,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
