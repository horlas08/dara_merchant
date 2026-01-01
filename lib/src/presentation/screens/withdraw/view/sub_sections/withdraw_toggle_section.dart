import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/controller/withdraw_controller.dart';

class WithdrawToggleSection extends StatelessWidget {
  const WithdrawToggleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawController controller = Get.find();
    final localization = AppLocalizations.of(context);

    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Expanded(
              child: CommonButton(
                text: localization!.withdrawToggleWithdraw,
                backgroundColor: controller.selectedScreen.value == 0
                    ? AppColors.white
                    : AppColors.transparent,
                textColor: controller.selectedScreen.value == 0
                    ? AppColors.lightTextPrimary
                    : AppColors.lightTextPrimary.withValues(alpha: 0.80),
                onPressed: () {
                  controller.clearFields();
                  controller.selectedScreen.value = 0;
                },
                boxShadow: controller.selectedScreen.value == 0
                    ? [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.3),
                          spreadRadius: 0,
                          blurRadius: 40,
                          offset: const Offset(0, 0),
                        ),
                      ]
                    : [],
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: CommonButton(
                text: localization.withdrawToggleWithdrawAccount,
                backgroundColor: controller.selectedScreen.value == 1
                    ? AppColors.white
                    : AppColors.transparent,
                textColor: controller.selectedScreen.value == 1
                    ? AppColors.lightTextPrimary
                    : AppColors.lightTextPrimary.withValues(alpha: 0.80),
                onPressed: () {
                  controller.selectedScreen.value = 1;
                },
                boxShadow: controller.selectedScreen.value == 1
                    ? [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.3),
                          spreadRadius: 0,
                          blurRadius: 40,
                          offset: const Offset(0, 0),
                        ),
                      ]
                    : [],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
