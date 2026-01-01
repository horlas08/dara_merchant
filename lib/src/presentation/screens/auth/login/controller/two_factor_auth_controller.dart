import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/network/api/api_path.dart';
import 'package:qunzo_merchant/src/network/response/status.dart';
import 'package:qunzo_merchant/src/network/service/network_service.dart';

class TwoFactorAuthController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;

  // Pin Code
  final pinCodeController = TextEditingController();

  // Two Factor Auth Verification Function
  Future<void> submitTwoFaVerification() async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> requestBody = {"code": pinCodeController.text};
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.twoFaEndpoint,
        data: requestBody,
      );
      if (response.status == Status.completed) {
        Get.offAllNamed(BaseRoute.navigation);
        pinCodeController.clear();
        ToastHelper().showSuccessToast(response.data!["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitTwoFaVerification() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerGeneralError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
