import 'package:get/get.dart';
import 'package:qunzo_merchant/src/common/controller/country_controller.dart';
import 'package:qunzo_merchant/src/common/controller/register_fields_controller.dart';
import 'package:qunzo_merchant/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/api_access_key/controller/api_access_key_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/forgot_password/controller/forgot_password_pin_verification_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/forgot_password/controller/reset_password_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/login/controller/login_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/login/controller/two_factor_auth_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/auth_id_verification_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/email_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/personal_info_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/set_up_password_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/sign_up_status_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/verify_email_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/splash/controller/splash_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/change_password/controller/change_password_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/exchange/controller/exchange_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/id_verification/controller/id_verification_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/id_verification/controller/kyc_history_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/controller/create_invoice_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/controller/invoice_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/controller/invoice_details_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/invoice/controller/update_invoice_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/notification/controller/notification_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/profile_settings/controller/profile_settings_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/qr_code/controller/qr_code_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/support_ticket/controller/add_new_ticket_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/support_ticket/controller/support_ticket_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/transactions/controller/transactions_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/two_fa_authentication/controller/two_fa_authentication_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/controller/create_new_wallet_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/controller/wallet_details_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/controller/wallets_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/controller/create_withdraw_account_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/controller/withdraw_account_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/controller/withdraw_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class ForgotPasswordPinVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordPinVerificationController>(
      () => ForgotPasswordPinVerificationController(),
    );
  }
}

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}

class TwoFactorAuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TwoFactorAuthController>(() => TwoFactorAuthController());
  }
}

class UserProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}

class WalletsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletsController>(() => WalletsController());
  }
}

class CreateNewWalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNewWalletController>(() => CreateNewWalletController());
  }
}

class QrCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrCodeController>(() => QrCodeController());
  }
}

class ApiAccessKeyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiAccessKeyController>(() => ApiAccessKeyController());
  }
}

class TransactionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsController>(() => TransactionsController());
  }
}

class ProfileSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsController>(() => ProfileSettingsController());
  }
}

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}

class SupportTicketBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportTicketController>(() => SupportTicketController());
  }
}

class IdVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdVerificationController>(() => IdVerificationController());
  }
}

class AddNewTicketBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewTicketController>(() => AddNewTicketController());
  }
}

class WithdrawBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawController>(() => WithdrawController());
  }
}

class WithdrawAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawAccountController>(() => WithdrawAccountController());
  }
}

class CreateWithdrawAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateWithdrawAccountController>(
      () => CreateWithdrawAccountController(),
    );
  }
}

class WalletDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletDetailsController>(() => WalletDetailsController());
  }
}

class EmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailController>(() => EmailController());
  }
}

class VerifyEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyEmailController>(() => VerifyEmailController());
  }
}

class SignUpStatusBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpStatusController>(() => SignUpStatusController());
  }
}

class SetUpPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetUpPasswordController>(() => SetUpPasswordController());
  }
}

class PersonalInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInfoController>(() => PersonalInfoController());
  }
}

class RegisterFieldsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterFieldsController>(() => RegisterFieldsController());
  }
}

class CountryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountryController>(() => CountryController());
  }
}

class AuthIdVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthIdVerificationController>(
      () => AuthIdVerificationController(),
    );
  }
}

class KycHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KycHistoryController>(() => KycHistoryController());
  }
}

class TwoFaAuthenticationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TwoFaAuthenticationController>(
      () => TwoFaAuthenticationController(),
    );
  }
}

class ExchangeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(() => ExchangeController());
  }
}

class InvoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceController>(() => InvoiceController());
  }
}

class InvoiceDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceDetailsController>(() => InvoiceDetailsController());
  }
}

class CreateInvoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateInvoiceController>(() => CreateInvoiceController());
  }
}

class UpdateInvoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateInvoiceController>(() => UpdateInvoiceController());
  }
}
