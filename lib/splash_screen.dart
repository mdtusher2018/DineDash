// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dine_dash/core/services/deeplink/deeplink_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/auth/common/sign_in_sign_up_chooeser.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/user_business_details_page.dart';
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/features/deals/user/user_deals_details_and_redeem/user_deals_details.dart';
import 'package:dine_dash/features/onboarding/UserOnboarding.dart';
import 'package:dine_dash/features/user_root_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/services/localstorage/storage_key.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget returnPage(String token) {
    log(decodeJwtPayload(token).toString());
    if (decodeJwtPayload(token)['isLoginToken'] != null &&
        decodeJwtPayload(token)['isLoginToken'] == true) {
      if (decodeJwtPayload(token)['currentRole'] == 'user') {
        return UserRootPage();
      } else {
        return DealerRootPage();
      }
    } else {
      // return RoleSelectionPage();
      SessionMemory.isUser = true;
      if (LocalStorageService.isUserOnboardingCompleated) {
        return SignInSignUpChooeser();
      } else {
        return UserOnboardingView();
      }
    }
  }

  RxBool isOpenedWithDeepLink = false.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LocalStorageService.init();
      final deepLinkService = Get.find<DeepLinkService>();

      deepLinkService.onBusinessLink = (businessId) {
        debugPrint("Navigate to Business page:==========>>>>>>>> $businessId");
        navigateToPage(
          UserBusinessDetailsPage(businessId: businessId, fromDeepLink: true),
          context: context,
          clearStack: true,
        );

        isOpenedWithDeepLink.value = true;
      };

      deepLinkService.onDealLink = (dealId) {
        debugPrint("Navigate to Deal page:==========>>>>>>>> $dealId");
        navigateToPage(
          UserDealsDetails(dealId: dealId, fromDeepLink: true),
          context: context,
          clearStack: true,
        );
        isOpenedWithDeepLink.value = true;
      };

      Future.delayed(Duration(seconds: 3), () async {
        final controller = Get.find<LocalStorageService>();
        final token = await controller.getString(StorageKey.token);

        if (isOpenedWithDeepLink.value) {
          return;
        }

        if (token == null) {
          SessionMemory.isUser = true;
          if (LocalStorageService.isUserOnboardingCompleated) {
            navigateToPage(
              SignInSignUpChooeser(),
              context: context,
              clearStack: true,
            );
          } else {
            navigateToPage(
              UserOnboardingView(),
              context: context,
              clearStack: true,
            );
          }
        } else {
          navigateToPage(returnPage(token), context: context, clearStack: true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CommonImage('assets/images/logo.png', width: 150, height: 150),
      ),
    );
  }
}
