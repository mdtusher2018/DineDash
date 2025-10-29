import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_page.dart';
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/features/onboarding/DealerOnboarding.dart';
import 'package:dine_dash/features/onboarding/UserOnboarding.dart';
import 'package:dine_dash/features/user_root_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/services/localstorage/storage_key.dart';

class SplashScreen extends StatefulWidget {
  final bool isUser;

  SplashScreen({super.key, required this.isUser});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () async {
      final controller = await Get.find<LocalStorageService>();
      final token = await controller.getString(StorageKey.token);

      Widget returnPage(String token) {
        if (decodeJwtPayload(token)['currentRole'] == 'user') {
          return UserRootPage();
        } else {
          return DealerRootPage();
        }
      }

      navigateToPage(
        widget.isUser
            ? ((LocalStorageService.isUserOnboardingCompleated)
                ? (token != null)
                    ? returnPage(token)
                    : SignInScreen()
                : UserOnboardingView())
            : ((LocalStorageService.isDealerOnBoardingCompleated)
                ? (token != null)
                    ? returnPage(token)
                    : SignInScreen()
                : DealerOnboardingView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png', width: 150, height: 150),
      ),
    );
  }
}
