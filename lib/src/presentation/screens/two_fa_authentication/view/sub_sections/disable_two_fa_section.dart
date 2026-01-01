import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/two_fa_authentication/controller/two_fa_authentication_controller.dart';

class DisableTwoFaSection extends StatelessWidget {
  const DisableTwoFaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TwoFaAuthenticationController controller = Get.find();
    final localization = AppLocalizations.of(context);

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localization!.disableTwoFaTitle,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: 0,
                color: AppColors.lightTextPrimary,
              ),
            ),
            Divider(color: AppColors.lightTextTertiary.withValues(alpha: 0.15)),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  localization.disableTwoFaInstruction,
                  style: TextStyle(
                    letterSpacing: 0,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightTextTertiary,
                  ),
                ),
                Text(
                  "*",
                  style: TextStyle(
                    letterSpacing: 0,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            CommonTextField(
              hintText: "",
              controller: controller.disable2FaController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            CommonButton(
              width: double.infinity,
              text: localization.disableTwoFaButton,
              onPressed: () async {
                if (controller.disable2FaController.text.isEmpty) {
                  ToastHelper().showErrorToast(
                    localization.disableTwoFaPasswordRequired,
                  );
                } else {
                  await controller.submitDisableTwoFa();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
