import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';

class SplashController extends GetxController {
  Future<void> navigateBasedOnAuth() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none) ||
        connectivityResult.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.currentRoute != BaseRoute.noInternetConnection) {
          Get.offAllNamed(BaseRoute.noInternetConnection);
        }
      });
      return;
    }

    final loginState = await SettingsService.getLoginCurrentState();

    if (loginState != null && loginState.isNotEmpty) {
      Get.offNamed(BaseRoute.login);
    } else {
      Get.offNamed(BaseRoute.welcome);
    }
  }
}
