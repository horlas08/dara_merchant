import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/common/model/user_profile_model.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/network/api/api_path.dart';
import 'package:qunzo_merchant/src/network/response/status.dart';
import 'package:qunzo_merchant/src/network/service/network_service.dart';

class IdVerificationController extends GetxController {
  // Global
  final RxBool isLoading = false.obs;
  final Rx<UserProfileModel> userModel = UserProfileModel().obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    await fetchUser();
    isLoading.value = false;
  }

  // Fetch User
  Future<void> fetchUser() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.getUserProfileEndpoint,
      );
      if (response.status == Status.completed) {
        userModel.value = UserProfileModel.fromJson(response.data!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchUser() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerGeneralError,
      );
    } finally {}
  }
}
