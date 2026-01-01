import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/controller/withdraw_account_controller.dart';

class DeleteAccountDropdownSection extends StatelessWidget {
  final String accountId;

  const DeleteAccountDropdownSection({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return AnimatedContainer(
      width: double.infinity,
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 18),
      curve: Curves.easeOutQuart,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.lightTextPrimary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const SizedBox(height: 40),
            CircleAvatar(
              backgroundColor: AppColors.error.withValues(alpha: 0.10),
              radius: 35,
              child: Image.asset(PngAssets.deleteCommonIcon, width: 35),
            ),
            const SizedBox(height: 16),
            Text(
              localization!.deleteAccountTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF2D2D2D),
                letterSpacing: 0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    localization.deleteAccountWarningPart1,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2D2D2D).withValues(alpha: 0.80),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    localization.deleteAccountWarningPart2,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.error,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  CommonButton(
                    backgroundColor: AppColors.error,
                    width: double.infinity,
                    text: localization.deleteAccountDeleteButton,
                    onPressed: () async {
                      Get.back();
                      await Get.find<WithdrawAccountController>()
                          .deleteWithdrawAccount(accountId);
                    },
                  ),
                  const SizedBox(height: 10),
                  CommonButton(
                    backgroundColor: AppColors.transparent,
                    textColor: AppColors.lightTextPrimary.withValues(
                      alpha: 0.60,
                    ),
                    width: double.infinity,
                    text: localization.deleteAccountCancelButton,
                    onPressed: () async {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
