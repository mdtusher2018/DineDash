// ignore_for_file: must_be_immutable

import 'package:dine_dash/dealer_user_chooser.dart';
import 'package:dine_dash/translations/app_translations.dart';
import 'package:dine_dash/view/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // ✅ initialize local storage

  final box = GetStorage();
  String? langCode = box.read('langCode') ?? 'de';
  String? countryCode = box.read('countryCode') ?? 'DE';

  runApp(MyApp(
    initialLocale: Locale(langCode, countryCode),
  ));
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
      locale: initialLocale??Locale('de', 'DE'), // ✅ load saved locale
  fallbackLocale: Locale('de', 'DE'),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.white
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),scaffoldBackgroundColor: AppColors.white,
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.white)
      ),
      // home: RootPage(),
      debugShowCheckedModeBanner: false,
      home: DealerUserChooeser(),
      
    );
  }
}
