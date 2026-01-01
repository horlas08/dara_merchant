import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/controller/wallets_controller.dart';

class DeleteWalletBottomSheet extends StatelessWidget {
  final String walletId;

  const DeleteWalletBottomSheet({super.key, required this.walletId});

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
            SizedBox(height: 12),
            Container(
              width: 40,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.lightTextPrimary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(height: 40),
            Image.asset(PngAssets.walletDeleteIcon, width: 70),
            SizedBox(height: 16),
            Text(
              localization!.deleteWalletTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: AppColors.lightTextPrimary,
                letterSpacing: 0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                textAlign: TextAlign.center,
                localization.deleteWalletMessage,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.lightTextPrimary.withValues(alpha: 0.30),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: CommonButton(
                backgroundColor: AppColors.error,
                width: double.infinity,
                text: localization.deleteWalletConfirmButton,
                onPressed: () async {
                  Get.back();
                  Get.find<WalletsController>().deleteWallet(
                    walletId: walletId,
                  );
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
