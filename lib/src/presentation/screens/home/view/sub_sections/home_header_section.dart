import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileController userProfileController = Get.find();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 22.h),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(PngAssets.homeHeaderFrame),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 60.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userProfileController.userProfileModel.value.data!.user!.greetings},",
                      style: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      userProfileController
                              .userProfileModel
                              .value
                              .data!
                              .user!
                              .username ??
                          "",
                      style: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w900,
                        fontSize: 22.sp,
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.find<HomeController>().openDrawer(),
                    child: Container(
                      width: 42.w,
                      height: 42.w,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.13),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.10),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Image.asset(PngAssets.commonMenuIcon),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 42.w,
                    height: 42.w,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.13),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.10),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(BaseRoute.notification),
                      child: Badge(
                        backgroundColor: AppColors.error,
                        smallSize:
                            userProfileController
                                    .userProfileModel
                                    .value
                                    .data!
                                    .user!
                                    .unreadNotificationsCount !=
                                0
                            ? 8
                            : 0,
                        child: Image.asset(PngAssets.commonNotificationIcon),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: () {
              Clipboard.setData(
                ClipboardData(
                  text: userProfileController
                      .userProfileModel
                      .value
                      .data!
                      .user!
                      .accountNumber!,
                ),
              );
              ToastHelper().showSuccessToast(
                AppLocalizations.of(
                  Get.context!,
                )!.homeHeaderAccountNumberCopied,
              );
            },
            child: Row(
              children: [
                Text(
                  "${AppLocalizations.of(Get.context!)!.homeHeaderMerchantIdPrefix} ${userProfileController.userProfileModel.value.data!.user!.accountNumber ?? ""}",
                  style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                Image.asset(PngAssets.commonAccountCopyIcon, width: 16.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
