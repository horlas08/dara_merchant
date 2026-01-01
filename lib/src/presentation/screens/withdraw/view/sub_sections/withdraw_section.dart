import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/controller/withdraw_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/view/sub_sections/withdraw_amount_step_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/view/sub_sections/withdraw_review_step_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/view/sub_sections/withdraw_success_step_section.dart';

class WithdrawSection extends StatefulWidget {
  const WithdrawSection({super.key});

  @override
  State<WithdrawSection> createState() => _WithdrawSectionState();
}

class _WithdrawSectionState extends State<WithdrawSection> {
  final WithdrawController controller = Get.find();
  final int walletId = Get.arguments?['wallet_id'] ?? 0;
  final bool isWalletFind = Get.arguments?['is_wallet_find'] ?? false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchWallets(id: walletId, isFindWallet: isWalletFind);
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => controller.currentStep.value == 0
            ? WithdrawAmountStepSection()
            : controller.currentStep.value == 1
            ? WithdrawReviewStepSection()
            : controller.currentStep.value == 2
            ? WithdrawSuccessStepSection(walletId: walletId)
            : SizedBox.shrink(),
      ),
    );
  }
}
