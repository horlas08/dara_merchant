import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';

class NotificationDynamicIcon {
  static String getNotificationIcon(String? type) {
    switch (type) {
      case "merchant_payment":
        return PngAssets.merchantPaymentNotificationIcon;
      case "merchant_ticket_reply":
        return PngAssets.merchantTicketReplyNotificationIcon;
      case "merchant_withdraw_approved":
        return PngAssets.merchantWithdrawApprovedNotificationIcon;
      case "merchant_withdraw_rejected":
        return PngAssets.merchantWithdrawRejectedNotificationIcon;
      default:
        return PngAssets.merchantPaymentNotificationIcon;
    }
  }
}
