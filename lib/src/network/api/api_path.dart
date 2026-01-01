class ApiPath {
  // Base Endpoints

  static const String baseUrl = 'https://darapay.io/api';

  // Common Endpoints
  static const String getSettingsEndpoint = '/get-settings';
  static const String countriesEndpoint = '/get-countries';
  static const String getUserProfileEndpoint = '/auth/merchant/profile';
  static const String termsAndConditionsEndpoint = '/terms-conditions';
  static const String getSetupFcm = '/setup-fcm';

  static String getConverterEndpoint({
    required String amount,
    required String currencyCode,
    bool? isThousandSeparatorRemove = true,
  }) => '/convert/$amount/$currencyCode/$isThousandSeparatorRemove';

  static String getCurrencyToCurrencyConverterEndpoint({
    required String amount,
    required String toCurrencyCode,
    bool? isThousandSeparatorRemove = true,
    required String? fromCurrencyCode,
  }) =>
      '/convert/$amount/$toCurrencyCode/$isThousandSeparatorRemove/$fromCurrencyCode';

  // Authentication Endpoints
  static const String loginEndpoint = '/auth/merchant/login';
  static const String registerEndpoint = '/auth/merchant/register';
  static const String forgotPasswordEndpoint = '/auth/merchant/forgot-password';
  static const String resetVerifyOtpEndpoint =
      '/auth/merchant/reset-verify-otp';
  static const String resetPasswordEndpoint = '/auth/merchant/reset-password';
  static const String twoFaEndpoint = '/auth/merchant/2fa/verify';
  static const String logoutEndpoint = '/auth/merchant/logout';
  static const String verifyEmailEndpoint = '/auth/merchant/send-verify-email';
  static const String validateVerifyEmailEndpoint =
      '/auth/merchant/validate-verify-email';
  static const String personalInfoEndpoint =
      '/auth/merchant/personal-info-update';
  static const String getRegisterFieldsEndpoint =
      '/get-register-fields/merchant';
  static const String kycRejectedEndpoint = '/merchant/kyc/rejected-data';

  // Wallets Endpoints
  static const String walletsEndpoint = '/merchant/wallets';
  static const String currenciesEndpoint = '/get-currencies';

  // Transactions Endpoints
  static const String transactionsEndpoint = '/merchant/transactions';

  // Notifications Endpoints
  static const String markAsReadNotificationEndpoint =
      '/mark-as-read-notification';
  static const String getNotificationsEndpoint = '/get-notifications';

  // QR Code Endpoints
  static const String qrCodeEndpoint = '/merchant/qrcode';

  // Api Access Key Endpoints
  static const String apiAccessKeyEndpoint = '/merchant/access-keys';
  static const String generateAccessKeyEndpoint =
      '/merchant/access-keys/regenerate';

  // Change Password Endpoints
  static const String changePasswordEndpoint =
      '/merchant/settings/change-password';

  // Profile Settings Endpoints
  static const String updateProfileEndpoint = '/merchant/settings/profile';

  // Support Ticket Endpoints
  static const String supportTicketsEndpoint = '/merchant/ticket';

  // Withdraw Endpoints
  static const String withdrawAccountEndpoint = '/merchant/withdraw-accounts';
  static const String withdrawEndpoint = '/merchant/withdraw';
  static const String withdrawMethodsEndpoint =
      '/merchant/withdraw-accounts/methods/list';
  static const String withdrawAccountCreateEndpoint =
      '/merchant/withdraw-accounts';

  // Id Verification Endpoints
  static const String userKycEndpoint = '/merchant/kyc';
  static const String kycHistoryEndpoint = '/merchant/kyc/history';

  // Two Fa Authentication Endpoints
  static const String twoFaGenerateQRCodeEndpoint =
      '/merchant/settings/2fa/generate';
  static const String enableTwoFaEndpoint = '/merchant/settings/2fa/enable';
  static const String disableTwoFaEndpoint = '/merchant/settings/2fa/disable';

  // Exchange Endpoints
  static const String exchangeConfigEndpoint = '/merchant/exchange/config';
  static const String exchangeWalletEndpoint = '/merchant/exchange';
  static const String exchangeHistoryEndpoint = '/merchant/exchange/history';

  // Invoice Endpoints
  static const String invoiceEndpoint = '/merchant/invoices';
}
