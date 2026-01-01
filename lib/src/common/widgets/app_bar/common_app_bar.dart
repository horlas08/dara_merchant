import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';

class CommonAppBar extends StatelessWidget {
  final String? title;
  final double? horizontalPadding;
  final GestureTapCallback? backLogicFunction;
  final bool? isBackLogicApply;
  final bool? showRightSideWidget;
  final Widget? rightSideWidget;
  final int? selectedIndex;

  const CommonAppBar({
    super.key,
    this.title,
    this.horizontalPadding,
    this.backLogicFunction,
    this.isBackLogicApply = false,
    this.showRightSideWidget = false,
    this.rightSideWidget,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2C874F),
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding?.r ?? 18.r),
      child: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (selectedIndex != null && isBackLogicApply == true) {
                    Get.find<HomeController>().selectedIndex.value = 0;
                    backLogicFunction?.call();
                  } else if (selectedIndex != null) {
                    Get.find<HomeController>().selectedIndex.value = 0;
                    Get.back();
                  } else if (isBackLogicApply == true) {
                    backLogicFunction?.call();
                  } else {
                    Get.back();
                  }
                },
                child: Image.asset(
                  PngAssets.arrowLeftCommonIcon,
                  width: 24.w,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title ?? "",
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          Spacer(),
          if (showRightSideWidget == true && rightSideWidget != null)
            rightSideWidget!,
        ],
      ),
    );
  }
}
