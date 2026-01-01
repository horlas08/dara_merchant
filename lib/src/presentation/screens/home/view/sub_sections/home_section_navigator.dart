import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';

class HomeSectionNavigator extends StatelessWidget {
  final String sectionName;
  final GestureTapCallback onTap;

  const HomeSectionNavigator({
    super.key,
    required this.sectionName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionName,
          style: TextStyle(
            letterSpacing: 0,
            fontSize: 18.sp,
            color: AppColors.lightTextPrimary,
            fontWeight: FontWeight.w900,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            AppLocalizations.of(Get.context!)!.homeViewAll,
            style: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w900,
              fontSize: 13.sp,
              color: AppColors.lightTextPrimary.withValues(alpha: 0.60),
            ),
          ),
        ),
      ],
    );
  }
}
