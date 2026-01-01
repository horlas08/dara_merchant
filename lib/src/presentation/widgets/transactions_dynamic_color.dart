import 'dart:ui';

class TransactionDynamicColor {
  static Color getTransactionColor(String? type) {
    switch (type) {
      case "Payment":
        return Color(0xFFD5E3FF);
      case "Credit":
        return Color(0xFFFFD5F8);
      case "Debit":
        return Color(0xFFE0D5FF);
      case "Withdraw":
        return Color(0xFFE0D5FF);
      case "Withdraw Auto":
        return Color(0xFFFFD5F8);
      case "Refund":
        return Color(0xFFFFDED5);
      default:
        return Color(0xFFD5E3FF);
    }
  }
}
