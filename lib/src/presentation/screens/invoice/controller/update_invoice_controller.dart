import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/network/api/api_path.dart';
import 'package:qunzo_merchant/src/network/response/status.dart';
import 'package:qunzo_merchant/src/network/service/network_service.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/controller/invoice_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/model/wallets_model.dart';

class UpdateInvoiceController extends GetxController {
  // Global
  final RxBool isLoading = false.obs;
  final RxBool isUpdateInvoiceLoading = false.obs;

  // Invoice
  final invoiceToController = TextEditingController();

  // Email Address
  final emailAddressToController = TextEditingController();

  // Address
  final addressController = TextEditingController();

  // Wallet
  final RxString walletCurrency = "".obs;
  final walletController = TextEditingController();
  final Rxn<Wallets> wallet = Rxn<Wallets>();
  final RxList<Wallets> walletsList = <Wallets>[].obs;

  // Status
  final RxString status = "".obs;
  final statusController = TextEditingController();

  // Payment Status
  final RxString paymentStatus = "".obs;
  final paymentStatusController = TextEditingController();

  // Issue Date
  final RxString issueDate = "".obs;

  // Invoice Items
  final RxList<InvoiceItem> items = <InvoiceItem>[InvoiceItem()].obs;

  @override
  void onClose() {
    super.onClose();
    invoiceToController.dispose();
    emailAddressToController.dispose();
    addressController.dispose();
    walletController.dispose();
    statusController.dispose();
    paymentStatusController.dispose();
  }

  // Add Items
  void addItem() {
    items.add(InvoiceItem());
  }

  // Remove Items
  void removeItem(int index) {
    items[index].dispose();
    items.removeAt(index);
  }

  // Fetch Wallets
  Future<void> fetchWallets() async {
    isLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.walletsEndpoint,
      );

      if (response.status == Status.completed) {
        final walletsModel = WalletsModel.fromJson(response.data!);
        walletsList.clear();
        walletsList.value = walletsModel.data!.wallets ?? [];
        final findWallet = walletsList.firstWhere(
          (item) => item.code == walletCurrency.value,
        );
        wallet.value = findWallet;
        walletController.text = wallet.value?.name ?? "";
        walletCurrency.value = wallet.value?.code ?? "";
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchWallets() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerGeneralError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update Invoice
  Future<void> updateInvoice({required String invoiceId}) async {
    isUpdateInvoiceLoading.value = true;
    try {
      final List<Map<String, dynamic>> itemList = items.map((item) {
        dynamic parseNumber(String value) {
          if (value.isEmpty) return 0;
          double? doubleValue = double.tryParse(value);
          if (doubleValue == null) return 0;
          if (doubleValue == doubleValue.toInt()) {
            return doubleValue.toInt();
          } else {
            return doubleValue;
          }
        }

        return {
          "name": item.itemNameController.text.trim(),
          "quantity": parseNumber(item.quantityController.text),
          "unit_price": parseNumber(item.unitPriceController.text),
        };
      }).toList();

      final Map<String, dynamic> requestBody = {
        "to": invoiceToController.text.trim(),
        "email": emailAddressToController.text.trim(),
        "address": addressController.text.trim(),
        "currency": walletCurrency.value,
        "issue_date": DateFormat(
          "yyyy-MM-dd",
        ).format(DateTime.parse(issueDate.value)),
        "is_published": statusController.text == "Draft" ? 0 : 1,
        "is_paid": paymentStatusController.text == "Unpaid" ? 0 : 1,
        "items": itemList,
        "_method": "put",
      };

      final response = await Get.find<NetworkService>().post(
        endpoint: "${ApiPath.invoiceEndpoint}/$invoiceId",
        data: requestBody,
      );

      if (response.status == Status.completed) {
        Get.back();
        await Get.find<InvoiceController>().loadData();
        ToastHelper().showSuccessToast(response.data!["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ updateInvoice() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerGeneralError,
      );
    } finally {
      isUpdateInvoiceLoading.value = false;
    }
  }
}

// Invoice Items Controller
class InvoiceItem {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController unitPriceController = TextEditingController();
  final TextEditingController subTotalController = TextEditingController();

  InvoiceItem() {
    quantityController.addListener(_calculateSubTotal);
    unitPriceController.addListener(_calculateSubTotal);
  }

  InvoiceItem.fromJson(Map<String, dynamic> json) {
    itemNameController.text = json['name']?.toString() ?? '';
    quantityController.text = _formatNumber(json['quantity']);
    unitPriceController.text = _formatNumber(json['unit_price']);
    subTotalController.text = _formatNumber(json['subtotal']);

    quantityController.addListener(_calculateSubTotal);
    unitPriceController.addListener(_calculateSubTotal);
  }

  String _formatNumber(dynamic value) {
    if (value == null) return '0';

    double number = double.tryParse(value.toString()) ?? 0.0;
    if (number == number.toInt()) {
      return number.toInt().toString();
    } else {
      return number.toString();
    }
  }

  void _calculateSubTotal() {
    final qty = double.tryParse(quantityController.text) ?? 0;
    final price = double.tryParse(unitPriceController.text) ?? 0;
    final subtotal = qty * price;
    subTotalController.text = _formatNumber(subtotal);
  }

  void dispose() {
    itemNameController.dispose();
    quantityController.dispose();
    unitPriceController.dispose();
    subTotalController.dispose();
  }
}
