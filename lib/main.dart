// ignore_for_file: must_be_immutable
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/constent.dart';
import 'package:dine_dash/dependency.dart';
import 'package:dine_dash/core/translations/app_translations.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/splash_screen.dart';
// import 'package:dine_dash/features/auth/common/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);

    debugPrint('Caught FlutterError: ${details.exception}');
    debugPrint('Stack trace:');
    debugPrint(details.stack.toString());
  };

  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();

  final LocalStorageService localStorage = Get.find<LocalStorageService>();
  String? langCode =
      await localStorage.getString(StorageKey.languageCode) ?? 'de';
  String? countryCode =
      await localStorage.getString(StorageKey.postalCode) ?? 'DE';

  runApp(MyApp(initialLocale: Locale(langCode, countryCode)));
}

class MyApp extends StatelessWidget {
  Locale? initialLocale;
  MyApp({super.key, this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: AppTranslations(),
      // locale: initialLocale??Locale('de', 'DE'),
      // fallbackLocale: Locale('de', 'DE'),
      locale: initialLocale ?? Locale('en', 'EN'),
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,
      fallbackLocale: Locale('en', 'EN'),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: AppColors.white,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.white,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
