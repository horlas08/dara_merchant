import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @comment_all_controller.
  ///
  /// In en, this message translates to:
  /// **'==== All Controller Error Message ===='**
  String get comment_all_controller;

  /// No description provided for @allControllerGeneralError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get allControllerGeneralError;

  /// No description provided for @comment_exit_app_message.
  ///
  /// In en, this message translates to:
  /// **'==== Exit App Message ===='**
  String get comment_exit_app_message;

  /// No description provided for @exitAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit Application'**
  String get exitAppTitle;

  /// No description provided for @exitAppMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the application?'**
  String get exitAppMessage;

  /// No description provided for @comment_splash_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Splash Screen ===='**
  String get comment_splash_screen;

  /// No description provided for @splashMerchant.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get splashMerchant;

  /// No description provided for @comment_navigation_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Navigation Screen ===='**
  String get comment_navigation_screen;

  /// No description provided for @navigationHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigationHome;

  /// No description provided for @navigationWallets.
  ///
  /// In en, this message translates to:
  /// **'Wallets'**
  String get navigationWallets;

  /// No description provided for @navigationProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navigationProfile;

  /// No description provided for @navigationSetting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get navigationSetting;

  /// No description provided for @comment_image_picker_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Image Picker Controller ===='**
  String get comment_image_picker_controller;

  /// No description provided for @imagePickerGalleryError.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image from gallery'**
  String get imagePickerGalleryError;

  /// No description provided for @imagePickerCameraError.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image from camera'**
  String get imagePickerCameraError;

  /// No description provided for @comment_biometric_auth_service.
  ///
  /// In en, this message translates to:
  /// **'==== Biometric Auth Service ===='**
  String get comment_biometric_auth_service;

  /// No description provided for @biometricDeviceNotSupported.
  ///
  /// In en, this message translates to:
  /// **'This device does not support biometrics.'**
  String get biometricDeviceNotSupported;

  /// No description provided for @biometricNoEnrolled.
  ///
  /// In en, this message translates to:
  /// **'No biometric enrolled. Please set up fingerprint'**
  String get biometricNoEnrolled;

  /// No description provided for @biometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric features are currently unavailable.'**
  String get biometricUnavailable;

  /// No description provided for @biometricAuthenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication failed.'**
  String get biometricAuthenticationFailed;

  /// No description provided for @biometricCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to check biometric availability.'**
  String get biometricCheckFailed;

  /// No description provided for @biometricAuthenticateReason.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to log in'**
  String get biometricAuthenticateReason;

  /// No description provided for @comment_network_service.
  ///
  /// In en, this message translates to:
  /// **'==== Network Service ===='**
  String get comment_network_service;

  /// No description provided for @networkServiceUnexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get networkServiceUnexpectedError;

  /// No description provided for @networkServiceTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again.'**
  String get networkServiceTimeout;

  /// No description provided for @networkServiceGenericError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get networkServiceGenericError;

  /// No description provided for @networkServiceUnauthorizedText.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get networkServiceUnauthorizedText;

  /// No description provided for @networkServiceOkText.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get networkServiceOkText;

  /// No description provided for @networkServiceUnauthorizedMessage.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to access this resource. Please log in again!'**
  String get networkServiceUnauthorizedMessage;

  /// No description provided for @comment_api_access_key_screen.
  ///
  /// In en, this message translates to:
  /// **'==== API Access Key Screen ===='**
  String get comment_api_access_key_screen;

  /// No description provided for @apiAccessKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'API Access Key'**
  String get apiAccessKeyTitle;

  /// No description provided for @apiAccessKeyPublicKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'Public Key'**
  String get apiAccessKeyPublicKeyLabel;

  /// No description provided for @apiAccessKeySecretKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'Secret Key'**
  String get apiAccessKeySecretKeyLabel;

  /// No description provided for @apiAccessKeyPublicKeyCopied.
  ///
  /// In en, this message translates to:
  /// **'Public Key Copied'**
  String get apiAccessKeyPublicKeyCopied;

  /// No description provided for @apiAccessKeySecretKeyCopied.
  ///
  /// In en, this message translates to:
  /// **'Secret Key Copied'**
  String get apiAccessKeySecretKeyCopied;

  /// No description provided for @apiAccessKeyRegenerateButton.
  ///
  /// In en, this message translates to:
  /// **'Regenerate'**
  String get apiAccessKeyRegenerateButton;

  /// No description provided for @apiAccessKeyGenerateAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Generate New API Access Key'**
  String get apiAccessKeyGenerateAlertTitle;

  /// No description provided for @apiAccessKeyGenerateAlertMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to generate a new API access key?'**
  String get apiAccessKeyGenerateAlertMessage;

  /// No description provided for @comment_forgot_password_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Forgot Password Screen ===='**
  String get comment_forgot_password_screen;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get forgotPasswordEmailLabel;

  /// No description provided for @forgotPasswordEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'The email field is required'**
  String get forgotPasswordEmailRequired;

  /// No description provided for @forgotPasswordSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Verify OTP'**
  String get forgotPasswordSendButton;

  /// No description provided for @forgotPasswordGoBackButton.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get forgotPasswordGoBackButton;

  /// No description provided for @comment_reset_password_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Reset Password Screen ===='**
  String get comment_reset_password_screen;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get resetPasswordPasswordLabel;

  /// No description provided for @resetPasswordConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get resetPasswordConfirmPasswordLabel;

  /// No description provided for @resetPasswordPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get resetPasswordPasswordRequired;

  /// No description provided for @resetPasswordPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get resetPasswordPasswordLength;

  /// No description provided for @resetPasswordConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get resetPasswordConfirmPasswordRequired;

  /// No description provided for @resetPasswordPasswordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get resetPasswordPasswordsDontMatch;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetPasswordButton;

  /// No description provided for @resetPasswordAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get resetPasswordAlreadyHaveAccount;

  /// No description provided for @resetPasswordLoginLink.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get resetPasswordLoginLink;

  /// No description provided for @comment_forgot_password_pin_verification_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Forgot Password Pin Verification Screen ===='**
  String get comment_forgot_password_pin_verification_screen;

  /// No description provided for @forgotPasswordPinVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get forgotPasswordPinVerificationTitle;

  /// No description provided for @forgotPasswordPinVerificationEnterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get forgotPasswordPinVerificationEnterOtp;

  /// No description provided for @forgotPasswordPinVerificationOtpSentTo.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to'**
  String get forgotPasswordPinVerificationOtpSentTo;

  /// No description provided for @forgotPasswordPinVerificationOtpCountdown.
  ///
  /// In en, this message translates to:
  /// **'OTP in 00:{countdown}'**
  String forgotPasswordPinVerificationOtpCountdown(Object countdown);

  /// No description provided for @forgotPasswordPinVerificationOtpRequired.
  ///
  /// In en, this message translates to:
  /// **'The otp field is required'**
  String get forgotPasswordPinVerificationOtpRequired;

  /// No description provided for @forgotPasswordPinVerificationVerifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get forgotPasswordPinVerificationVerifyButton;

  /// No description provided for @forgotPasswordPinVerificationDidNotReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get forgotPasswordPinVerificationDidNotReceive;

  /// No description provided for @forgotPasswordPinVerificationResend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get forgotPasswordPinVerificationResend;

  /// No description provided for @comment_login_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Login Screen ===='**
  String get comment_login_screen;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Merchant Login'**
  String get loginTitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'The email field is required'**
  String get loginEmailRequired;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'The password field is required'**
  String get loginPasswordRequired;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get loginForgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginDontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get loginDontHaveAccount;

  /// No description provided for @loginCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create one'**
  String get loginCreateAccount;

  /// No description provided for @loginFirstSignInRequired.
  ///
  /// In en, this message translates to:
  /// **'First Sign In with Email and Password'**
  String get loginFirstSignInRequired;

  /// No description provided for @loginBiometricNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'Your biometric is not enabled'**
  String get loginBiometricNotEnabled;

  /// No description provided for @comment_two_factor_auth_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Two Factor Auth Screen ===='**
  String get comment_two_factor_auth_screen;

  /// No description provided for @twoFactorAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Two FA'**
  String get twoFactorAuthTitle;

  /// No description provided for @twoFactorAuthEnterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get twoFactorAuthEnterOtp;

  /// No description provided for @twoFactorAuthOtpRequired.
  ///
  /// In en, this message translates to:
  /// **'The otp field is required'**
  String get twoFactorAuthOtpRequired;

  /// No description provided for @twoFactorAuthVerifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get twoFactorAuthVerifyButton;

  /// No description provided for @twoFactorAuthBackToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to? '**
  String get twoFactorAuthBackToLogin;

  /// No description provided for @twoFactorAuthLoginLink.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get twoFactorAuthLoginLink;

  /// No description provided for @comment_auth_id_verification_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Auth ID Verification Screen ===='**
  String get comment_auth_id_verification_screen;

  /// No description provided for @authIdVerificationInvalidType.
  ///
  /// In en, this message translates to:
  /// **'Invalid field type'**
  String get authIdVerificationInvalidType;

  /// No description provided for @authIdVerificationUnknownType.
  ///
  /// In en, this message translates to:
  /// **'Unknown field type: {fieldType}'**
  String authIdVerificationUnknownType(Object fieldType);

  /// No description provided for @comment_email_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Email Screen ===='**
  String get comment_email_screen;

  /// No description provided for @emailTitle.
  ///
  /// In en, this message translates to:
  /// **'Merchant Register'**
  String get emailTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an email'**
  String get emailRequired;

  /// No description provided for @emailContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get emailContinueButton;

  /// No description provided for @emailAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get emailAlreadyHaveAccount;

  /// No description provided for @emailLoginLink.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get emailLoginLink;

  /// No description provided for @comment_personal_info_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Personal Info Screen ===='**
  String get comment_personal_info_screen;

  /// No description provided for @personalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Merchant Register'**
  String get personalInfoTitle;

  /// No description provided for @personalInfoSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get personalInfoSectionTitle;

  /// No description provided for @personalInfoFirstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get personalInfoFirstNameLabel;

  /// No description provided for @personalInfoLastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get personalInfoLastNameLabel;

  /// No description provided for @personalInfoUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get personalInfoUsernameLabel;

  /// No description provided for @personalInfoCountryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get personalInfoCountryLabel;

  /// No description provided for @personalInfoPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone No'**
  String get personalInfoPhoneLabel;

  /// No description provided for @personalInfoGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get personalInfoGenderLabel;

  /// No description provided for @personalInfoSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get personalInfoSubmitButton;

  /// No description provided for @personalInfoFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get personalInfoFirstNameRequired;

  /// No description provided for @personalInfoLastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get personalInfoLastNameRequired;

  /// No description provided for @personalInfoUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get personalInfoUsernameRequired;

  /// No description provided for @personalInfoCountryRequired.
  ///
  /// In en, this message translates to:
  /// **'Country is required'**
  String get personalInfoCountryRequired;

  /// No description provided for @personalInfoPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get personalInfoPhoneRequired;

  /// No description provided for @personalInfoGenderRequired.
  ///
  /// In en, this message translates to:
  /// **'Gender is required'**
  String get personalInfoGenderRequired;

  /// No description provided for @personalInfoSelectCountryTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get personalInfoSelectCountryTitle;

  /// No description provided for @personalInfoSelectGenderTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get personalInfoSelectGenderTitle;

  /// No description provided for @personalInfoCountryNotFound.
  ///
  /// In en, this message translates to:
  /// **'No Country Found'**
  String get personalInfoCountryNotFound;

  /// No description provided for @personalInfoGenderNotFound.
  ///
  /// In en, this message translates to:
  /// **'No Gender Found'**
  String get personalInfoGenderNotFound;

  /// No description provided for @comment_set_up_password_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Set Up Password Screen ===='**
  String get comment_set_up_password_screen;

  /// No description provided for @setUpPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Merchant Register'**
  String get setUpPasswordTitle;

  /// No description provided for @setUpPasswordSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Setup Password'**
  String get setUpPasswordSectionTitle;

  /// No description provided for @setUpPasswordPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get setUpPasswordPasswordLabel;

  /// No description provided for @setUpPasswordConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get setUpPasswordConfirmPasswordLabel;

  /// No description provided for @setUpPasswordAgreementText.
  ///
  /// In en, this message translates to:
  /// **'I agree with the '**
  String get setUpPasswordAgreementText;

  /// No description provided for @setUpPasswordTermsLink.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get setUpPasswordTermsLink;

  /// No description provided for @setUpPasswordSetupButton.
  ///
  /// In en, this message translates to:
  /// **'Setup Password'**
  String get setUpPasswordSetupButton;

  /// No description provided for @setUpPasswordPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get setUpPasswordPasswordRequired;

  /// No description provided for @setUpPasswordPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get setUpPasswordPasswordLength;

  /// No description provided for @setUpPasswordConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get setUpPasswordConfirmPasswordRequired;

  /// No description provided for @setUpPasswordPasswordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get setUpPasswordPasswordsDontMatch;

  /// No description provided for @setUpPasswordAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'Please accept terms and conditions'**
  String get setUpPasswordAcceptTerms;

  /// No description provided for @comment_sign_up_status_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Sign Up Status Screen ===='**
  String get comment_sign_up_status_screen;

  /// No description provided for @signUpStatusCurrentStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Current Status'**
  String get signUpStatusCurrentStatusTitle;

  /// No description provided for @signUpStatusSetupNextStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s set up your next step'**
  String get signUpStatusSetupNextStepTitle;

  /// No description provided for @signUpStatusStepEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signUpStatusStepEmail;

  /// No description provided for @signUpStatusStepSetupPassword.
  ///
  /// In en, this message translates to:
  /// **'Setup Password'**
  String get signUpStatusStepSetupPassword;

  /// No description provided for @signUpStatusStepPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get signUpStatusStepPersonalInfo;

  /// No description provided for @signUpStatusStepIdVerification.
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get signUpStatusStepIdVerification;

  /// No description provided for @signUpStatusStatusInReview.
  ///
  /// In en, this message translates to:
  /// **'In Review'**
  String get signUpStatusStatusInReview;

  /// No description provided for @signUpStatusStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get signUpStatusStatusRejected;

  /// No description provided for @signUpStatusNoReasonProvided.
  ///
  /// In en, this message translates to:
  /// **'No reason provided'**
  String get signUpStatusNoReasonProvided;

  /// No description provided for @signUpStatusNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get signUpStatusNextButton;

  /// No description provided for @signUpStatusSubmitAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Again'**
  String get signUpStatusSubmitAgainButton;

  /// No description provided for @signUpStatusDashboardButton.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get signUpStatusDashboardButton;

  /// No description provided for @signUpStatusBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get signUpStatusBackButton;

  /// No description provided for @signUpStatusErrorProcessingStep.
  ///
  /// In en, this message translates to:
  /// **'Error processing next step. Please try again.'**
  String get signUpStatusErrorProcessingStep;

  /// No description provided for @comment_verify_email_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Verify Email Screen ===='**
  String get comment_verify_email_screen;

  /// No description provided for @verifyEmailMerchantRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Merchant Register'**
  String get verifyEmailMerchantRegisterTitle;

  /// No description provided for @verifyEmailVerifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmailVerifyEmailTitle;

  /// No description provided for @verifyEmailOtpSentTo.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to'**
  String get verifyEmailOtpSentTo;

  /// No description provided for @verifyEmailResendAvailableIn.
  ///
  /// In en, this message translates to:
  /// **'Resend available in'**
  String get verifyEmailResendAvailableIn;

  /// No description provided for @verifyEmailRequestNewOtp.
  ///
  /// In en, this message translates to:
  /// **'You can request a new OTP now'**
  String get verifyEmailRequestNewOtp;

  /// No description provided for @verifyEmailContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get verifyEmailContinueButton;

  /// No description provided for @verifyEmailOtpRequiredError.
  ///
  /// In en, this message translates to:
  /// **'The otp field is required'**
  String get verifyEmailOtpRequiredError;

  /// No description provided for @verifyEmailDidntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get verifyEmailDidntReceiveCode;

  /// No description provided for @verifyEmailResendText.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get verifyEmailResendText;

  /// No description provided for @comment_welcome_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Welcome Screen ===='**
  String get comment_welcome_screen;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Merchant'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage payments, track sales, and grow your business'**
  String get welcomeSubtitle;

  /// No description provided for @welcomeCreateAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get welcomeCreateAccountButton;

  /// No description provided for @welcomeLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get welcomeLoginButton;

  /// No description provided for @welcomeExitApplicationTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit Application'**
  String get welcomeExitApplicationTitle;

  /// No description provided for @welcomeExitApplicationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the application?'**
  String get welcomeExitApplicationMessage;

  /// No description provided for @comment_change_password_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Change Password Controller Messages ===='**
  String get comment_change_password_controller;

  /// No description provided for @changePasswordCurrentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password'**
  String get changePasswordCurrentPasswordRequired;

  /// No description provided for @changePasswordNewPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password'**
  String get changePasswordNewPasswordRequired;

  /// No description provided for @changePasswordPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get changePasswordPasswordLength;

  /// No description provided for @changePasswordConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your new password'**
  String get changePasswordConfirmPasswordRequired;

  /// No description provided for @changePasswordPasswordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get changePasswordPasswordsDontMatch;

  /// No description provided for @comment_change_password_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Change Password Screen ===='**
  String get comment_change_password_screen;

  /// No description provided for @changePasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordScreenTitle;

  /// No description provided for @changePasswordCurrentPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get changePasswordCurrentPasswordLabel;

  /// No description provided for @changePasswordNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get changePasswordNewPasswordLabel;

  /// No description provided for @changePasswordConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get changePasswordConfirmPasswordLabel;

  /// No description provided for @changePasswordSaveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get changePasswordSaveChangesButton;

  /// No description provided for @comment_exchange_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Controller Messages ===='**
  String get comment_exchange_controller;

  /// No description provided for @exchangeSelectFromWalletError.
  ///
  /// In en, this message translates to:
  /// **'Please select a from wallet'**
  String get exchangeSelectFromWalletError;

  /// No description provided for @exchangeSelectToWalletError.
  ///
  /// In en, this message translates to:
  /// **'Please select a to wallet'**
  String get exchangeSelectToWalletError;

  /// No description provided for @exchangeEnterAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get exchangeEnterAmountError;

  /// No description provided for @exchangeMinAmountError.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount should be'**
  String get exchangeMinAmountError;

  /// No description provided for @exchangeMaxAmountError.
  ///
  /// In en, this message translates to:
  /// **'Maximum amount should be'**
  String get exchangeMaxAmountError;

  /// No description provided for @comment_exchange_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Screen ===='**
  String get comment_exchange_screen;

  /// No description provided for @exchangeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get exchangeScreenTitle;

  /// No description provided for @comment_exchange_amount_step_section.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Amount Step Section ===='**
  String get comment_exchange_amount_step_section;

  /// No description provided for @exchangeFromWalletLabel.
  ///
  /// In en, this message translates to:
  /// **'From Wallet'**
  String get exchangeFromWalletLabel;

  /// No description provided for @exchangeSelectFromWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Select From Wallet'**
  String get exchangeSelectFromWalletTitle;

  /// No description provided for @exchangeFromWalletsNotFound.
  ///
  /// In en, this message translates to:
  /// **'From Wallets Not Found'**
  String get exchangeFromWalletsNotFound;

  /// No description provided for @exchangeToWalletLabel.
  ///
  /// In en, this message translates to:
  /// **'To Wallet'**
  String get exchangeToWalletLabel;

  /// No description provided for @exchangeSelectToWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Select To Wallet'**
  String get exchangeSelectToWalletTitle;

  /// No description provided for @exchangeToWalletsNotFound.
  ///
  /// In en, this message translates to:
  /// **'To Wallets Not Found'**
  String get exchangeToWalletsNotFound;

  /// No description provided for @exchangeAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get exchangeAmountLabel;

  /// No description provided for @exchangeMinMaxLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum {min} {currency} and Maximum {max} {currency}'**
  String exchangeMinMaxLabel(Object currency, Object max, Object min);

  /// No description provided for @exchangeRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate:'**
  String get exchangeRateLabel;

  /// No description provided for @exchangeButton.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get exchangeButton;

  /// No description provided for @comment_exchange_review_step_section.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Review Step Section ===='**
  String get comment_exchange_review_step_section;

  /// No description provided for @exchangeReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Exchange Review'**
  String get exchangeReviewTitle;

  /// No description provided for @exchangeReviewAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get exchangeReviewAmount;

  /// No description provided for @exchangeReviewFromWallet.
  ///
  /// In en, this message translates to:
  /// **'From Wallet'**
  String get exchangeReviewFromWallet;

  /// No description provided for @exchangeReviewCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get exchangeReviewCharge;

  /// No description provided for @exchangeReviewTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get exchangeReviewTotalAmount;

  /// No description provided for @exchangeReviewToWallet.
  ///
  /// In en, this message translates to:
  /// **'To Wallet'**
  String get exchangeReviewToWallet;

  /// No description provided for @exchangeReviewExchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate'**
  String get exchangeReviewExchangeRate;

  /// No description provided for @exchangeReviewExchangeAmount.
  ///
  /// In en, this message translates to:
  /// **'Exchange Amount'**
  String get exchangeReviewExchangeAmount;

  /// No description provided for @exchangeReviewExchangeNowButton.
  ///
  /// In en, this message translates to:
  /// **'Exchange Now'**
  String get exchangeReviewExchangeNowButton;

  /// No description provided for @comment_exchange_success_step_section.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Success Step Section ===='**
  String get comment_exchange_success_step_section;

  /// No description provided for @exchangeSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Exchange Success'**
  String get exchangeSuccessTitle;

  /// No description provided for @exchangeSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your exchange have been successfully'**
  String get exchangeSuccessSubtitle;

  /// No description provided for @exchangeSuccessAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get exchangeSuccessAmount;

  /// No description provided for @exchangeSuccessTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get exchangeSuccessTransactionId;

  /// No description provided for @exchangeSuccessConvertedAmount.
  ///
  /// In en, this message translates to:
  /// **'Converted Amount'**
  String get exchangeSuccessConvertedAmount;

  /// No description provided for @exchangeSuccessCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get exchangeSuccessCharge;

  /// No description provided for @exchangeSuccessDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get exchangeSuccessDate;

  /// No description provided for @exchangeSuccessFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Amount'**
  String get exchangeSuccessFinalAmount;

  /// No description provided for @exchangeSuccessBackHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Back Home'**
  String get exchangeSuccessBackHomeButton;

  /// No description provided for @exchangeSuccessExchangeAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Exchange Again'**
  String get exchangeSuccessExchangeAgainButton;

  /// No description provided for @comment_home_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Home Controller Messages ===='**
  String get comment_home_controller;

  /// No description provided for @homeBiometricNotSupported.
  ///
  /// In en, this message translates to:
  /// **'This device does not support biometrics.'**
  String get homeBiometricNotSupported;

  /// No description provided for @homeBiometricEnabledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Biometric enabled successfully'**
  String get homeBiometricEnabledSuccess;

  /// No description provided for @homeBiometricDisabledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Biometric disabled successfully'**
  String get homeBiometricDisabledSuccess;

  /// No description provided for @homeBiometricAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Biometric setting not changed.'**
  String get homeBiometricAuthFailed;

  /// No description provided for @homeBiometricNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric Not Found'**
  String get homeBiometricNotFoundTitle;

  /// No description provided for @homeBiometricNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'No fingerprint or biometric is enrolled on this device. You can set it up from the system settings.'**
  String get homeBiometricNotFoundMessage;

  /// No description provided for @homeOpenSecuritySettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open Security Settings'**
  String get homeOpenSecuritySettingsButton;

  /// No description provided for @homeIosBiometricMessage.
  ///
  /// In en, this message translates to:
  /// **'Please go to Settings > Face ID & Passcode to set up biometrics.'**
  String get homeIosBiometricMessage;

  /// No description provided for @comment_drawer_section.
  ///
  /// In en, this message translates to:
  /// **'==== Drawer Section ===='**
  String get comment_drawer_section;

  /// No description provided for @drawerDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get drawerDashboard;

  /// No description provided for @drawerMyWallets.
  ///
  /// In en, this message translates to:
  /// **'My Wallets'**
  String get drawerMyWallets;

  /// No description provided for @drawerQrCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get drawerQrCode;

  /// No description provided for @drawerExchange.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get drawerExchange;

  /// No description provided for @drawerApiAccessKey.
  ///
  /// In en, this message translates to:
  /// **'API Access Key'**
  String get drawerApiAccessKey;

  /// No description provided for @drawerTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get drawerTransactions;

  /// No description provided for @drawerWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get drawerWithdraw;

  /// No description provided for @drawerInvoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get drawerInvoice;

  /// No description provided for @drawerNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get drawerNotifications;

  /// No description provided for @drawerSupportTicket.
  ///
  /// In en, this message translates to:
  /// **'Support Ticket'**
  String get drawerSupportTicket;

  /// No description provided for @comment_home_header_section.
  ///
  /// In en, this message translates to:
  /// **'==== Home Header Section ===='**
  String get comment_home_header_section;

  /// No description provided for @homeHeaderAccountNumberCopied.
  ///
  /// In en, this message translates to:
  /// **'Account Number Copied'**
  String get homeHeaderAccountNumberCopied;

  /// No description provided for @homeHeaderMerchantIdPrefix.
  ///
  /// In en, this message translates to:
  /// **'MID:'**
  String get homeHeaderMerchantIdPrefix;

  /// No description provided for @comment_home_section_navigator.
  ///
  /// In en, this message translates to:
  /// **'==== Home Section Navigator ===='**
  String get comment_home_section_navigator;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// No description provided for @comment_home_transaction_details.
  ///
  /// In en, this message translates to:
  /// **'==== Home Transaction Details ===='**
  String get comment_home_transaction_details;

  /// No description provided for @transactionDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetailsTitle;

  /// No description provided for @transactionDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get transactionDescription;

  /// No description provided for @transactionWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get transactionWallet;

  /// No description provided for @transactionCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get transactionCharge;

  /// No description provided for @transactionTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionTransactionId;

  /// No description provided for @transactionMethod.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get transactionMethod;

  /// No description provided for @transactionTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get transactionTotalAmount;

  /// No description provided for @transactionStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get transactionStatus;

  /// No description provided for @comment_home_transactions_section.
  ///
  /// In en, this message translates to:
  /// **'==== Home Transactions Section ===='**
  String get comment_home_transactions_section;

  /// No description provided for @homeRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get homeRecentTransactions;

  /// No description provided for @comment_home_wallets_section.
  ///
  /// In en, this message translates to:
  /// **'==== Home Wallets Section ===='**
  String get comment_home_wallets_section;

  /// No description provided for @homeMyWallets.
  ///
  /// In en, this message translates to:
  /// **'My Wallets'**
  String get homeMyWallets;

  /// No description provided for @homeNoWalletsFound.
  ///
  /// In en, this message translates to:
  /// **'No wallets found'**
  String get homeNoWalletsFound;

  /// No description provided for @homeWalletWithdrawButton.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get homeWalletWithdrawButton;

  /// No description provided for @comment_settings_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Settings Bottom Sheet ===='**
  String get comment_settings_bottom_sheet;

  /// No description provided for @settingsProfileSetting.
  ///
  /// In en, this message translates to:
  /// **'Profile Setting'**
  String get settingsProfileSetting;

  /// No description provided for @settingsChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get settingsChangePassword;

  /// No description provided for @settingsIdVerification.
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get settingsIdVerification;

  /// No description provided for @settingsTwoFa.
  ///
  /// In en, this message translates to:
  /// **'2FA'**
  String get settingsTwoFa;

  /// No description provided for @settingsSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupport;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogout;

  /// No description provided for @comment_kyc_details_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== KYC Details Bottom Sheet ===='**
  String get comment_kyc_details_bottom_sheet;

  /// No description provided for @kycDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'KYC Details'**
  String get kycDetailsTitle;

  /// No description provided for @kycDetailsStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status:'**
  String get kycDetailsStatusLabel;

  /// No description provided for @kycDetailsStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get kycDetailsStatusPending;

  /// No description provided for @kycDetailsStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get kycDetailsStatusApproved;

  /// No description provided for @kycDetailsStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get kycDetailsStatusRejected;

  /// No description provided for @kycDetailsCreatedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Created At:'**
  String get kycDetailsCreatedAtLabel;

  /// No description provided for @kycDetailsMessageFromAdmin.
  ///
  /// In en, this message translates to:
  /// **'Message From Admin:'**
  String get kycDetailsMessageFromAdmin;

  /// No description provided for @kycDetailsSubmittedData.
  ///
  /// In en, this message translates to:
  /// **'Submitted Data'**
  String get kycDetailsSubmittedData;

  /// No description provided for @comment_kyc_history_screen.
  ///
  /// In en, this message translates to:
  /// **'==== KYC History Screen ===='**
  String get comment_kyc_history_screen;

  /// No description provided for @kycHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'KYC History'**
  String get kycHistoryTitle;

  /// No description provided for @kycHistoryDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get kycHistoryDateLabel;

  /// No description provided for @kycHistoryStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get kycHistoryStatusLabel;

  /// No description provided for @kycHistoryStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get kycHistoryStatusPending;

  /// No description provided for @kycHistoryStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get kycHistoryStatusApproved;

  /// No description provided for @kycHistoryStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get kycHistoryStatusRejected;

  /// No description provided for @kycHistoryViewButton.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get kycHistoryViewButton;

  /// No description provided for @comment_id_verification_screen.
  ///
  /// In en, this message translates to:
  /// **'==== ID Verification Screen ===='**
  String get comment_id_verification_screen;

  /// No description provided for @idVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get idVerificationTitle;

  /// No description provided for @idVerificationHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get idVerificationHistory;

  /// No description provided for @idVerificationVerificationCenter.
  ///
  /// In en, this message translates to:
  /// **'Verification Center'**
  String get idVerificationVerificationCenter;

  /// No description provided for @idVerificationNothingToSubmit.
  ///
  /// In en, this message translates to:
  /// **'You have nothing to submit'**
  String get idVerificationNothingToSubmit;

  /// No description provided for @idVerificationStatus1Message.
  ///
  /// In en, this message translates to:
  /// **'You have submitted your documents and it is verified'**
  String get idVerificationStatus1Message;

  /// No description provided for @idVerificationStatus2Message.
  ///
  /// In en, this message translates to:
  /// **'You have submitted your documents and it is awaiting for the approval'**
  String get idVerificationStatus2Message;

  /// No description provided for @idVerificationStatus3Message.
  ///
  /// In en, this message translates to:
  /// **'Your KYC verification has failed. Please resubmit the documents.'**
  String get idVerificationStatus3Message;

  /// No description provided for @idVerificationStatus4Message.
  ///
  /// In en, this message translates to:
  /// **'You have not submitted any KYC documents yet'**
  String get idVerificationStatus4Message;

  /// No description provided for @comment_create_invoice_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Create Invoice Controller Messages ===='**
  String get comment_create_invoice_controller;

  /// No description provided for @createInvoiceInvoiceToRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an invoice to'**
  String get createInvoiceInvoiceToRequired;

  /// No description provided for @createInvoiceEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an email address'**
  String get createInvoiceEmailRequired;

  /// No description provided for @createInvoiceAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an address'**
  String get createInvoiceAddressRequired;

  /// No description provided for @createInvoiceWalletRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a wallet'**
  String get createInvoiceWalletRequired;

  /// No description provided for @createInvoiceStatusRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a status'**
  String get createInvoiceStatusRequired;

  /// No description provided for @createInvoiceIssueDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select an issue date'**
  String get createInvoiceIssueDateRequired;

  /// No description provided for @createInvoiceItemNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Item {number}: Name is required'**
  String createInvoiceItemNameRequired(Object number);

  /// No description provided for @createInvoiceItemQuantityRequired.
  ///
  /// In en, this message translates to:
  /// **'Item {number}: Quantity must be greater than 0'**
  String createInvoiceItemQuantityRequired(Object number);

  /// No description provided for @createInvoiceItemUnitPriceRequired.
  ///
  /// In en, this message translates to:
  /// **'Item {number}: Unit Price must be greater than 0'**
  String createInvoiceItemUnitPriceRequired(Object number);

  /// No description provided for @createInvoiceSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get createInvoiceSomethingWentWrong;

  /// No description provided for @comment_create_invoice_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Create Invoice Screen ===='**
  String get comment_create_invoice_screen;

  /// No description provided for @createInvoiceScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Invoice'**
  String get createInvoiceScreenTitle;

  /// No description provided for @createInvoiceScreenInvoiceItems.
  ///
  /// In en, this message translates to:
  /// **'Invoice Items'**
  String get createInvoiceScreenInvoiceItems;

  /// No description provided for @createInvoiceScreenAddItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get createInvoiceScreenAddItem;

  /// No description provided for @createInvoiceScreenCreateInvoiceButton.
  ///
  /// In en, this message translates to:
  /// **'Create Invoice'**
  String get createInvoiceScreenCreateInvoiceButton;

  /// No description provided for @comment_create_invoice_add_item_section.
  ///
  /// In en, this message translates to:
  /// **'==== Create Invoice Add Item Section ===='**
  String get comment_create_invoice_add_item_section;

  /// No description provided for @createInvoiceAddItemItemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get createInvoiceAddItemItemName;

  /// No description provided for @createInvoiceAddItemQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get createInvoiceAddItemQuantity;

  /// No description provided for @createInvoiceAddItemUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get createInvoiceAddItemUnitPrice;

  /// No description provided for @createInvoiceAddItemSubTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get createInvoiceAddItemSubTotal;

  /// No description provided for @comment_create_invoice_information_section.
  ///
  /// In en, this message translates to:
  /// **'==== Create Invoice Information Section ===='**
  String get comment_create_invoice_information_section;

  /// No description provided for @createInvoiceInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Information'**
  String get createInvoiceInformationTitle;

  /// No description provided for @createInvoiceInformationInvoiceTo.
  ///
  /// In en, this message translates to:
  /// **'Invoice To'**
  String get createInvoiceInformationInvoiceTo;

  /// No description provided for @createInvoiceInformationEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get createInvoiceInformationEmailAddress;

  /// No description provided for @createInvoiceInformationAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get createInvoiceInformationAddress;

  /// No description provided for @createInvoiceInformationSelectWallet.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get createInvoiceInformationSelectWallet;

  /// No description provided for @createInvoiceInformationStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get createInvoiceInformationStatus;

  /// No description provided for @createInvoiceInformationIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get createInvoiceInformationIssueDate;

  /// No description provided for @createInvoiceInformationSelectWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get createInvoiceInformationSelectWalletTitle;

  /// No description provided for @createInvoiceInformationWalletsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallets Not Found'**
  String get createInvoiceInformationWalletsNotFound;

  /// No description provided for @createInvoiceInformationSelectStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Status'**
  String get createInvoiceInformationSelectStatusTitle;

  /// No description provided for @createInvoiceInformationStatusNotFound.
  ///
  /// In en, this message translates to:
  /// **'Status Not Found'**
  String get createInvoiceInformationStatusNotFound;

  /// No description provided for @comment_invoice_details_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Invoice Details Screen ===='**
  String get comment_invoice_details_screen;

  /// No description provided for @invoiceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoiceDetailsTitle;

  /// No description provided for @invoiceDetailsRefNumber.
  ///
  /// In en, this message translates to:
  /// **'Ref: #{number}'**
  String invoiceDetailsRefNumber(Object number);

  /// No description provided for @invoiceDetailsIssuedDate.
  ///
  /// In en, this message translates to:
  /// **'Issued: {date}'**
  String invoiceDetailsIssuedDate(Object date);

  /// No description provided for @invoiceDetailsName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get invoiceDetailsName;

  /// No description provided for @invoiceDetailsEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get invoiceDetailsEmail;

  /// No description provided for @invoiceDetailsCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get invoiceDetailsCharge;

  /// No description provided for @invoiceDetailsAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get invoiceDetailsAddress;

  /// No description provided for @invoiceDetailsTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get invoiceDetailsTotalAmount;

  /// No description provided for @invoiceDetailsStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get invoiceDetailsStatus;

  /// No description provided for @invoiceDetailsItemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get invoiceDetailsItemName;

  /// No description provided for @invoiceDetailsQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get invoiceDetailsQuantity;

  /// No description provided for @invoiceDetailsUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get invoiceDetailsUnitPrice;

  /// No description provided for @invoiceDetailsSubTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get invoiceDetailsSubTotal;

  /// No description provided for @invoiceDetailsPayNowButton.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get invoiceDetailsPayNowButton;

  /// No description provided for @invoiceDetailsPrintInvoiceButton.
  ///
  /// In en, this message translates to:
  /// **'Print Invoice'**
  String get invoiceDetailsPrintInvoiceButton;

  /// No description provided for @comment_invoice_pdf.
  ///
  /// In en, this message translates to:
  /// **'==== Invoice PDF Generator ===='**
  String get comment_invoice_pdf;

  /// No description provided for @invoicePdfRefNumber.
  ///
  /// In en, this message translates to:
  /// **'Ref: #{number}'**
  String invoicePdfRefNumber(Object number);

  /// No description provided for @invoicePdfIssuedDate.
  ///
  /// In en, this message translates to:
  /// **'Issued: {date}'**
  String invoicePdfIssuedDate(Object date);

  /// No description provided for @invoicePdfTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount:'**
  String get invoicePdfTotalAmount;

  /// No description provided for @invoicePdfAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount:'**
  String get invoicePdfAmount;

  /// No description provided for @invoicePdfCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge:'**
  String get invoicePdfCharge;

  /// No description provided for @invoicePdfItemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get invoicePdfItemName;

  /// No description provided for @invoicePdfQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get invoicePdfQuantity;

  /// No description provided for @invoicePdfUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get invoicePdfUnitPrice;

  /// No description provided for @invoicePdfSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get invoicePdfSubtotal;

  /// No description provided for @invoicePdfSubtotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Subtotal: '**
  String get invoicePdfSubtotalLabel;

  /// No description provided for @invoicePdfChargeLabel.
  ///
  /// In en, this message translates to:
  /// **'Charge: '**
  String get invoicePdfChargeLabel;

  /// No description provided for @invoicePdfTotalAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Amount: '**
  String get invoicePdfTotalAmountLabel;

  /// No description provided for @invoicePdfThanksMessage.
  ///
  /// In en, this message translates to:
  /// **'Thanks for the purchase.'**
  String get invoicePdfThanksMessage;

  /// No description provided for @comment_update_invoice_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Update Invoice Screen ===='**
  String get comment_update_invoice_screen;

  /// No description provided for @updateInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Invoice'**
  String get updateInvoiceTitle;

  /// No description provided for @updateInvoiceInvoiceItems.
  ///
  /// In en, this message translates to:
  /// **'Invoice Items'**
  String get updateInvoiceInvoiceItems;

  /// No description provided for @updateInvoiceAddItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get updateInvoiceAddItem;

  /// No description provided for @updateInvoiceUpdateInvoiceButton.
  ///
  /// In en, this message translates to:
  /// **'Update Invoice'**
  String get updateInvoiceUpdateInvoiceButton;

  /// No description provided for @comment_update_invoice_add_item_section.
  ///
  /// In en, this message translates to:
  /// **'==== Update Invoice Add Item Section ===='**
  String get comment_update_invoice_add_item_section;

  /// No description provided for @updateInvoiceAddItemItemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get updateInvoiceAddItemItemName;

  /// No description provided for @updateInvoiceAddItemQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get updateInvoiceAddItemQuantity;

  /// No description provided for @updateInvoiceAddItemUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get updateInvoiceAddItemUnitPrice;

  /// No description provided for @updateInvoiceAddItemSubTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get updateInvoiceAddItemSubTotal;

  /// No description provided for @comment_update_invoice_information_section.
  ///
  /// In en, this message translates to:
  /// **'==== Update Invoice Information Section ===='**
  String get comment_update_invoice_information_section;

  /// No description provided for @updateInvoiceInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Information'**
  String get updateInvoiceInformationTitle;

  /// No description provided for @updateInvoiceInformationInvoiceTo.
  ///
  /// In en, this message translates to:
  /// **'Invoice To'**
  String get updateInvoiceInformationInvoiceTo;

  /// No description provided for @updateInvoiceInformationEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get updateInvoiceInformationEmailAddress;

  /// No description provided for @updateInvoiceInformationAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get updateInvoiceInformationAddress;

  /// No description provided for @updateInvoiceInformationSelectWallet.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get updateInvoiceInformationSelectWallet;

  /// No description provided for @updateInvoiceInformationStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get updateInvoiceInformationStatus;

  /// No description provided for @updateInvoiceInformationIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get updateInvoiceInformationIssueDate;

  /// No description provided for @updateInvoiceInformationPaymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get updateInvoiceInformationPaymentStatus;

  /// No description provided for @updateInvoiceInformationSelectWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get updateInvoiceInformationSelectWalletTitle;

  /// No description provided for @updateInvoiceInformationWalletsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallets Not Found'**
  String get updateInvoiceInformationWalletsNotFound;

  /// No description provided for @updateInvoiceInformationSelectStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Status'**
  String get updateInvoiceInformationSelectStatusTitle;

  /// No description provided for @updateInvoiceInformationStatusNotFound.
  ///
  /// In en, this message translates to:
  /// **'Status Not Found'**
  String get updateInvoiceInformationStatusNotFound;

  /// No description provided for @updateInvoiceInformationSelectPaymentStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Status'**
  String get updateInvoiceInformationSelectPaymentStatusTitle;

  /// No description provided for @updateInvoiceInformationPaymentStatusNotFound.
  ///
  /// In en, this message translates to:
  /// **'Payment status not found'**
  String get updateInvoiceInformationPaymentStatusNotFound;

  /// No description provided for @comment_invoice_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Invoice Screen ===='**
  String get comment_invoice_screen;

  /// No description provided for @invoiceScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoiceScreenTitle;

  /// No description provided for @invoiceScreenCreateInvoice.
  ///
  /// In en, this message translates to:
  /// **'Create Invoice'**
  String get invoiceScreenCreateInvoice;

  /// No description provided for @invoiceScreenAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount:'**
  String get invoiceScreenAmountLabel;

  /// No description provided for @invoiceScreenChargeLabel.
  ///
  /// In en, this message translates to:
  /// **'Charge:'**
  String get invoiceScreenChargeLabel;

  /// No description provided for @invoiceScreenStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get invoiceScreenStatusLabel;

  /// No description provided for @invoiceScreenViewButton.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get invoiceScreenViewButton;

  /// No description provided for @comment_notification_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Notification Screen ===='**
  String get comment_notification_screen;

  /// No description provided for @notificationScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationScreenTitle;

  /// No description provided for @notificationScreenMarkAll.
  ///
  /// In en, this message translates to:
  /// **'Mark All'**
  String get notificationScreenMarkAll;

  /// No description provided for @comment_profile_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Profile Screen ===='**
  String get comment_profile_screen;

  /// No description provided for @profileScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileScreenTitle;

  /// No description provided for @profileScreenProfileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileScreenProfileSettings;

  /// No description provided for @profileScreenChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileScreenChangePassword;

  /// No description provided for @profileScreenLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileScreenLanguage;

  /// No description provided for @profileScreenBiometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric'**
  String get profileScreenBiometric;

  /// No description provided for @profileScreenLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profileScreenLogout;

  /// No description provided for @profileScreenBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get profileScreenBackButton;

  /// No description provided for @profileScreenSelectLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get profileScreenSelectLanguageTitle;

  /// No description provided for @comment_profile_settings_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Profile Settings Screen ===='**
  String get comment_profile_settings_screen;

  /// No description provided for @profileSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileSettingsTitle;

  /// No description provided for @profileSettingsFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get profileSettingsFirstName;

  /// No description provided for @profileSettingsLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get profileSettingsLastName;

  /// No description provided for @profileSettingsUserName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get profileSettingsUserName;

  /// No description provided for @profileSettingsGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profileSettingsGender;

  /// No description provided for @profileSettingsDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get profileSettingsDateOfBirth;

  /// No description provided for @profileSettingsEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get profileSettingsEmailAddress;

  /// No description provided for @profileSettingsPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get profileSettingsPhone;

  /// No description provided for @profileSettingsCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get profileSettingsCountry;

  /// No description provided for @profileSettingsCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get profileSettingsCity;

  /// No description provided for @profileSettingsZipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get profileSettingsZipCode;

  /// No description provided for @profileSettingsJoiningDate.
  ///
  /// In en, this message translates to:
  /// **'Joining Date'**
  String get profileSettingsJoiningDate;

  /// No description provided for @profileSettingsAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get profileSettingsAddress;

  /// No description provided for @profileSettingsSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get profileSettingsSaveChanges;

  /// No description provided for @profileSettingsSelectGenderTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get profileSettingsSelectGenderTitle;

  /// No description provided for @profileSettingsNoGenderFound.
  ///
  /// In en, this message translates to:
  /// **'No Gender Found'**
  String get profileSettingsNoGenderFound;

  /// No description provided for @profileSettingsSelectCountryTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get profileSettingsSelectCountryTitle;

  /// No description provided for @profileSettingsNoCountryFound.
  ///
  /// In en, this message translates to:
  /// **'No Country Found'**
  String get profileSettingsNoCountryFound;

  /// No description provided for @comment_qr_code_screen.
  ///
  /// In en, this message translates to:
  /// **'==== QR Code Screen ===='**
  String get comment_qr_code_screen;

  /// No description provided for @qrCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'My Qr Code'**
  String get qrCodeTitle;

  /// No description provided for @qrCodeMerchantId.
  ///
  /// In en, this message translates to:
  /// **'MID: {accountNumber}'**
  String qrCodeMerchantId(Object accountNumber);

  /// No description provided for @qrCodeDownloadButton.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get qrCodeDownloadButton;

  /// No description provided for @qrCodeDownloadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Downloaded successfully!'**
  String get qrCodeDownloadSuccess;

  /// No description provided for @qrCodePermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Permission is required. Please allow it in settings.'**
  String get qrCodePermissionRequired;

  /// No description provided for @comment_add_new_ticket_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Add New Ticket Controller Messages ===='**
  String get comment_add_new_ticket_controller;

  /// No description provided for @addNewTicketTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get addNewTicketTitleRequired;

  /// No description provided for @addNewTicketDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get addNewTicketDescriptionRequired;

  /// No description provided for @addNewTicketSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Ticket created successfully'**
  String get addNewTicketSuccessMessage;

  /// No description provided for @comment_add_new_ticket_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Add New Ticket Screen ===='**
  String get comment_add_new_ticket_screen;

  /// No description provided for @addNewTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Ticket'**
  String get addNewTicketTitle;

  /// No description provided for @addNewTicketTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get addNewTicketTitleLabel;

  /// No description provided for @addNewTicketDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get addNewTicketDescriptionLabel;

  /// No description provided for @addNewTicketAddAttach.
  ///
  /// In en, this message translates to:
  /// **'Add Attach'**
  String get addNewTicketAddAttach;

  /// No description provided for @addNewTicketAttachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach File'**
  String get addNewTicketAttachFile;

  /// No description provided for @addNewTicketAddTicketButton.
  ///
  /// In en, this message translates to:
  /// **'Add Ticket'**
  String get addNewTicketAddTicketButton;

  /// No description provided for @comment_replay_ticket_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Replay Ticket Screen ===='**
  String get comment_replay_ticket_screen;

  /// No description provided for @replayTicketCloseButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get replayTicketCloseButton;

  /// No description provided for @replayTicketMessageRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an message'**
  String get replayTicketMessageRequired;

  /// No description provided for @replayTicketAttachmentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Attachments:'**
  String get replayTicketAttachmentsLabel;

  /// No description provided for @replayTicketUnknownFile.
  ///
  /// In en, this message translates to:
  /// **'Unknown file'**
  String get replayTicketUnknownFile;

  /// No description provided for @replayTicketTypeMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type your message'**
  String get replayTicketTypeMessageHint;

  /// No description provided for @replayTicketAttachmentPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Attachment Preview'**
  String get replayTicketAttachmentPreviewTitle;

  /// No description provided for @comment_support_ticket_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Support Ticket Screen ===='**
  String get comment_support_ticket_screen;

  /// No description provided for @supportTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Ticket'**
  String get supportTicketTitle;

  /// No description provided for @supportTicketStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get supportTicketStatusOpen;

  /// No description provided for @supportTicketStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get supportTicketStatusClosed;

  /// No description provided for @supportTicketViewButton.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get supportTicketViewButton;

  /// No description provided for @comment_transaction_filter_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Transaction Filter Bottom Sheet ===='**
  String get comment_transaction_filter_bottom_sheet;

  /// No description provided for @transactionFilterTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionFilterTransactionId;

  /// No description provided for @transactionFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get transactionFilterStatus;

  /// No description provided for @transactionFilterApplyButton.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get transactionFilterApplyButton;

  /// No description provided for @comment_transactions_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Transactions Screen ===='**
  String get comment_transactions_screen;

  /// No description provided for @transactionsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionsScreenTitle;

  /// No description provided for @comment_two_fa_authentication_screen.
  ///
  /// In en, this message translates to:
  /// **'==== 2FA Authentication Screen ===='**
  String get comment_two_fa_authentication_screen;

  /// No description provided for @twoFaAuthenticationTitle.
  ///
  /// In en, this message translates to:
  /// **'2FA Authentication'**
  String get twoFaAuthenticationTitle;

  /// No description provided for @comment_disable_two_fa_section.
  ///
  /// In en, this message translates to:
  /// **'==== Disable 2FA Section ===='**
  String get comment_disable_two_fa_section;

  /// No description provided for @disableTwoFaTitle.
  ///
  /// In en, this message translates to:
  /// **'2FA Authentication'**
  String get disableTwoFaTitle;

  /// No description provided for @disableTwoFaInstruction.
  ///
  /// In en, this message translates to:
  /// **'Enter your password to disable 2FA'**
  String get disableTwoFaInstruction;

  /// No description provided for @disableTwoFaPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an password'**
  String get disableTwoFaPasswordRequired;

  /// No description provided for @disableTwoFaButton.
  ///
  /// In en, this message translates to:
  /// **'Disable 2FA'**
  String get disableTwoFaButton;

  /// No description provided for @comment_enable_two_fa_section.
  ///
  /// In en, this message translates to:
  /// **'==== Enable 2FA Section ===='**
  String get comment_enable_two_fa_section;

  /// No description provided for @enableTwoFaTitle.
  ///
  /// In en, this message translates to:
  /// **'2FA Authentication'**
  String get enableTwoFaTitle;

  /// No description provided for @enableTwoFaInstruction.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code with Google Authenticator\nApp to enable 2FA'**
  String get enableTwoFaInstruction;

  /// No description provided for @enableTwoFaPinLabel.
  ///
  /// In en, this message translates to:
  /// **'The PIN From Google Authenticator App'**
  String get enableTwoFaPinLabel;

  /// No description provided for @enableTwoFaPinRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an google authentication pin'**
  String get enableTwoFaPinRequired;

  /// No description provided for @enableTwoFaButton.
  ///
  /// In en, this message translates to:
  /// **'Enable 2FA'**
  String get enableTwoFaButton;

  /// No description provided for @comment_generate_qr_code_section.
  ///
  /// In en, this message translates to:
  /// **'==== Generate QR Code Section ===='**
  String get comment_generate_qr_code_section;

  /// No description provided for @generateQrCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'2FA Authentication'**
  String get generateQrCodeTitle;

  /// No description provided for @generateQrCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Enhance your account security with two-factor authentication'**
  String get generateQrCodeDescription;

  /// No description provided for @generateQrCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Generate 2FA'**
  String get generateQrCodeButton;

  /// No description provided for @comment_create_new_wallet_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Create New Wallet Screen ===='**
  String get comment_create_new_wallet_screen;

  /// No description provided for @createNewWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Wallet'**
  String get createNewWalletTitle;

  /// No description provided for @createNewWalletSelectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get createNewWalletSelectCurrency;

  /// No description provided for @createNewWalletCurrencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get createNewWalletCurrencyLabel;

  /// No description provided for @createNewWalletCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createNewWalletCreateButton;

  /// No description provided for @createNewWalletSelectCurrencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get createNewWalletSelectCurrencyTitle;

  /// No description provided for @createNewWalletNoCurrencyFound.
  ///
  /// In en, this message translates to:
  /// **'No Currency Found'**
  String get createNewWalletNoCurrencyFound;

  /// No description provided for @comment_delete_wallet_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Delete Wallet Bottom Sheet ===='**
  String get comment_delete_wallet_bottom_sheet;

  /// No description provided for @deleteWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get deleteWalletTitle;

  /// No description provided for @deleteWalletMessage.
  ///
  /// In en, this message translates to:
  /// **'Once you delete your data, you won\'t be able to revert this!'**
  String get deleteWalletMessage;

  /// No description provided for @deleteWalletConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get deleteWalletConfirmButton;

  /// No description provided for @comment_wallet_details_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Wallet Details Screen ===='**
  String get comment_wallet_details_screen;

  /// No description provided for @walletDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet Details'**
  String get walletDetailsTitle;

  /// No description provided for @walletDetailsTotalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get walletDetailsTotalBalance;

  /// No description provided for @walletDetailsWithdrawButton.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get walletDetailsWithdrawButton;

  /// No description provided for @walletDetailsHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get walletDetailsHistory;

  /// No description provided for @walletDetailsSelectWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get walletDetailsSelectWalletTitle;

  /// No description provided for @walletDetailsWalletNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallet not found'**
  String get walletDetailsWalletNotFound;

  /// No description provided for @comment_wallets_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Wallets Screen ===='**
  String get comment_wallets_screen;

  /// No description provided for @walletsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'My Wallets'**
  String get walletsScreenTitle;

  /// No description provided for @walletsScreenWithdrawButton.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get walletsScreenWithdrawButton;

  /// No description provided for @walletsScreenDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get walletsScreenDeleteButton;

  /// No description provided for @comment_create_withdraw_account_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Create Withdraw Account Controller Messages ===='**
  String get comment_create_withdraw_account_controller;

  /// No description provided for @createWithdrawAccountWalletRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a wallet'**
  String get createWithdrawAccountWalletRequired;

  /// No description provided for @createWithdrawAccountWithdrawMethodRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a withdraw method'**
  String get createWithdrawAccountWithdrawMethodRequired;

  /// No description provided for @createWithdrawAccountMethodNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an method name'**
  String get createWithdrawAccountMethodNameRequired;

  /// No description provided for @createWithdrawAccountFileRequired.
  ///
  /// In en, this message translates to:
  /// **'Please upload a file for {fieldName}'**
  String createWithdrawAccountFileRequired(Object fieldName);

  /// No description provided for @createWithdrawAccountFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the {fieldName} field'**
  String createWithdrawAccountFieldRequired(Object fieldName);

  /// No description provided for @comment_withdraw_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Controller Messages ===='**
  String get comment_withdraw_controller;

  /// No description provided for @withdrawWithdrawAccountRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a withdraw account'**
  String get withdrawWithdrawAccountRequired;

  /// No description provided for @withdrawAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get withdrawAmountRequired;

  /// No description provided for @withdrawMinAmountError.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount should be {min} {currency}'**
  String withdrawMinAmountError(Object currency, Object min);

  /// No description provided for @withdrawMaxAmountError.
  ///
  /// In en, this message translates to:
  /// **'Maximum amount should be {max} {currency}'**
  String withdrawMaxAmountError(Object currency, Object max);

  /// No description provided for @comment_create_withdraw_account_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Create Withdraw Account Screen ===='**
  String get comment_create_withdraw_account_screen;

  /// No description provided for @createWithdrawAccountScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Withdraw Account'**
  String get createWithdrawAccountScreenTitle;

  /// No description provided for @createWithdrawAccountScreenHeader.
  ///
  /// In en, this message translates to:
  /// **'Create Withdraw Account'**
  String get createWithdrawAccountScreenHeader;

  /// No description provided for @createWithdrawAccountScreenWalletLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get createWithdrawAccountScreenWalletLabel;

  /// No description provided for @createWithdrawAccountScreenWithdrawMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Method'**
  String get createWithdrawAccountScreenWithdrawMethodLabel;

  /// No description provided for @createWithdrawAccountScreenMethodNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Method Name'**
  String get createWithdrawAccountScreenMethodNameLabel;

  /// No description provided for @createWithdrawAccountScreenCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createWithdrawAccountScreenCreateButton;

  /// No description provided for @createWithdrawAccountScreenSelectWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get createWithdrawAccountScreenSelectWalletTitle;

  /// No description provided for @createWithdrawAccountScreenWalletNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallet not found'**
  String get createWithdrawAccountScreenWalletNotFound;

  /// No description provided for @createWithdrawAccountScreenSelectMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Method'**
  String get createWithdrawAccountScreenSelectMethodTitle;

  /// No description provided for @createWithdrawAccountScreenWithdrawMethodNotFound.
  ///
  /// In en, this message translates to:
  /// **'Withdraw method not found'**
  String get createWithdrawAccountScreenWithdrawMethodNotFound;

  /// No description provided for @comment_edit_withdraw_account_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Edit Withdraw Account Screen ===='**
  String get comment_edit_withdraw_account_screen;

  /// No description provided for @editWithdrawAccountScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Withdraw Account'**
  String get editWithdrawAccountScreenTitle;

  /// No description provided for @editWithdrawAccountScreenHeader.
  ///
  /// In en, this message translates to:
  /// **'Edit Withdraw Account'**
  String get editWithdrawAccountScreenHeader;

  /// No description provided for @editWithdrawAccountScreenMethodNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Method name'**
  String get editWithdrawAccountScreenMethodNameLabel;

  /// No description provided for @editWithdrawAccountScreenUpdateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get editWithdrawAccountScreenUpdateButton;

  /// No description provided for @comment_withdraw_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Screen ===='**
  String get comment_withdraw_screen;

  /// No description provided for @withdrawScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Money'**
  String get withdrawScreenTitle;

  /// No description provided for @comment_delete_account_dropdown_section.
  ///
  /// In en, this message translates to:
  /// **'==== Delete Account Dropdown Section ===='**
  String get comment_delete_account_dropdown_section;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Withdraw account?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountWarningPart1.
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone. All data will be'**
  String get deleteAccountWarningPart1;

  /// No description provided for @deleteAccountWarningPart2.
  ///
  /// In en, this message translates to:
  /// **' removed.'**
  String get deleteAccountWarningPart2;

  /// No description provided for @deleteAccountDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAccountDeleteButton;

  /// No description provided for @deleteAccountCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get deleteAccountCancelButton;

  /// No description provided for @comment_withdraw_account_filter_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Account Filter Bottom Sheet ===='**
  String get comment_withdraw_account_filter_bottom_sheet;

  /// No description provided for @withdrawAccountFilterAccountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get withdrawAccountFilterAccountName;

  /// No description provided for @withdrawAccountFilterSearchButton.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get withdrawAccountFilterSearchButton;

  /// No description provided for @comment_withdraw_account_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Account Section ===='**
  String get comment_withdraw_account_section;

  /// No description provided for @withdrawAccountSectionAllAccount.
  ///
  /// In en, this message translates to:
  /// **'All Account'**
  String get withdrawAccountSectionAllAccount;

  /// No description provided for @withdrawAccountSectionAddAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get withdrawAccountSectionAddAccount;

  /// No description provided for @comment_withdraw_amount_step_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Amount Step Section ===='**
  String get comment_withdraw_amount_step_section;

  /// No description provided for @withdrawAmountStepAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get withdrawAmountStepAccount;

  /// No description provided for @withdrawAmountStepAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get withdrawAmountStepAmount;

  /// No description provided for @withdrawAmountStepContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get withdrawAmountStepContinueButton;

  /// No description provided for @withdrawAmountStepMinMaxAmount.
  ///
  /// In en, this message translates to:
  /// **'Minimum {min} {currency} and Maximum {max} {currency}'**
  String withdrawAmountStepMinMaxAmount(
    Object currency,
    Object max,
    Object min,
  );

  /// No description provided for @withdrawAmountStepSelectWithdrawAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Withdraw Account'**
  String get withdrawAmountStepSelectWithdrawAccountTitle;

  /// No description provided for @withdrawAmountStepWithdrawAccountNotFound.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Account Not Found'**
  String get withdrawAmountStepWithdrawAccountNotFound;

  /// No description provided for @withdrawAmountStepSelectWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get withdrawAmountStepSelectWalletTitle;

  /// No description provided for @withdrawAmountStepWalletsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallets Not Found'**
  String get withdrawAmountStepWalletsNotFound;

  /// No description provided for @comment_withdraw_review_step_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Review Step Section ===='**
  String get comment_withdraw_review_step_section;

  /// No description provided for @withdrawReviewStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Details'**
  String get withdrawReviewStepTitle;

  /// No description provided for @withdrawReviewStepAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get withdrawReviewStepAmount;

  /// No description provided for @withdrawReviewStepCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get withdrawReviewStepCharge;

  /// No description provided for @withdrawReviewStepTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get withdrawReviewStepTotal;

  /// No description provided for @withdrawReviewStepWithdrawNowButton.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Now'**
  String get withdrawReviewStepWithdrawNowButton;

  /// No description provided for @comment_withdraw_success_step_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Success Step Section ===='**
  String get comment_withdraw_success_step_section;

  /// No description provided for @withdrawSuccessStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Pending'**
  String get withdrawSuccessStepTitle;

  /// No description provided for @withdrawSuccessStepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your funds have been pending\nwithdrawn.'**
  String get withdrawSuccessStepSubtitle;

  /// No description provided for @withdrawSuccessStepAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get withdrawSuccessStepAmount;

  /// No description provided for @withdrawSuccessStepTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get withdrawSuccessStepTransactionId;

  /// No description provided for @withdrawSuccessStepCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get withdrawSuccessStepCharge;

  /// No description provided for @withdrawSuccessStepTransactionType.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get withdrawSuccessStepTransactionType;

  /// No description provided for @withdrawSuccessStepFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Amount'**
  String get withdrawSuccessStepFinalAmount;

  /// No description provided for @withdrawSuccessStepDateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get withdrawSuccessStepDateTime;

  /// No description provided for @withdrawSuccessStepBackHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Back Home'**
  String get withdrawSuccessStepBackHomeButton;

  /// No description provided for @withdrawSuccessStepWithdrawAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Again'**
  String get withdrawSuccessStepWithdrawAgainButton;

  /// No description provided for @comment_withdraw_toggle_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Toggle Section ===='**
  String get comment_withdraw_toggle_section;

  /// No description provided for @withdrawToggleWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdrawToggleWithdraw;

  /// No description provided for @withdrawToggleWithdrawAccount.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Account'**
  String get withdrawToggleWithdrawAccount;

  /// No description provided for @comment_dynamic_attachment_preview.
  ///
  /// In en, this message translates to:
  /// **'==== Dynamic Attachment Preview ===='**
  String get comment_dynamic_attachment_preview;

  /// No description provided for @dynamicAttachmentPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Attachment Preview'**
  String get dynamicAttachmentPreviewTitle;

  /// No description provided for @comment_no_internet_connection_screen.
  ///
  /// In en, this message translates to:
  /// **'==== No Internet Connection Screen ===='**
  String get comment_no_internet_connection_screen;

  /// No description provided for @noInternetConnectionTitle.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnectionTitle;

  /// No description provided for @noInternetConnectionMessage.
  ///
  /// In en, this message translates to:
  /// **'Please check your network settings'**
  String get noInternetConnectionMessage;

  /// No description provided for @noInternetConnectionRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get noInternetConnectionRetryButton;

  /// No description provided for @comment_web_view_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Web View Screen ===='**
  String get comment_web_view_screen;

  /// No description provided for @webViewPaymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get webViewPaymentSuccess;

  /// No description provided for @webViewPaymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed!'**
  String get webViewPaymentFailed;

  /// No description provided for @webViewPaymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment was cancelled!'**
  String get webViewPaymentCancelled;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
