import 'package:get/get.dart';
import 'package:qunzo_merchant/src/app/bindings/app_bindings.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/app/routes/routes_config.dart';

List<GetPage> routesHandler = [
  GetPage(
    name: BaseRoute.splash,
    page: () => RoutesConfig.splash,
    binding: SplashBinding(),
  ),

  GetPage(name: BaseRoute.welcome, page: () => RoutesConfig.welcome),

  GetPage(
    name: BaseRoute.login,
    page: () => RoutesConfig.login,
    binding: LoginBinding(),
  ),

  GetPage(
    name: BaseRoute.forgotPassword,
    page: () => RoutesConfig.forgotPassword,
    binding: ForgotPasswordBinding(),
  ),

  GetPage(
    name: BaseRoute.navigation,
    page: () => RoutesConfig.navigation,
    bindings: [HomeBinding(), UserProfileBinding(), WalletsBinding()],
  ),

  GetPage(
    name: BaseRoute.wallets,
    page: () => RoutesConfig.wallets,
    binding: WalletsBinding(),
  ),

  GetPage(
    name: BaseRoute.qrCode,
    page: () => RoutesConfig.qrCode,
    binding: QrCodeBinding(),
  ),

  GetPage(
    name: BaseRoute.apiAccessKey,
    page: () => RoutesConfig.apiAccessKey,
    binding: ApiAccessKeyBinding(),
  ),

  GetPage(
    name: BaseRoute.transactions,
    page: () => RoutesConfig.transactions,
    binding: TransactionsBinding(),
  ),

  GetPage(
    name: BaseRoute.resetPassword,
    page: () => RoutesConfig.resetPassword,
    binding: ResetPasswordBinding(),
  ),

  GetPage(
    name: BaseRoute.forgotPasswordPinVerification,
    page: () => RoutesConfig.forgotPasswordPinVerification,
    binding: ForgotPasswordPinVerificationBinding(),
  ),

  GetPage(
    name: BaseRoute.twoFactorAuth,
    page: () => RoutesConfig.twoFactorAuth,
    binding: TwoFactorAuthBinding(),
  ),

  GetPage(
    name: BaseRoute.notification,
    page: () => RoutesConfig.notification,
    binding: NotificationBinding(),
  ),

  GetPage(name: BaseRoute.profile, page: () => RoutesConfig.profile),

  GetPage(
    name: BaseRoute.createNewWallet,
    page: () => RoutesConfig.createNewWallet,
    binding: CreateNewWalletBinding(),
  ),

  GetPage(
    name: BaseRoute.profileSettings,
    page: () => RoutesConfig.profileSettings,
    binding: ProfileSettingsBinding(),
  ),

  GetPage(
    name: BaseRoute.changePassword,
    page: () => RoutesConfig.changePassword,
    binding: ChangePasswordBinding(),
  ),

  GetPage(
    name: BaseRoute.supportTicket,
    page: () => RoutesConfig.supportTicket,
    binding: SupportTicketBinding(),
  ),

  GetPage(
    name: BaseRoute.idVerification,
    page: () => RoutesConfig.idVerification,
    binding: IdVerificationBinding(),
  ),

  GetPage(
    name: BaseRoute.addNewTicket,
    page: () => RoutesConfig.addNewTicket,
    binding: AddNewTicketBinding(),
  ),

  GetPage(
    name: BaseRoute.withdraw,
    page: () => RoutesConfig.withdraw,
    bindings: [WithdrawBinding(), WithdrawAccountBinding()],
  ),

  GetPage(
    name: BaseRoute.createWithdrawAccount,
    page: () => RoutesConfig.createWithdrawAccount,
    binding: CreateWithdrawAccountBinding(),
  ),

  GetPage(
    name: BaseRoute.walletsDetails,
    page: () => RoutesConfig.walletsDetails,
    binding: WalletDetailsBinding(),
  ),

  GetPage(
    name: BaseRoute.email,
    page: () => RoutesConfig.email,
    binding: EmailBinding(),
  ),

  GetPage(
    name: BaseRoute.verifyEmail,
    page: () => RoutesConfig.verifyEmail,
    binding: VerifyEmailBinding(),
  ),

  GetPage(
    name: BaseRoute.signUpStatus,
    page: () => RoutesConfig.signUpStatus,
    binding: SignUpStatusBinding(),
  ),

  GetPage(
    name: BaseRoute.setUpPassword,
    page: () => RoutesConfig.setUpPassword,
    binding: SetUpPasswordBinding(),
  ),

  GetPage(
    name: BaseRoute.personalInfo,
    page: () => RoutesConfig.personalInfo,
    bindings: [
      PersonalInfoBinding(),
      RegisterFieldsBinding(),
      CountryBinding(),
    ],
  ),

  GetPage(
    name: BaseRoute.authIdVerification,
    page: () => RoutesConfig.authIdVerification,
    binding: AuthIdVerificationBinding(),
  ),

  GetPage(
    name: BaseRoute.idVerification,
    page: () => RoutesConfig.idVerification,
    binding: IdVerificationBinding(),
  ),

  GetPage(
    name: BaseRoute.kycHistory,
    page: () => RoutesConfig.kycHistory,
    binding: KycHistoryBinding(),
  ),

  GetPage(
    name: BaseRoute.twoFaAuthentication,
    page: () => RoutesConfig.twoFaAuthentication,
    bindings: [TwoFaAuthenticationBinding(), UserProfileBinding()],
  ),

  GetPage(
    name: BaseRoute.noInternetConnection,
    page: () => RoutesConfig.noInternetConnection,
  ),

  GetPage(
    name: BaseRoute.exchange,
    page: () => RoutesConfig.exchange,
    binding: ExchangeBinding(),
  ),

  GetPage(
    name: BaseRoute.invoice,
    page: () => RoutesConfig.invoice,
    binding: InvoiceBinding(),
  ),

  GetPage(
    name: BaseRoute.createInvoice,
    page: () => RoutesConfig.createInvoice,
    binding: CreateInvoiceBinding(),
  ),

  GetPage(
    name: BaseRoute.updateInvoice,
    page: () => RoutesConfig.updateInvoice,
    binding: UpdateInvoiceBinding(),
  ),

  GetPage(
    name: BaseRoute.invoiceDetails,
    page: () => RoutesConfig.invoiceDetails,
    binding: InvoiceDetailsBinding(),
  ),
];
