// ignore_for_file: must_be_immutable
import 'package:dine_dash/features/auth/common/sign_in_page.dart';
import 'package:dine_dash/translations/app_translations.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final box = GetStorage();
  String? langCode = box.read('langCode') ?? 'de';
  String? countryCode = box.read('countryCode') ?? 'DE';

  runApp(MyApp(initialLocale: Locale(langCode, countryCode)));
}

class MyApp extends StatelessWidget {
  Locale? initialLocale;
  MyApp({super.key, this.initialLocale});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: AppTranslations(),
      //     locale: initialLocale??Locale('de', 'DE'),
      // fallbackLocale: Locale('de', 'DE'),
      locale: initialLocale ?? Locale('en', 'EN'),
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
      // home: RootPage(),
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
