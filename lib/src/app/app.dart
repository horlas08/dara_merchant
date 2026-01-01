import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/config/theme/light_thtme.dart';
import 'package:qunzo_merchant/src/app/constants/app_strings.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/app/routes/routes_handler.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';

class QunzoMerchant extends StatefulWidget {
  const QunzoMerchant({super.key});

  @override
  State<QunzoMerchant> createState() => _QunzoMerchantState();
}

class _QunzoMerchantState extends State<QunzoMerchant> {
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  // Load saved language from SettingsService
  Future<void> _loadSavedLanguage() async {
    final savedLocale = await SettingsService.getLanguageLocaleCurrentState();

    if (savedLocale != null && mounted) {
      setState(() {
        _locale = Locale(savedLocale);
      });
      Get.updateLocale(Locale(savedLocale));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(376, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          themeMode: ThemeMode.light,
          theme: LightTheme().lightTheme(context),
          getPages: routesHandler,
          initialRoute: BaseRoute.splash,
          locale: _locale,
          fallbackLocale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          builder: (context, widget) {
            return widget ?? const SizedBox.shrink();
          },
        );
      },
    );
  }
}
