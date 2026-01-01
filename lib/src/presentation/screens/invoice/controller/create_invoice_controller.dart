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

class CreateInvoiceController extends GetxController {
  // Global
  final RxBool isLoading = false.obs;
  final RxBool isCreateInvoiceLoading = false.obs;
  final localization = AppLocalizations.of(Get.context!)!;

  // Invoice
  final invoiceToController = TextEditingController();

  // Email Address
  final emailAddressToController = TextEditingController();

  // Address
  final addressController = TextEditingController();

  // Wallet
  final walletController = TextEditingController();
  final Rxn<Wallets> wallet = Rxn<Wallets>();
  final RxList<Wallets> walletsList = <Wallets>[].obs;

  // Status
  final RxString status = "Draft".obs;
  final statusController = TextEditingController();

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
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.walletsEndpoint,
      );

      if (response.status == Status.completed) {
        final walletsModel = WalletsModel.fromJson(response.data!);
        walletsList.clear();
        walletsList.value = walletsModel.data!.wallets ?? [];
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchWallets() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerGeneralError);
    } finally {}
  }

  Future<void> createInvoice() async {
    isCreateInvoiceLoading.value = true;
    try {
      final List<Map<String, dynamic>> itemList = items.map((item) {
        return {
          "name": item.itemNameController.text,
          "quantity": int.tryParse(item.quantityController.text) ?? 0,
          "unit_price": int.tryParse(item.unitPriceController.text) ?? 0,
        };
      }).toList();

      final Map<String, dynamic> requestBody = {
        "to": invoiceToController.text,
        "email": emailAddressToController.text,
        "address": addressController.text,
        "currency": wallet.value?.code ?? "",
        "issue_date": issueDate.value,
        "is_published": statusController.text == "Draft" ? 0 : 1,
        "items": itemList,
      };

      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.invoiceEndpoint,
        data: requestBody,
      );

      if (response.status == Status.completed) {
        clearInvoiceForm();
        Get.back();
        await Get.find<InvoiceController>().loadData();
        ToastHelper().showSuccessToast(response.data!["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ createInvoice() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerGeneralError);
    } finally {
      isCreateInvoiceLoading.value = false;
    }
  }

  // Validate Fields
  bool validateFields() {
    if (invoiceToController.text.isEmpty) {
      ToastHelper().showErrorToast(localization.createInvoiceInvoiceToRequired);
      return false;
    }

    if (emailAddressToController.text.isEmpty) {
      ToastHelper().showErrorToast(localization.createInvoiceEmailRequired);
      return false;
    }

    if (addressController.text.isEmpty) {
      ToastHelper().showErrorToast(localization.createInvoiceAddressRequired);
      return false;
    }

    if (walletController.text.isEmpty) {
      ToastHelper().showErrorToast(localization.createInvoiceWalletRequired);
      return false;
    }

    if (statusController.text.isEmpty) {
      ToastHelper().showErrorToast(localization.createInvoiceStatusRequired);
      return false;
    }

    if (issueDate.value.isEmpty) {
      ToastHelper().showErrorToast(localization.createInvoiceIssueDateRequired);
      return false;
    }

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final name = item.itemNameController.text.trim();
      final quantity = int.tryParse(item.quantityController.text) ?? 0;
      final price = double.tryParse(item.unitPriceController.text) ?? 0.0;

      if (name.isEmpty) {
        ToastHelper().showErrorToast(
          localization.createInvoiceItemNameRequired(i + 1),
        );
        return false;
      }

      if (quantity <= 0) {
        ToastHelper().showErrorToast(
          localization.createInvoiceItemQuantityRequired(i + 1),
        );
        return false;
      }

      if (price <= 0) {
        ToastHelper().showErrorToast(
          localization.createInvoiceItemUnitPriceRequired(i + 1),
        );
        return false;
      }
    }

    return true;
  }

  void clearInvoiceForm() {
    // Clear text fields
    invoiceToController.clear();
    emailAddressToController.clear();
    addressController.clear();
    walletController.clear();
    statusController.clear();

    // Reset status and issue date
    statusController.text = "Draft";
    issueDate.value = DateFormat("yyyy-MM-dd").format(DateTime.now());

    // Reset wallet
    walletController.clear();

    items.clear();
    items.add(InvoiceItem());
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

  void _calculateSubTotal() {
    final qty = int.tryParse(quantityController.text) ?? 0;
    final price = int.tryParse(unitPriceController.text) ?? 0;
    final subtotal = qty * price;
    subTotalController.text = subtotal.toString();
  }

  void dispose() {
    itemNameController.dispose();
    quantityController.dispose();
    unitPriceController.dispose();
    subTotalController.dispose();
  }
}
