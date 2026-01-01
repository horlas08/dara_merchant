import 'package:flutter/material.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';

class CommonAlertBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final Color? alertBoxColor;
  final String alertBoxIcon;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool? isPop;

  const CommonAlertBottomSheet({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
    this.alertBoxIcon = PngAssets.commonAlertIcon,
    this.alertBoxColor,
    this.isPop,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isPop ?? true,
      child: AnimatedContainer(
        width: double.infinity,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        margin: EdgeInsets.symmetric(horizontal: 18),
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
            mainAxisSize: MainAxisSize.min,
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
              _buildAlertIcon(context),
              const SizedBox(height: 16),
              _buildTextSection(context),
              const SizedBox(height: 40),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertIcon(BuildContext context) {
    return Image.asset(PngAssets.commonExitAppIcon, width: 75, height: 75);
  }

  Widget _buildTextSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: AppColors.lightTextPrimary,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            textAlign: TextAlign.center,
            message,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.lightTextTertiary,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: CommonButton(
            backgroundColor: AppColors.error,
            width: double.infinity,
            text: "Confirm",
            onPressed: () => onConfirm(),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
