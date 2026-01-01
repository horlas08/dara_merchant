import 'package:qunzo_merchant/src/app/navigation/navigation_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/api_access_key/view/api_access_key_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/forgot_password/view/forgot_password_pin_verification/forgot_password_pin_verification.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/forgot_password/view/forgot_password_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/forgot_password/view/reset_password/reset_password.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/login/view/login_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/login/view/sub_sections/two_factor_auth.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/auth_id_verification/auth_id_verification_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/email/email_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/personal_info/personal_info_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/set_up_password/set_up_password_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/sign_up_status/sign_up_status_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/verify_email_screen/verify_email_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/splash/view/splash_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/welcome/view/welcome_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/change_password/view/change_password_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/exchange/view/exchange_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/id_verification/view/id_verification_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/id_verification/view/kyc_history/kyc_history.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/view/create_invoice/create_invoice.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/view/invoice_details/invoice_details.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/view/invoice_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/view/update_invoice/update_invoice.dart';
import 'package:qunzo_merchant/src/presentation/screens/notification/view/notification_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/profile/view/profile_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/profile_settings/view/profile_settings_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/qr_code/view/qr_code_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/support_ticket/view/add_new_ticket/add_new_ticket.dart';
import 'package:qunzo_merchant/src/presentation/screens/support_ticket/view/support_ticket_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/transactions/view/transactions_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/two_fa_authentication/view/two_fa_authentication.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/view/create_new_wallet/create_new_wallet.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/view/wallet_details/wallet_details.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/view/wallets_screen.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/view/create_withdraw_account/create_withdraw_account.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/view/withdraw_screen.dart';
import 'package:qunzo_merchant/src/presentation/widgets/no_internet_connection.dart';

class RoutesConfig {
  static const splash = SplashScreen();

  static const welcome = WelcomeScreen();

  static const login = LoginScreen();

  static const forgotPassword = ForgotPasswordScreen();

  static const navigation = NavigationScreen();

  static const wallets = WalletsScreen();

  static const createNewWallet = CreateNewWallet();

  static const qrCode = QrCodeScreen();

  static const apiAccessKey = ApiAccessKeyScreen();

  static const transactions = TransactionsScreen();

  static const notification = NotificationScreen();

  static const resetPassword = ResetPassword();

  static const forgotPasswordPinVerification = ForgotPasswordPinVerification();

  static const twoFactorAuth = TwoFactorAuth();

  static const profile = ProfileScreen();

  static const profileSettings = ProfileSettingsScreen();

  static const changePassword = ChangePasswordScreen();

  static const supportTicket = SupportTicketScreen();

  static const idVerification = IdVerificationScreen();

  static const addNewTicket = AddNewTicket();

  static const withdraw = WithdrawScreen();

  static const createWithdrawAccount = CreateWithdrawAccount();

  static const walletsDetails = WalletDetails();

  static const email = EmailScreen();

  static const verifyEmail = VerifyEmailScreen();

  static const signUpStatus = SignUpStatusScreen();

  static const setUpPassword = SetUpPasswordScreen();

  static const personalInfo = PersonalInfoScreen();

  static const authIdVerification = AuthIdVerificationScreen();

  static const kycHistory = KycHistory();

  static const twoFaAuthentication = TwoFaAuthentication();

  static const noInternetConnection = NoInternetConnection();

  static const exchange = ExchangeScreen();

  static const invoice = InvoiceScreen();

  static const invoiceDetails = InvoiceDetails();

  static const createInvoice = CreateInvoice();

  static const updateInvoice = UpdateInvoice();
}
