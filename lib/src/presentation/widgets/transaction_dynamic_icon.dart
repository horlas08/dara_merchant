import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';

class TransactionDynamicIcon {
  static String getTransactionIcon(String? type) {
    switch (type) {
      case "Payment":
        return PngAssets.paymentTransactionIcon;
      case "Credit":
        return PngAssets.creditTransactionIcon;
      case "Debit":
        return PngAssets.debitTransactionIcon;
      case "Withdraw":
        return PngAssets.withdrawTransactionIcon;
      case "Withdraw Auto":
        return PngAssets.withdrawAutoTransactionIcon;
      case "Refund":
        return PngAssets.refundTransactionIcon;
      default:
        return PngAssets.paymentTransactionIcon;
    }
  }
}
