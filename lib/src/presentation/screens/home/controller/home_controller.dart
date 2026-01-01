import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_merchant/src/common/services/biometric_auth_service.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/network/api/api_path.dart';
import 'package:qunzo_merchant/src/network/response/status.dart';
import 'package:qunzo_merchant/src/network/service/network_service.dart';
import 'package:qunzo_merchant/src/network/service/token_service.dart';
import 'package:qunzo_merchant/src/presentation/screens/transactions/model/transactions_model.dart';
import 'package:qunzo_merchant/src/presentation/screens/wallets/model/wallets_model.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isSignOutLoading = false.obs;
  final RxBool isBiometricEnable = false.obs;
  final RxInt selectedIndex = 0.obs;
  final RxInt selectedDrawerIndex = 0.obs;
  final RxInt currentWalletIndex = 0.obs;
  GlobalKey<ScaffoldState>? scaffoldKey;
  final UserProfileController userProfileController = Get.find();
  final Rx<WalletsModel> walletsModel = WalletsModel().obs;
  final Rx<TransactionsModel> transactionsModel = TransactionsModel().obs;
  final RxString language = "".obs;
  final localization = AppLocalizations.of(Get.context!)!;

  @override
  void onInit() {
    super.onInit();
    loadData();
    loadBiometricStatus();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    if (Get.find<SettingsService>().getSetting("language_switcher") == "1") {
      _setInitialLanguage();
    }
    await userProfileController.fetchUserProfile();
    await fetchWallets();
    await fetchTransactions();
    isLoading.value = false;
  }

  // Load Biometric Status
  Future<void> loadBiometricStatus() async {
    final savedBiometric = await SettingsService.getBiometricEnableOrDisable();
    isBiometricEnable.value = savedBiometric ?? false;
  }

  void setScaffoldKey(GlobalKey<ScaffoldState> key) {
    scaffoldKey = key;
  }

  void openDrawer() {
    scaffoldKey!.currentState!.openDrawer();
  }

  Future<void> _setInitialLanguage() async {
    final savedLocale = await SettingsService.getLanguageLocaleCurrentState();

    if (savedLocale != null) {
      if (savedLocale == "en") {
        language.value = "English";
      }
    } else {
      language.value = "English";
      await Get.find<SettingsService>().saveLanguageLocaleCurrentState("en");
    }
  }

  // Language Switching Method
  Future<void> changeLanguage(String languageName) async {
    try {
      language.value = languageName;

      String localeCode;
      if (languageName == "English") {
        localeCode = "en";
      } else {
        localeCode = "en";
      }

      await Get.find<SettingsService>().saveLanguageLocaleCurrentState(
        localeCode,
      );

      Get.updateLocale(Locale(localeCode));
    } catch (e, stackTrace) {
      debugPrint('❌ changeLanguage() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
    }
  }

  // Toggle Biometric
  Future<void> toggleBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    final biometricAuthService = BiometricAuthService();
    final isSupported = await auth.isDeviceSupported();
    final isAvailable = await biometricAuthService.isBiometricAvailable();

    if (!isSupported) {
      ToastHelper().showErrorToast(localization.homeBiometricNotSupported);
      return;
    }
    if (!isAvailable) {
      _showBiometricNotAvailableDialog();
      return;
    }

    final isAuthenticated = await biometricAuthService
        .authenticateWithBiometrics();

    if (isAuthenticated) {
      isBiometricEnable.value = !isBiometricEnable.value;
      await Get.find<SettingsService>().saveBiometricEnableOrDisable(
        isBiometricEnable.value,
      );
      ToastHelper().showSuccessToast(
        isBiometricEnable.value
            ? localization.homeBiometricEnabledSuccess
            : localization.homeBiometricDisabledSuccess,
      );
    } else {
      ToastHelper().showErrorToast(localization.homeBiometricAuthFailed);
    }
  }

  // Fetch Wallets Function
  Future<void> fetchWallets() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.walletsEndpoint,
      );
      if (response.status == Status.completed) {
        walletsModel.value = WalletsModel.fromJson(response.data!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchWallets() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerGeneralError);
    } finally {}
  }

  // Fetch Transactions Function
  Future<void> fetchTransactions() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.transactionsEndpoint,
      );
      if (response.status == Status.completed) {
        transactionsModel.value = TransactionsModel.fromJson(response.data!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchTransactions() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerGeneralError);
    } finally {}
  }

  // Logout Function
  Future<void> submitLogout() async {
    isSignOutLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.logoutEndpoint,
      );

      if (response.status == Status.completed) {
        await Get.find<TokenService>().clearToken();
        Get.offAllNamed(BaseRoute.login);
        ToastHelper().showSuccessToast(response.data?["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitLogout() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerGeneralError);
    } finally {
      isSignOutLoading.value = false;
    }
  }

  void _showBiometricNotAvailableDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Icon(Icons.fingerprint, size: 60, color: AppColors.lightPrimary),
            const SizedBox(height: 12),
            Text(
              localization.homeBiometricNotFoundTitle,
              style: TextStyle(
                letterSpacing: 0,
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
                color: AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              localization.homeBiometricNotFoundMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
                fontSize: 16.0,
                height: 1.5,
                color: AppColors.lightTextTertiary,
              ),
            ),
            const SizedBox(height: 24.0),
            CommonButton(
              width: double.infinity,
              text: localization.homeOpenSecuritySettingsButton,
              onPressed: () => _openSecuritySettings(),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  void _openSecuritySettings() {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'android.settings.SECURITY_SETTINGS',
      );
      intent.launch();
    } else if (Platform.isIOS) {
      ToastHelper().showWarningToast(localization.homeIosBiometricMessage);
    }
  }
}
