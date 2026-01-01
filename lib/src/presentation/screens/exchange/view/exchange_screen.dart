import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/presentation/screens/exchange/controller/exchange_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/exchange/view/sub_sections/exchange_amount_step_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/exchange/view/sub_sections/exchange_review_step_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/exchange/view/sub_sections/exchange_success_step_section.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeController controller = Get.find();
    final localization = AppLocalizations.of(Get.context!)!;

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
                  controller.currentStep.value == 2
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            CommonAppBar(
                              title: localization.exchangeScreenTitle,
                              isBackLogicApply: true,
                              backLogicFunction: () {
                                if (controller.currentStep.value == 0) {
                                  Get.back();
                                } else if (controller.currentStep.value == 1) {
                                  controller.currentStep.value = 0;
                                }
                              },
                            ),
                          ],
                        ),
                  controller.currentStep.value == 0
                      ? ExchangeAmountStepSection()
                      : controller.currentStep.value == 1
                      ? ExchangeReviewStepSection()
                      : controller.currentStep.value == 2
                      ? ExchangeSuccessStepSection()
                      : SizedBox.shrink(),
                ],
              ),
              Obx(
                () => Visibility(
                  visible: controller.isExchangeWalletLoading.value,
                  child: const CommonLoading(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
