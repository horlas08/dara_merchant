import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/model/user_profile_model.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/network/api/api_path.dart';
import 'package:qunzo_merchant/src/network/response/status.dart';
import 'package:qunzo_merchant/src/network/service/network_service.dart';
import 'package:qunzo_merchant/src/network/service/token_service.dart';

class LoginController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;
  final RxBool isBiometricEnable = false.obs;
  final RxBool isPressed = false.obs;
  final Rx<UserProfileModel> userModel = UserProfileModel().obs;
  final SettingsService settingsService = Get.find<SettingsService>();

  // Email
  final emailController = TextEditingController();

  // Password
  final RxBool isPasswordVisible = true.obs;
  final passwordController = TextEditingController();

  // Biometric Variable
  final RxString biometricEmail = "".obs;
  final RxString biometricPassword = "".obs;

  @override
  void onInit() {
    super.onInit();
    clearSignUpStatus();
    setLogInState();
    loadSavedEmail();
    loadBiometricStatus();
  }

  // Clear Sign Up Status
  void clearSignUpStatus() async {
    await Get.find<SettingsService>().saveEmailVerified(false);
    await Get.find<SettingsService>().saveSetUpPassword(false);
    await Get.find<TokenService>().clearToken();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Set Log In State Function
  Future<void> setLogInState() async {
    await settingsService.saveLoginCurrentState("logged_in");
  }

  // Load Biometric Status
  Future<void> loadBiometricStatus() async {
    final savedBiometric = await SettingsService.getBiometricEnableOrDisable();
    isBiometricEnable.value = savedBiometric ?? false;
  }

  // Load Saved Email
  Future<void> loadSavedEmail() async {
    final savedEmail = await SettingsService.getLoggedInUserEmail();
    if (savedEmail != null && savedEmail.isNotEmpty) {
      emailController.text = savedEmail;
    }
  }

  // Sign In Function
  Future<void> submitSignIn({bool useBiometric = false}) async {
    isLoading.value = true;
    final String email = useBiometric
        ? biometricEmail.value.trim()
        : emailController.text.trim();

    final String password = useBiometric
        ? biometricPassword.value.trim()
        : passwordController.text.trim();

    try {
      final response = await Get.find<NetworkService>().login(
        email: email,
        password: password,
      );

      if (response.status == Status.completed) {
        await postFcmNotification(
          email: email,
          password: password,
          useBiometric: useBiometric,
        );
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitSignIn() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerGeneralError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Get User Function
  Future<void> fetchUser({bool useBiometric = false}) async {
    isLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.getUserProfileEndpoint,
      );
      if (response.status == Status.completed) {
        userModel.value = UserProfileModel.fromJson(response.data!);

        if (userModel.value.data!.user!.twoFa == true &&
            Get.find<SettingsService>().getSetting("fa_verification") == "1") {
          Get.toNamed(BaseRoute.twoFactorAuth);
        } else {
          if (useBiometric) {
            await Get.find<SettingsService>().saveLoggedInUserEmail(
              biometricEmail.value,
            );
            await Get.find<SettingsService>().saveLoggedInUserPassword(
              biometricPassword.value,
            );
          } else {
            await Get.find<SettingsService>().saveLoggedInUserEmail(
              emailController.text,
            );
            await Get.find<SettingsService>().saveLoggedInUserPassword(
              passwordController.text,
            );
          }
          if (userModel.value.data!.user?.boardingSteps!.completed == true) {
            Get.offAllNamed(BaseRoute.navigation);
            resetFields();
          } else {
            Get.toNamed(
              BaseRoute.signUpStatus,
              arguments: {"is_login_state": true},
            );
          }
        }
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchUser() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerGeneralError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postFcmNotification({
    required String email,
    required String password,
    required bool useBiometric,
  }) async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final savedFcmToken = await SettingsService.getFcmToken();

      String deviceId = '';
      String deviceType = '';

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
        deviceType = 'android';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
        deviceType = 'ios';
      } else {
        deviceId = 'unknown';
        deviceType = 'unknown';
      }

      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.getSetupFcm,
        data: {
          'device_id': deviceId,
          'device_type': deviceType,
          'fcm_token': savedFcmToken,
        },
      );

      if (response.status == Status.completed) {
        await fetchUser(useBiometric: useBiometric);
      }
    } catch (e, s) {
      debugPrint('❌ postFcmNotification() error: $e');
      debugPrint('📍 StackTrace: $s');
    }
  }

  // Reset Fields Function
  void resetFields() {
    emailController.clear();
    passwordController.clear();
  }
}
