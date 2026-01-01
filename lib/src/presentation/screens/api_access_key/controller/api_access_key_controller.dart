import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/network/api/api_path.dart';
import 'package:qunzo_merchant/src/network/response/status.dart';
import 'package:qunzo_merchant/src/network/service/network_service.dart';
import 'package:qunzo_merchant/src/presentation/screens/api_access_key/model/api_access_key_model.dart';

class ApiAccessKeyController extends GetxController {
  // Global variables
  final RxBool isLoading = false.obs;
  final Rx<ApiAccessKeyModel> apiAccessModel = ApiAccessKeyModel().obs;
  final publicKeyController = TextEditingController();
  final secretKeyController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchApiAccessKey();
  }

  // Fetch Api Access Key
  Future<void> fetchApiAccessKey() async {
    isLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.apiAccessKeyEndpoint,
      );
      if (response.status == Status.completed) {
        apiAccessModel.value = ApiAccessKeyModel.fromJson(response.data!);
        publicKeyController.text = apiAccessModel.value.data?.publicKey ?? '';
        secretKeyController.text = apiAccessModel.value.data?.secretKey ?? '';
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchApiAccessKey() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerGeneralError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Generate Api Access Key
  Future<void> generateApiAccessKey() async {
    isLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.generateAccessKeyEndpoint,
      );
      if (response.status == Status.completed) {
        apiAccessModel.value = ApiAccessKeyModel.fromJson(response.data!);
        publicKeyController.text = apiAccessModel.value.data?.publicKey ?? '';
        secretKeyController.text = apiAccessModel.value.data?.secretKey ?? '';
      }
    } catch (e, stackTrace) {
      debugPrint('❌ generateApiAccessKey() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerGeneralError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
