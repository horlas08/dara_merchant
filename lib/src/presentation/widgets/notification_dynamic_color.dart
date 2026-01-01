import 'dart:ui';

class NotificationDynamicColor {
  static Color getNotificationColor(String? type) {
    switch (type) {
      case "merchant_payment":
        return Color(0xFF7445FF).withValues(alpha: 0.10);
      case "merchant_ticket_reply":
        return Color(0xFFE2F5FF);
      case "merchant_withdraw_approved":
        return Color(0xFFFFDBFC);
      case "merchant_withdraw_rejected":
        return Color(0xFFFFE4E4);
      default:
        return Color(0xFFE2F5FF);
    }
  }
}
