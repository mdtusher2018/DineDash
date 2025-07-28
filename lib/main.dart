import 'package:dine_dash/dealer_user_chooser.dart';
import 'package:dine_dash/view/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
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
