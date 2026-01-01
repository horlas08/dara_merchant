import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/controller/withdraw_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/view/sub_sections/withdraw_account_filter_bottom_sheet.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/view/sub_sections/withdraw_account_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/view/sub_sections/withdraw_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/view/sub_sections/withdraw_toggle_section.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final WithdrawController controller = Get.put(WithdrawController());

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Obx(
      () => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: controller.currentStep.value == 2
              ? Brightness.light
              : Brightness.dark,
        ),
        child: Scaffold(
          appBar: controller.currentStep.value == 2
              ? null
              : CommonDefaultAppBar(),
          body: Stack(
            children: [
              Column(
                children: [
                  Obx(
                    () => controller.currentStep.value == 2
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              CommonAppBar(
                                title: localization!.withdrawScreenTitle,
                                showRightSideWidget:
                                    controller.selectedScreen.value == 1
                                    ? true
                                    : false,
                                rightSideWidget: GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      WithdrawAccountFilterBottomSheet(),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: AppColors.black.withValues(
                                        alpha: 0.12,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Image.asset(
                                      PngAssets.commonFilterIcon,
                                    ),
                                  ),
                                ),
                                isBackLogicApply: true,
                                backLogicFunction: () {
                                  if (controller.currentStep.value == 0) {
                                    Get.back();
                                  } else if (controller.currentStep.value ==
                                      1) {
                                    controller.currentStep.value = 0;
                                  }
                                },
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.currentStep.value == 0,
                      child: WithdrawToggleSection(),
                    ),
                  ),
                  Obx(
                    () => controller.selectedScreen.value == 0
                        ? WithdrawSection()
                        : controller.selectedScreen.value == 1
                        ? WithdrawAccountSection()
                        : SizedBox.shrink(),
                  ),
                ],
              ),
              Obx(
                () => Visibility(
                  visible:
                      controller.isWithdrawLoading.value ||
                      controller.isWithdrawAccountLoading.value,
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
