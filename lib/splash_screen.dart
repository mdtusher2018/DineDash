import 'package:dine_dash/core/services/deeplink/deeplink_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_page.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/user_business_details_page.dart';
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
  Widget returnPage(String token) {
    if (decodeJwtPayload(token)['currentRole'] == 'user') {
      return UserRootPage();
    } else {
      return DealerRootPage();
    }
  }


RxBool isOpenedWithDeepLink=false.obs;

  @override
  void initState() {
    super.initState();
    final deepLinkService = Get.find<DeepLinkService>();

    deepLinkService.onBusinessLink = (businessId) {
      debugPrint("Navigate to Business page:==========>>>>>>>> $businessId");
      navigateToPage(
        UserBusinessDetailsPage(businessId: businessId),
   
      );

        isOpenedWithDeepLink.value = true;

    };

    deepLinkService.onDealLink = (businessId, dealId) {
      debugPrint(
        "Navigate to Deal page:==========>>>>>>>> $dealId under Business $businessId",
      );
    };

    Future.delayed(Duration(seconds: 3), () async {
      final controller = Get.find<LocalStorageService>();
      final token = await controller.getString(StorageKey.token);

      if (isOpenedWithDeepLink.value) {
        return;
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
        clearStack: true,
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
