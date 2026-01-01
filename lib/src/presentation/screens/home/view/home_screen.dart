import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/common/widgets/common_alert_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_header_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_skeleton_loader.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_transactions_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/view/sub_sections/home_wallets_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        Get.bottomSheet(
          CommonAlertBottomSheet(
            title: AppLocalizations.of(Get.context!)!.exitAppTitle,
            message: AppLocalizations.of(Get.context!)!.exitAppMessage,
            onConfirm: () => exit(0),
            onCancel: () => Get.back(),
          ),
        );
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: Stack(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return HomeSkeletonLoader();
                }

                return RefreshIndicator(
                  color: AppColors.lightPrimary,
                  onRefresh: () => controller.loadData(),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        HomeHeaderSection(),
                        SizedBox(height: 30.h),
                        HomeWalletsSection(),
                        SizedBox(height: 30.h),
                        HomeTransactionsSection(),
                      ],
                    ),
                  ),
                );
              }),
              Obx(
                () => Visibility(
                  visible: controller.isSignOutLoading.value,
                  child: CommonLoading(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
