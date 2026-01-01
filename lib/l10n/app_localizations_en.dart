// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get comment_all_controller => '==== All Controller Error Message ====';

  @override
  String get allControllerGeneralError => 'Something went wrong!';

  @override
  String get comment_exit_app_message => '==== Exit App Message ====';

  @override
  String get exitAppTitle => 'Exit Application';

  @override
  String get exitAppMessage => 'Are you sure you want to exit the application?';

  @override
  String get comment_splash_screen => '==== Splash Screen ====';

  @override
  String get splashMerchant => 'Merchant';

  @override
  String get comment_navigation_screen => '==== Navigation Screen ====';

  @override
  String get navigationHome => 'Home';

  @override
  String get navigationWallets => 'Wallets';

  @override
  String get navigationProfile => 'Profile';

  @override
  String get navigationSetting => 'Setting';

  @override
  String get comment_image_picker_controller =>
      '==== Image Picker Controller ====';

  @override
  String get imagePickerGalleryError => 'Failed to pick image from gallery';

  @override
  String get imagePickerCameraError => 'Failed to pick image from camera';

  @override
  String get comment_biometric_auth_service =>
      '==== Biometric Auth Service ====';

  @override
  String get biometricDeviceNotSupported =>
      'This device does not support biometrics.';

  @override
  String get biometricNoEnrolled =>
      'No biometric enrolled. Please set up fingerprint';

  @override
  String get biometricUnavailable =>
      'Biometric features are currently unavailable.';

  @override
  String get biometricAuthenticationFailed =>
      'Biometric authentication failed.';

  @override
  String get biometricCheckFailed => 'Unable to check biometric availability.';

  @override
  String get biometricAuthenticateReason => 'Authenticate to log in';

  @override
  String get comment_network_service => '==== Network Service ====';

  @override
  String get networkServiceUnexpectedError =>
      'An unexpected error occurred. Please try again.';

  @override
  String get networkServiceTimeout => 'Request timed out. Please try again.';

  @override
  String get networkServiceGenericError =>
      'An error occurred. Please try again.';

  @override
  String get networkServiceUnauthorizedText => 'Unauthorized';

  @override
  String get networkServiceOkText => 'OK';

  @override
  String get networkServiceUnauthorizedMessage =>
      'You are not authorized to access this resource. Please log in again!';

  @override
  String get comment_api_access_key_screen => '==== API Access Key Screen ====';

  @override
  String get apiAccessKeyTitle => 'API Access Key';

  @override
  String get apiAccessKeyPublicKeyLabel => 'Public Key';

  @override
  String get apiAccessKeySecretKeyLabel => 'Secret Key';

  @override
  String get apiAccessKeyPublicKeyCopied => 'Public Key Copied';

  @override
  String get apiAccessKeySecretKeyCopied => 'Secret Key Copied';

  @override
  String get apiAccessKeyRegenerateButton => 'Regenerate';

  @override
  String get apiAccessKeyGenerateAlertTitle => 'Generate New API Access Key';

  @override
  String get apiAccessKeyGenerateAlertMessage =>
      'Are you sure you want to generate a new API access key?';

  @override
  String get comment_forgot_password_screen =>
      '==== Forgot Password Screen ====';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordEmailLabel => 'Email';

  @override
  String get forgotPasswordEmailRequired => 'The email field is required';

  @override
  String get forgotPasswordSendButton => 'Send Verify OTP';

  @override
  String get forgotPasswordGoBackButton => 'Go Back';

  @override
  String get comment_reset_password_screen => '==== Reset Password Screen ====';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordPasswordLabel => 'Password';

  @override
  String get resetPasswordConfirmPasswordLabel => 'Confirm Password';

  @override
  String get resetPasswordPasswordRequired => 'Password is required';

  @override
  String get resetPasswordPasswordLength =>
      'Password must be at least 8 characters';

  @override
  String get resetPasswordConfirmPasswordRequired =>
      'Please confirm your password';

  @override
  String get resetPasswordPasswordsDontMatch => 'Passwords don\'t match';

  @override
  String get resetPasswordButton => 'Reset';

  @override
  String get resetPasswordAlreadyHaveAccount => 'Already have an account? ';

  @override
  String get resetPasswordLoginLink => 'Login';

  @override
  String get comment_forgot_password_pin_verification_screen =>
      '==== Forgot Password Pin Verification Screen ====';

  @override
  String get forgotPasswordPinVerificationTitle => 'Verify OTP';

  @override
  String get forgotPasswordPinVerificationEnterOtp => 'Enter OTP';

  @override
  String get forgotPasswordPinVerificationOtpSentTo => 'OTP sent to';

  @override
  String forgotPasswordPinVerificationOtpCountdown(Object countdown) {
    return 'OTP in 00:$countdown';
  }

  @override
  String get forgotPasswordPinVerificationOtpRequired =>
      'The otp field is required';

  @override
  String get forgotPasswordPinVerificationVerifyButton => 'Verify OTP';

  @override
  String get forgotPasswordPinVerificationDidNotReceive =>
      'Didn\'t receive the code? ';

  @override
  String get forgotPasswordPinVerificationResend => 'Resend';

  @override
  String get comment_login_screen => '==== Login Screen ====';

  @override
  String get loginTitle => 'Merchant Login';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginEmailRequired => 'The email field is required';

  @override
  String get loginPasswordRequired => 'The password field is required';

  @override
  String get loginForgotPassword => 'Forget password';

  @override
  String get loginButton => 'Login';

  @override
  String get loginDontHaveAccount => 'Don\'t have an account? ';

  @override
  String get loginCreateAccount => 'Create one';

  @override
  String get loginFirstSignInRequired =>
      'First Sign In with Email and Password';

  @override
  String get loginBiometricNotEnabled => 'Your biometric is not enabled';

  @override
  String get comment_two_factor_auth_screen =>
      '==== Two Factor Auth Screen ====';

  @override
  String get twoFactorAuthTitle => 'Verify Two FA';

  @override
  String get twoFactorAuthEnterOtp => 'Enter OTP';

  @override
  String get twoFactorAuthOtpRequired => 'The otp field is required';

  @override
  String get twoFactorAuthVerifyButton => 'Verify';

  @override
  String get twoFactorAuthBackToLogin => 'Back to? ';

  @override
  String get twoFactorAuthLoginLink => 'Login';

  @override
  String get comment_auth_id_verification_screen =>
      '==== Auth ID Verification Screen ====';

  @override
  String get authIdVerificationInvalidType => 'Invalid field type';

  @override
  String authIdVerificationUnknownType(Object fieldType) {
    return 'Unknown field type: $fieldType';
  }

  @override
  String get comment_email_screen => '==== Email Screen ====';

  @override
  String get emailTitle => 'Merchant Register';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailRequired => 'Please enter an email';

  @override
  String get emailContinueButton => 'Continue';

  @override
  String get emailAlreadyHaveAccount => 'Already have an account? ';

  @override
  String get emailLoginLink => 'Login';

  @override
  String get comment_personal_info_screen => '==== Personal Info Screen ====';

  @override
  String get personalInfoTitle => 'Merchant Register';

  @override
  String get personalInfoSectionTitle => 'Basic Information';

  @override
  String get personalInfoFirstNameLabel => 'First Name';

  @override
  String get personalInfoLastNameLabel => 'Last Name';

  @override
  String get personalInfoUsernameLabel => 'Username';

  @override
  String get personalInfoCountryLabel => 'Country';

  @override
  String get personalInfoPhoneLabel => 'Phone No';

  @override
  String get personalInfoGenderLabel => 'Gender';

  @override
  String get personalInfoSubmitButton => 'Submit';

  @override
  String get personalInfoFirstNameRequired => 'First name is required';

  @override
  String get personalInfoLastNameRequired => 'Last name is required';

  @override
  String get personalInfoUsernameRequired => 'Username is required';

  @override
  String get personalInfoCountryRequired => 'Country is required';

  @override
  String get personalInfoPhoneRequired => 'Phone number is required';

  @override
  String get personalInfoGenderRequired => 'Gender is required';

  @override
  String get personalInfoSelectCountryTitle => 'Select Country';

  @override
  String get personalInfoSelectGenderTitle => 'Select Gender';

  @override
  String get personalInfoCountryNotFound => 'No Country Found';

  @override
  String get personalInfoGenderNotFound => 'No Gender Found';

  @override
  String get comment_set_up_password_screen =>
      '==== Set Up Password Screen ====';

  @override
  String get setUpPasswordTitle => 'Merchant Register';

  @override
  String get setUpPasswordSectionTitle => 'Setup Password';

  @override
  String get setUpPasswordPasswordLabel => 'Password';

  @override
  String get setUpPasswordConfirmPasswordLabel => 'Confirm Password';

  @override
  String get setUpPasswordAgreementText => 'I agree with the ';

  @override
  String get setUpPasswordTermsLink => 'Terms & Conditions';

  @override
  String get setUpPasswordSetupButton => 'Setup Password';

  @override
  String get setUpPasswordPasswordRequired => 'Password is required';

  @override
  String get setUpPasswordPasswordLength =>
      'Password must be at least 8 characters';

  @override
  String get setUpPasswordConfirmPasswordRequired =>
      'Please confirm your password';

  @override
  String get setUpPasswordPasswordsDontMatch => 'Passwords don\'t match';

  @override
  String get setUpPasswordAcceptTerms => 'Please accept terms and conditions';

  @override
  String get comment_sign_up_status_screen => '==== Sign Up Status Screen ====';

  @override
  String get signUpStatusCurrentStatusTitle => 'Current Status';

  @override
  String get signUpStatusSetupNextStepTitle => 'Let\'s set up your next step';

  @override
  String get signUpStatusStepEmail => 'Email';

  @override
  String get signUpStatusStepSetupPassword => 'Setup Password';

  @override
  String get signUpStatusStepPersonalInfo => 'Personal Info';

  @override
  String get signUpStatusStepIdVerification => 'ID Verification';

  @override
  String get signUpStatusStatusInReview => 'In Review';

  @override
  String get signUpStatusStatusRejected => 'Rejected';

  @override
  String get signUpStatusNoReasonProvided => 'No reason provided';

  @override
  String get signUpStatusNextButton => 'Next';

  @override
  String get signUpStatusSubmitAgainButton => 'Submit Again';

  @override
  String get signUpStatusDashboardButton => 'Dashboard';

  @override
  String get signUpStatusBackButton => 'Back';

  @override
  String get signUpStatusErrorProcessingStep =>
      'Error processing next step. Please try again.';

  @override
  String get comment_verify_email_screen => '==== Verify Email Screen ====';

  @override
  String get verifyEmailMerchantRegisterTitle => 'Merchant Register';

  @override
  String get verifyEmailVerifyEmailTitle => 'Verify Email';

  @override
  String get verifyEmailOtpSentTo => 'OTP sent to';

  @override
  String get verifyEmailResendAvailableIn => 'Resend available in';

  @override
  String get verifyEmailRequestNewOtp => 'You can request a new OTP now';

  @override
  String get verifyEmailContinueButton => 'Continue';

  @override
  String get verifyEmailOtpRequiredError => 'The otp field is required';

  @override
  String get verifyEmailDidntReceiveCode => 'Didn\'t receive the code? ';

  @override
  String get verifyEmailResendText => 'Resend';

  @override
  String get comment_welcome_screen => '==== Welcome Screen ====';

  @override
  String get welcomeTitle => 'Welcome to Merchant';

  @override
  String get welcomeSubtitle =>
      'Manage payments, track sales, and grow your business';

  @override
  String get welcomeCreateAccountButton => 'Create Account';

  @override
  String get welcomeLoginButton => 'Login';

  @override
  String get welcomeExitApplicationTitle => 'Exit Application';

  @override
  String get welcomeExitApplicationMessage =>
      'Are you sure you want to exit the application?';

  @override
  String get comment_change_password_controller =>
      '==== Change Password Controller Messages ====';

  @override
  String get changePasswordCurrentPasswordRequired =>
      'Please enter your current password';

  @override
  String get changePasswordNewPasswordRequired => 'Please enter a new password';

  @override
  String get changePasswordPasswordLength =>
      'Password must be at least 8 characters';

  @override
  String get changePasswordConfirmPasswordRequired =>
      'Please confirm your new password';

  @override
  String get changePasswordPasswordsDontMatch => 'Passwords do not match';

  @override
  String get comment_change_password_screen =>
      '==== Change Password Screen ====';

  @override
  String get changePasswordScreenTitle => 'Change Password';

  @override
  String get changePasswordCurrentPasswordLabel => 'Current Password';

  @override
  String get changePasswordNewPasswordLabel => 'New password';

  @override
  String get changePasswordConfirmPasswordLabel => 'Confirm password';

  @override
  String get changePasswordSaveChangesButton => 'Save Changes';

  @override
  String get comment_exchange_controller =>
      '==== Exchange Controller Messages ====';

  @override
  String get exchangeSelectFromWalletError => 'Please select a from wallet';

  @override
  String get exchangeSelectToWalletError => 'Please select a to wallet';

  @override
  String get exchangeEnterAmountError => 'Please enter an amount';

  @override
  String get exchangeMinAmountError => 'Minimum amount should be';

  @override
  String get exchangeMaxAmountError => 'Maximum amount should be';

  @override
  String get comment_exchange_screen => '==== Exchange Screen ====';

  @override
  String get exchangeScreenTitle => 'Exchange';

  @override
  String get comment_exchange_amount_step_section =>
      '==== Exchange Amount Step Section ====';

  @override
  String get exchangeFromWalletLabel => 'From Wallet';

  @override
  String get exchangeSelectFromWalletTitle => 'Select From Wallet';

  @override
  String get exchangeFromWalletsNotFound => 'From Wallets Not Found';

  @override
  String get exchangeToWalletLabel => 'To Wallet';

  @override
  String get exchangeSelectToWalletTitle => 'Select To Wallet';

  @override
  String get exchangeToWalletsNotFound => 'To Wallets Not Found';

  @override
  String get exchangeAmountLabel => 'Amount';

  @override
  String exchangeMinMaxLabel(Object currency, Object max, Object min) {
    return 'Minimum $min $currency and Maximum $max $currency';
  }

  @override
  String get exchangeRateLabel => 'Exchange Rate:';

  @override
  String get exchangeButton => 'Exchange';

  @override
  String get comment_exchange_review_step_section =>
      '==== Exchange Review Step Section ====';

  @override
  String get exchangeReviewTitle => 'Exchange Review';

  @override
  String get exchangeReviewAmount => 'Amount';

  @override
  String get exchangeReviewFromWallet => 'From Wallet';

  @override
  String get exchangeReviewCharge => 'Charge';

  @override
  String get exchangeReviewTotalAmount => 'Total Amount';

  @override
  String get exchangeReviewToWallet => 'To Wallet';

  @override
  String get exchangeReviewExchangeRate => 'Exchange Rate';

  @override
  String get exchangeReviewExchangeAmount => 'Exchange Amount';

  @override
  String get exchangeReviewExchangeNowButton => 'Exchange Now';

  @override
  String get comment_exchange_success_step_section =>
      '==== Exchange Success Step Section ====';

  @override
  String get exchangeSuccessTitle => 'Exchange Success';

  @override
  String get exchangeSuccessSubtitle => 'Your exchange have been successfully';

  @override
  String get exchangeSuccessAmount => 'Amount';

  @override
  String get exchangeSuccessTransactionId => 'Transaction ID';

  @override
  String get exchangeSuccessConvertedAmount => 'Converted Amount';

  @override
  String get exchangeSuccessCharge => 'Charge';

  @override
  String get exchangeSuccessDate => 'Date';

  @override
  String get exchangeSuccessFinalAmount => 'Final Amount';

  @override
  String get exchangeSuccessBackHomeButton => 'Back Home';

  @override
  String get exchangeSuccessExchangeAgainButton => 'Exchange Again';

  @override
  String get comment_home_controller => '==== Home Controller Messages ====';

  @override
  String get homeBiometricNotSupported =>
      'This device does not support biometrics.';

  @override
  String get homeBiometricEnabledSuccess => 'Biometric enabled successfully';

  @override
  String get homeBiometricDisabledSuccess => 'Biometric disabled successfully';

  @override
  String get homeBiometricAuthFailed =>
      'Authentication failed. Biometric setting not changed.';

  @override
  String get homeBiometricNotFoundTitle => 'Biometric Not Found';

  @override
  String get homeBiometricNotFoundMessage =>
      'No fingerprint or biometric is enrolled on this device. You can set it up from the system settings.';

  @override
  String get homeOpenSecuritySettingsButton => 'Open Security Settings';

  @override
  String get homeIosBiometricMessage =>
      'Please go to Settings > Face ID & Passcode to set up biometrics.';

  @override
  String get comment_drawer_section => '==== Drawer Section ====';

  @override
  String get drawerDashboard => 'Dashboard';

  @override
  String get drawerMyWallets => 'My Wallets';

  @override
  String get drawerQrCode => 'QR Code';

  @override
  String get drawerExchange => 'Exchange';

  @override
  String get drawerApiAccessKey => 'API Access Key';

  @override
  String get drawerTransactions => 'Transactions';

  @override
  String get drawerWithdraw => 'Withdraw';

  @override
  String get drawerInvoice => 'Invoice';

  @override
  String get drawerNotifications => 'Notifications';

  @override
  String get drawerSupportTicket => 'Support Ticket';

  @override
  String get comment_home_header_section => '==== Home Header Section ====';

  @override
  String get homeHeaderAccountNumberCopied => 'Account Number Copied';

  @override
  String get homeHeaderMerchantIdPrefix => 'MID:';

  @override
  String get comment_home_section_navigator =>
      '==== Home Section Navigator ====';

  @override
  String get homeViewAll => 'View All';

  @override
  String get comment_home_transaction_details =>
      '==== Home Transaction Details ====';

  @override
  String get transactionDetailsTitle => 'Transaction Details';

  @override
  String get transactionDescription => 'Description';

  @override
  String get transactionWallet => 'Wallet';

  @override
  String get transactionCharge => 'Charge';

  @override
  String get transactionTransactionId => 'Transaction ID';

  @override
  String get transactionMethod => 'Method';

  @override
  String get transactionTotalAmount => 'Total Amount';

  @override
  String get transactionStatus => 'Status';

  @override
  String get comment_home_transactions_section =>
      '==== Home Transactions Section ====';

  @override
  String get homeRecentTransactions => 'Recent Transactions';

  @override
  String get comment_home_wallets_section => '==== Home Wallets Section ====';

  @override
  String get homeMyWallets => 'My Wallets';

  @override
  String get homeNoWalletsFound => 'No wallets found';

  @override
  String get homeWalletWithdrawButton => 'Withdraw';

  @override
  String get comment_settings_bottom_sheet => '==== Settings Bottom Sheet ====';

  @override
  String get settingsProfileSetting => 'Profile Setting';

  @override
  String get settingsChangePassword => 'Change Password';

  @override
  String get settingsIdVerification => 'ID Verification';

  @override
  String get settingsTwoFa => '2FA';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsLogout => 'Logout';

  @override
  String get comment_kyc_details_bottom_sheet =>
      '==== KYC Details Bottom Sheet ====';

  @override
  String get kycDetailsTitle => 'KYC Details';

  @override
  String get kycDetailsStatusLabel => 'Status:';

  @override
  String get kycDetailsStatusPending => 'Pending';

  @override
  String get kycDetailsStatusApproved => 'Approved';

  @override
  String get kycDetailsStatusRejected => 'Rejected';

  @override
  String get kycDetailsCreatedAtLabel => 'Created At:';

  @override
  String get kycDetailsMessageFromAdmin => 'Message From Admin:';

  @override
  String get kycDetailsSubmittedData => 'Submitted Data';

  @override
  String get comment_kyc_history_screen => '==== KYC History Screen ====';

  @override
  String get kycHistoryTitle => 'KYC History';

  @override
  String get kycHistoryDateLabel => 'Date:';

  @override
  String get kycHistoryStatusLabel => 'Status: ';

  @override
  String get kycHistoryStatusPending => 'Pending';

  @override
  String get kycHistoryStatusApproved => 'Approved';

  @override
  String get kycHistoryStatusRejected => 'Rejected';

  @override
  String get kycHistoryViewButton => 'View';

  @override
  String get comment_id_verification_screen =>
      '==== ID Verification Screen ====';

  @override
  String get idVerificationTitle => 'ID Verification';

  @override
  String get idVerificationHistory => 'History';

  @override
  String get idVerificationVerificationCenter => 'Verification Center';

  @override
  String get idVerificationNothingToSubmit => 'You have nothing to submit';

  @override
  String get idVerificationStatus1Message =>
      'You have submitted your documents and it is verified';

  @override
  String get idVerificationStatus2Message =>
      'You have submitted your documents and it is awaiting for the approval';

  @override
  String get idVerificationStatus3Message =>
      'Your KYC verification has failed. Please resubmit the documents.';

  @override
  String get idVerificationStatus4Message =>
      'You have not submitted any KYC documents yet';

  @override
  String get comment_create_invoice_controller =>
      '==== Create Invoice Controller Messages ====';

  @override
  String get createInvoiceInvoiceToRequired => 'Please enter an invoice to';

  @override
  String get createInvoiceEmailRequired => 'Please enter an email address';

  @override
  String get createInvoiceAddressRequired => 'Please enter an address';

  @override
  String get createInvoiceWalletRequired => 'Please select a wallet';

  @override
  String get createInvoiceStatusRequired => 'Please select a status';

  @override
  String get createInvoiceIssueDateRequired => 'Please select an issue date';

  @override
  String createInvoiceItemNameRequired(Object number) {
    return 'Item $number: Name is required';
  }

  @override
  String createInvoiceItemQuantityRequired(Object number) {
    return 'Item $number: Quantity must be greater than 0';
  }

  @override
  String createInvoiceItemUnitPriceRequired(Object number) {
    return 'Item $number: Unit Price must be greater than 0';
  }

  @override
  String get createInvoiceSomethingWentWrong => 'Something went wrong!';

  @override
  String get comment_create_invoice_screen => '==== Create Invoice Screen ====';

  @override
  String get createInvoiceScreenTitle => 'Create Invoice';

  @override
  String get createInvoiceScreenInvoiceItems => 'Invoice Items';

  @override
  String get createInvoiceScreenAddItem => 'Add Item';

  @override
  String get createInvoiceScreenCreateInvoiceButton => 'Create Invoice';

  @override
  String get comment_create_invoice_add_item_section =>
      '==== Create Invoice Add Item Section ====';

  @override
  String get createInvoiceAddItemItemName => 'Item Name';

  @override
  String get createInvoiceAddItemQuantity => 'Quantity';

  @override
  String get createInvoiceAddItemUnitPrice => 'Unit Price';

  @override
  String get createInvoiceAddItemSubTotal => 'Sub Total';

  @override
  String get comment_create_invoice_information_section =>
      '==== Create Invoice Information Section ====';

  @override
  String get createInvoiceInformationTitle => 'Invoice Information';

  @override
  String get createInvoiceInformationInvoiceTo => 'Invoice To';

  @override
  String get createInvoiceInformationEmailAddress => 'Email Address';

  @override
  String get createInvoiceInformationAddress => 'Address';

  @override
  String get createInvoiceInformationSelectWallet => 'Select Wallet';

  @override
  String get createInvoiceInformationStatus => 'Status';

  @override
  String get createInvoiceInformationIssueDate => 'Issue Date';

  @override
  String get createInvoiceInformationSelectWalletTitle => 'Select Wallet';

  @override
  String get createInvoiceInformationWalletsNotFound => 'Wallets Not Found';

  @override
  String get createInvoiceInformationSelectStatusTitle => 'Select Status';

  @override
  String get createInvoiceInformationStatusNotFound => 'Status Not Found';

  @override
  String get comment_invoice_details_screen =>
      '==== Invoice Details Screen ====';

  @override
  String get invoiceDetailsTitle => 'Invoice';

  @override
  String invoiceDetailsRefNumber(Object number) {
    return 'Ref: #$number';
  }

  @override
  String invoiceDetailsIssuedDate(Object date) {
    return 'Issued: $date';
  }

  @override
  String get invoiceDetailsName => 'Name';

  @override
  String get invoiceDetailsEmail => 'Email';

  @override
  String get invoiceDetailsCharge => 'Charge';

  @override
  String get invoiceDetailsAddress => 'Address';

  @override
  String get invoiceDetailsTotalAmount => 'Total Amount';

  @override
  String get invoiceDetailsStatus => 'Status';

  @override
  String get invoiceDetailsItemName => 'Item Name';

  @override
  String get invoiceDetailsQuantity => 'Quantity';

  @override
  String get invoiceDetailsUnitPrice => 'Unit Price';

  @override
  String get invoiceDetailsSubTotal => 'Sub Total';

  @override
  String get invoiceDetailsPayNowButton => 'Pay Now';

  @override
  String get invoiceDetailsPrintInvoiceButton => 'Print Invoice';

  @override
  String get comment_invoice_pdf => '==== Invoice PDF Generator ====';

  @override
  String invoicePdfRefNumber(Object number) {
    return 'Ref: #$number';
  }

  @override
  String invoicePdfIssuedDate(Object date) {
    return 'Issued: $date';
  }

  @override
  String get invoicePdfTotalAmount => 'Total Amount:';

  @override
  String get invoicePdfAmount => 'Amount:';

  @override
  String get invoicePdfCharge => 'Charge:';

  @override
  String get invoicePdfItemName => 'Item Name';

  @override
  String get invoicePdfQuantity => 'Quantity';

  @override
  String get invoicePdfUnitPrice => 'Unit Price';

  @override
  String get invoicePdfSubtotal => 'Subtotal';

  @override
  String get invoicePdfSubtotalLabel => 'Subtotal: ';

  @override
  String get invoicePdfChargeLabel => 'Charge: ';

  @override
  String get invoicePdfTotalAmountLabel => 'Total Amount: ';

  @override
  String get invoicePdfThanksMessage => 'Thanks for the purchase.';

  @override
  String get comment_update_invoice_screen => '==== Update Invoice Screen ====';

  @override
  String get updateInvoiceTitle => 'Update Invoice';

  @override
  String get updateInvoiceInvoiceItems => 'Invoice Items';

  @override
  String get updateInvoiceAddItem => 'Add Item';

  @override
  String get updateInvoiceUpdateInvoiceButton => 'Update Invoice';

  @override
  String get comment_update_invoice_add_item_section =>
      '==== Update Invoice Add Item Section ====';

  @override
  String get updateInvoiceAddItemItemName => 'Item Name';

  @override
  String get updateInvoiceAddItemQuantity => 'Quantity';

  @override
  String get updateInvoiceAddItemUnitPrice => 'Unit Price';

  @override
  String get updateInvoiceAddItemSubTotal => 'Sub Total';

  @override
  String get comment_update_invoice_information_section =>
      '==== Update Invoice Information Section ====';

  @override
  String get updateInvoiceInformationTitle => 'Invoice Information';

  @override
  String get updateInvoiceInformationInvoiceTo => 'Invoice To';

  @override
  String get updateInvoiceInformationEmailAddress => 'Email Address';

  @override
  String get updateInvoiceInformationAddress => 'Address';

  @override
  String get updateInvoiceInformationSelectWallet => 'Select Wallet';

  @override
  String get updateInvoiceInformationStatus => 'Status';

  @override
  String get updateInvoiceInformationIssueDate => 'Issue Date';

  @override
  String get updateInvoiceInformationPaymentStatus => 'Payment Status';

  @override
  String get updateInvoiceInformationSelectWalletTitle => 'Select Wallet';

  @override
  String get updateInvoiceInformationWalletsNotFound => 'Wallets Not Found';

  @override
  String get updateInvoiceInformationSelectStatusTitle => 'Select Status';

  @override
  String get updateInvoiceInformationStatusNotFound => 'Status Not Found';

  @override
  String get updateInvoiceInformationSelectPaymentStatusTitle =>
      'Select Payment Status';

  @override
  String get updateInvoiceInformationPaymentStatusNotFound =>
      'Payment status not found';

  @override
  String get comment_invoice_screen => '==== Invoice Screen ====';

  @override
  String get invoiceScreenTitle => 'Invoice';

  @override
  String get invoiceScreenCreateInvoice => 'Create Invoice';

  @override
  String get invoiceScreenAmountLabel => 'Amount:';

  @override
  String get invoiceScreenChargeLabel => 'Charge:';

  @override
  String get invoiceScreenStatusLabel => 'Status: ';

  @override
  String get invoiceScreenViewButton => 'View';

  @override
  String get comment_notification_screen => '==== Notification Screen ====';

  @override
  String get notificationScreenTitle => 'Notifications';

  @override
  String get notificationScreenMarkAll => 'Mark All';

  @override
  String get comment_profile_screen => '==== Profile Screen ====';

  @override
  String get profileScreenTitle => 'Profile';

  @override
  String get profileScreenProfileSettings => 'Profile Settings';

  @override
  String get profileScreenChangePassword => 'Change Password';

  @override
  String get profileScreenLanguage => 'Language';

  @override
  String get profileScreenBiometric => 'Biometric';

  @override
  String get profileScreenLogout => 'Logout';

  @override
  String get profileScreenBackButton => 'Back';

  @override
  String get profileScreenSelectLanguageTitle => 'Select Language';

  @override
  String get comment_profile_settings_screen =>
      '==== Profile Settings Screen ====';

  @override
  String get profileSettingsTitle => 'Profile Settings';

  @override
  String get profileSettingsFirstName => 'First Name';

  @override
  String get profileSettingsLastName => 'Last Name';

  @override
  String get profileSettingsUserName => 'User Name';

  @override
  String get profileSettingsGender => 'Gender';

  @override
  String get profileSettingsDateOfBirth => 'Date Of Birth';

  @override
  String get profileSettingsEmailAddress => 'Email Address';

  @override
  String get profileSettingsPhone => 'Phone';

  @override
  String get profileSettingsCountry => 'Country';

  @override
  String get profileSettingsCity => 'City';

  @override
  String get profileSettingsZipCode => 'Zip Code';

  @override
  String get profileSettingsJoiningDate => 'Joining Date';

  @override
  String get profileSettingsAddress => 'Address';

  @override
  String get profileSettingsSaveChanges => 'Save Changes';

  @override
  String get profileSettingsSelectGenderTitle => 'Select Gender';

  @override
  String get profileSettingsNoGenderFound => 'No Gender Found';

  @override
  String get profileSettingsSelectCountryTitle => 'Select Country';

  @override
  String get profileSettingsNoCountryFound => 'No Country Found';

  @override
  String get comment_qr_code_screen => '==== QR Code Screen ====';

  @override
  String get qrCodeTitle => 'My Qr Code';

  @override
  String qrCodeMerchantId(Object accountNumber) {
    return 'MID: $accountNumber';
  }

  @override
  String get qrCodeDownloadButton => 'Download';

  @override
  String get qrCodeDownloadSuccess => 'Downloaded successfully!';

  @override
  String get qrCodePermissionRequired =>
      'Permission is required. Please allow it in settings.';

  @override
  String get comment_add_new_ticket_controller =>
      '==== Add New Ticket Controller Messages ====';

  @override
  String get addNewTicketTitleRequired => 'Please enter a title';

  @override
  String get addNewTicketDescriptionRequired => 'Please enter a description';

  @override
  String get addNewTicketSuccessMessage => 'Ticket created successfully';

  @override
  String get comment_add_new_ticket_screen => '==== Add New Ticket Screen ====';

  @override
  String get addNewTicketTitle => 'Create Ticket';

  @override
  String get addNewTicketTitleLabel => 'Title';

  @override
  String get addNewTicketDescriptionLabel => 'Description';

  @override
  String get addNewTicketAddAttach => 'Add Attach';

  @override
  String get addNewTicketAttachFile => 'Attach File';

  @override
  String get addNewTicketAddTicketButton => 'Add Ticket';

  @override
  String get comment_replay_ticket_screen => '==== Replay Ticket Screen ====';

  @override
  String get replayTicketCloseButton => 'Close';

  @override
  String get replayTicketMessageRequired => 'Please enter an message';

  @override
  String get replayTicketAttachmentsLabel => 'Attachments:';

  @override
  String get replayTicketUnknownFile => 'Unknown file';

  @override
  String get replayTicketTypeMessageHint => 'Type your message';

  @override
  String get replayTicketAttachmentPreviewTitle => 'Attachment Preview';

  @override
  String get comment_support_ticket_screen => '==== Support Ticket Screen ====';

  @override
  String get supportTicketTitle => 'Support Ticket';

  @override
  String get supportTicketStatusOpen => 'Open';

  @override
  String get supportTicketStatusClosed => 'Closed';

  @override
  String get supportTicketViewButton => 'View';

  @override
  String get comment_transaction_filter_bottom_sheet =>
      '==== Transaction Filter Bottom Sheet ====';

  @override
  String get transactionFilterTransactionId => 'Transaction ID';

  @override
  String get transactionFilterStatus => 'Status';

  @override
  String get transactionFilterApplyButton => 'Apply';

  @override
  String get comment_transactions_screen => '==== Transactions Screen ====';

  @override
  String get transactionsScreenTitle => 'Transactions';

  @override
  String get comment_two_fa_authentication_screen =>
      '==== 2FA Authentication Screen ====';

  @override
  String get twoFaAuthenticationTitle => '2FA Authentication';

  @override
  String get comment_disable_two_fa_section => '==== Disable 2FA Section ====';

  @override
  String get disableTwoFaTitle => '2FA Authentication';

  @override
  String get disableTwoFaInstruction => 'Enter your password to disable 2FA';

  @override
  String get disableTwoFaPasswordRequired => 'Please enter an password';

  @override
  String get disableTwoFaButton => 'Disable 2FA';

  @override
  String get comment_enable_two_fa_section => '==== Enable 2FA Section ====';

  @override
  String get enableTwoFaTitle => '2FA Authentication';

  @override
  String get enableTwoFaInstruction =>
      'Scan the QR code with Google Authenticator\nApp to enable 2FA';

  @override
  String get enableTwoFaPinLabel => 'The PIN From Google Authenticator App';

  @override
  String get enableTwoFaPinRequired =>
      'Please enter an google authentication pin';

  @override
  String get enableTwoFaButton => 'Enable 2FA';

  @override
  String get comment_generate_qr_code_section =>
      '==== Generate QR Code Section ====';

  @override
  String get generateQrCodeTitle => '2FA Authentication';

  @override
  String get generateQrCodeDescription =>
      'Enhance your account security with two-factor authentication';

  @override
  String get generateQrCodeButton => 'Generate 2FA';

  @override
  String get comment_create_new_wallet_screen =>
      '==== Create New Wallet Screen ====';

  @override
  String get createNewWalletTitle => 'Create New Wallet';

  @override
  String get createNewWalletSelectCurrency => 'Select Currency';

  @override
  String get createNewWalletCurrencyLabel => 'Currency';

  @override
  String get createNewWalletCreateButton => 'Create';

  @override
  String get createNewWalletSelectCurrencyTitle => 'Select Currency';

  @override
  String get createNewWalletNoCurrencyFound => 'No Currency Found';

  @override
  String get comment_delete_wallet_bottom_sheet =>
      '==== Delete Wallet Bottom Sheet ====';

  @override
  String get deleteWalletTitle => 'Are you sure?';

  @override
  String get deleteWalletMessage =>
      'Once you delete your data, you won\'t be able to revert this!';

  @override
  String get deleteWalletConfirmButton => 'Confirm';

  @override
  String get comment_wallet_details_screen => '==== Wallet Details Screen ====';

  @override
  String get walletDetailsTitle => 'Wallet Details';

  @override
  String get walletDetailsTotalBalance => 'Total Balance';

  @override
  String get walletDetailsWithdrawButton => 'Withdraw';

  @override
  String get walletDetailsHistory => 'History';

  @override
  String get walletDetailsSelectWalletTitle => 'Select Wallet';

  @override
  String get walletDetailsWalletNotFound => 'Wallet not found';

  @override
  String get comment_wallets_screen => '==== Wallets Screen ====';

  @override
  String get walletsScreenTitle => 'My Wallets';

  @override
  String get walletsScreenWithdrawButton => 'Withdraw';

  @override
  String get walletsScreenDeleteButton => 'Delete';

  @override
  String get comment_create_withdraw_account_controller =>
      '==== Create Withdraw Account Controller Messages ====';

  @override
  String get createWithdrawAccountWalletRequired => 'Please select a wallet';

  @override
  String get createWithdrawAccountWithdrawMethodRequired =>
      'Please select a withdraw method';

  @override
  String get createWithdrawAccountMethodNameRequired =>
      'Please enter an method name';

  @override
  String createWithdrawAccountFileRequired(Object fieldName) {
    return 'Please upload a file for $fieldName';
  }

  @override
  String createWithdrawAccountFieldRequired(Object fieldName) {
    return 'Please fill in the $fieldName field';
  }

  @override
  String get comment_withdraw_controller =>
      '==== Withdraw Controller Messages ====';

  @override
  String get withdrawWithdrawAccountRequired =>
      'Please select a withdraw account';

  @override
  String get withdrawAmountRequired => 'Please enter an amount';

  @override
  String withdrawMinAmountError(Object currency, Object min) {
    return 'Minimum amount should be $min $currency';
  }

  @override
  String withdrawMaxAmountError(Object currency, Object max) {
    return 'Maximum amount should be $max $currency';
  }

  @override
  String get comment_create_withdraw_account_screen =>
      '==== Create Withdraw Account Screen ====';

  @override
  String get createWithdrawAccountScreenTitle => 'Create Withdraw Account';

  @override
  String get createWithdrawAccountScreenHeader => 'Create Withdraw Account';

  @override
  String get createWithdrawAccountScreenWalletLabel => 'Wallet';

  @override
  String get createWithdrawAccountScreenWithdrawMethodLabel =>
      'Withdraw Method';

  @override
  String get createWithdrawAccountScreenMethodNameLabel => 'Method Name';

  @override
  String get createWithdrawAccountScreenCreateButton => 'Create';

  @override
  String get createWithdrawAccountScreenSelectWalletTitle => 'Select Wallet';

  @override
  String get createWithdrawAccountScreenWalletNotFound => 'Wallet not found';

  @override
  String get createWithdrawAccountScreenSelectMethodTitle => 'Select Method';

  @override
  String get createWithdrawAccountScreenWithdrawMethodNotFound =>
      'Withdraw method not found';

  @override
  String get comment_edit_withdraw_account_screen =>
      '==== Edit Withdraw Account Screen ====';

  @override
  String get editWithdrawAccountScreenTitle => 'Edit Withdraw Account';

  @override
  String get editWithdrawAccountScreenHeader => 'Edit Withdraw Account';

  @override
  String get editWithdrawAccountScreenMethodNameLabel => 'Method name';

  @override
  String get editWithdrawAccountScreenUpdateButton => 'Update';

  @override
  String get comment_withdraw_screen => '==== Withdraw Screen ====';

  @override
  String get withdrawScreenTitle => 'Withdraw Money';

  @override
  String get comment_delete_account_dropdown_section =>
      '==== Delete Account Dropdown Section ====';

  @override
  String get deleteAccountTitle => 'Delete Withdraw account?';

  @override
  String get deleteAccountWarningPart1 =>
      'This can\'t be undone. All data will be';

  @override
  String get deleteAccountWarningPart2 => ' removed.';

  @override
  String get deleteAccountDeleteButton => 'Delete';

  @override
  String get deleteAccountCancelButton => 'Cancel';

  @override
  String get comment_withdraw_account_filter_bottom_sheet =>
      '==== Withdraw Account Filter Bottom Sheet ====';

  @override
  String get withdrawAccountFilterAccountName => 'Account Name';

  @override
  String get withdrawAccountFilterSearchButton => 'Search';

  @override
  String get comment_withdraw_account_section =>
      '==== Withdraw Account Section ====';

  @override
  String get withdrawAccountSectionAllAccount => 'All Account';

  @override
  String get withdrawAccountSectionAddAccount => 'Add Account';

  @override
  String get comment_withdraw_amount_step_section =>
      '==== Withdraw Amount Step Section ====';

  @override
  String get withdrawAmountStepAccount => 'Account';

  @override
  String get withdrawAmountStepAmount => 'Amount';

  @override
  String get withdrawAmountStepContinueButton => 'Continue';

  @override
  String withdrawAmountStepMinMaxAmount(
    Object currency,
    Object max,
    Object min,
  ) {
    return 'Minimum $min $currency and Maximum $max $currency';
  }

  @override
  String get withdrawAmountStepSelectWithdrawAccountTitle =>
      'Select Withdraw Account';

  @override
  String get withdrawAmountStepWithdrawAccountNotFound =>
      'Withdraw Account Not Found';

  @override
  String get withdrawAmountStepSelectWalletTitle => 'Select Wallet';

  @override
  String get withdrawAmountStepWalletsNotFound => 'Wallets Not Found';

  @override
  String get comment_withdraw_review_step_section =>
      '==== Withdraw Review Step Section ====';

  @override
  String get withdrawReviewStepTitle => 'Review Details';

  @override
  String get withdrawReviewStepAmount => 'Amount';

  @override
  String get withdrawReviewStepCharge => 'Charge';

  @override
  String get withdrawReviewStepTotal => 'Total';

  @override
  String get withdrawReviewStepWithdrawNowButton => 'Withdraw Now';

  @override
  String get comment_withdraw_success_step_section =>
      '==== Withdraw Success Step Section ====';

  @override
  String get withdrawSuccessStepTitle => 'Withdrawal Pending';

  @override
  String get withdrawSuccessStepSubtitle =>
      'Your funds have been pending\nwithdrawn.';

  @override
  String get withdrawSuccessStepAmount => 'Amount';

  @override
  String get withdrawSuccessStepTransactionId => 'Transaction ID';

  @override
  String get withdrawSuccessStepCharge => 'Charge';

  @override
  String get withdrawSuccessStepTransactionType => 'Transaction Type';

  @override
  String get withdrawSuccessStepFinalAmount => 'Final Amount';

  @override
  String get withdrawSuccessStepDateTime => 'Date & Time';

  @override
  String get withdrawSuccessStepBackHomeButton => 'Back Home';

  @override
  String get withdrawSuccessStepWithdrawAgainButton => 'Withdraw Again';

  @override
  String get comment_withdraw_toggle_section =>
      '==== Withdraw Toggle Section ====';

  @override
  String get withdrawToggleWithdraw => 'Withdraw';

  @override
  String get withdrawToggleWithdrawAccount => 'Withdraw Account';

  @override
  String get comment_dynamic_attachment_preview =>
      '==== Dynamic Attachment Preview ====';

  @override
  String get dynamicAttachmentPreviewTitle => 'Attachment Preview';

  @override
  String get comment_no_internet_connection_screen =>
      '==== No Internet Connection Screen ====';

  @override
  String get noInternetConnectionTitle => 'No Internet Connection';

  @override
  String get noInternetConnectionMessage =>
      'Please check your network settings';

  @override
  String get noInternetConnectionRetryButton => 'Retry';

  @override
  String get comment_web_view_screen => '==== Web View Screen ====';

  @override
  String get webViewPaymentSuccess => 'Payment Successful!';

  @override
  String get webViewPaymentFailed => 'Payment Failed!';

  @override
  String get webViewPaymentCancelled => 'Payment was cancelled!';
}
