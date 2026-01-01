import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/network/api/api_path.dart';
import 'package:qunzo_merchant/src/network/response/status.dart';
import 'package:qunzo_merchant/src/network/service/network_service.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/model/invoice_details_model.dart';

class InvoiceDetailsController extends GetxController {
  // Global
  final RxBool isLoading = false.obs;
  final Rx<InvoiceDetailsModel> invoiceDetailsModel = InvoiceDetailsModel().obs;

  // Fetch Invoice Details
  Future<void> fetchInvoiceDetails({required String invoiceId}) async {
    isLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: "${ApiPath.invoiceEndpoint}/$invoiceId",
      );
      if (response.status == Status.completed) {
        invoiceDetailsModel.value = InvoiceDetailsModel.fromJson(
          response.data!,
        );
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchInvoiceDetails() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerGeneralError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
