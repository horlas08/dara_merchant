import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/qr_code/controller/qr_code_controller.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final QrCodeController controller = Get.put(QrCodeController());
  final UserProfileController userProfileController =
      Get.find<UserProfileController>();
  final GlobalKey qrKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Load Data
  Future<void> loadData() async {
    controller.isLoading.value = true;
    await userProfileController.fetchUserProfile();
    await controller.fetchQrCode();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Column(
        children: [
          CommonAppBar(title: localization!.qrCodeTitle),
          const SizedBox(height: 60),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const CommonLoading()
                  : Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          topLeft: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 50),
                          RepaintBoundary(
                            key: qrKey,
                            child: SvgPicture.string(
                              controller.qrCodeModel.value.data ?? '',
                              width: 210,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            localization.qrCodeMerchantId(
                              userProfileController
                                  .userProfileModel
                                  .value
                                  .data!
                                  .user!
                                  .accountNumber!,
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.60,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          CommonButton(
                            onPressed: () => downloadQr(
                              qrKey,
                              "qr_code_${DateTime.now().millisecondsSinceEpoch}",
                            ),
                            width: double.infinity,
                            text: localization.qrCodeDownloadButton,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadQr(GlobalKey key, String fileName) async {
    final localization = AppLocalizations.of(context);
    try {
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          ToastHelper().showErrorToast(localization!.qrCodePermissionRequired);
          return;
        }
      }

      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final String path = "/storage/emulated/0/Download/$fileName.png";
      final File file = File(path);

      await file.writeAsBytes(pngBytes);
      ToastHelper().showSuccessToast(localization!.qrCodeDownloadSuccess);
    } finally {}
  }
}
