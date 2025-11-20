import 'dart:developer';

import 'package:dine_dash/core/services/deeplink/deeplink_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/user_business_details_page.dart';
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/features/deals/user/user_deals_details_and_redeem/user_deals_details.dart';
import 'package:dine_dash/features/user_root_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/role_selection_page.dart';
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
      return RoleSelectionPage();
    }
  }

  RxBool isOpenedWithDeepLink = false.obs;

  @override
  void initState() {
    super.initState();
    final deepLinkService = Get.find<DeepLinkService>();

    deepLinkService.onBusinessLink = (businessId) {
      debugPrint("Navigate to Business page:==========>>>>>>>> $businessId");
      navigateToPage(
        UserBusinessDetailsPage(businessId: businessId, fromDeepLink: true),
      );

      isOpenedWithDeepLink.value = true;
    };

    deepLinkService.onDealLink = (dealId) {
      debugPrint("Navigate to Deal page:==========>>>>>>>> $dealId");
      navigateToPage(UserDealsDetails(dealId: dealId, fromDeepLink: true));
      isOpenedWithDeepLink.value = true;
    };

    Future.delayed(Duration(seconds: 3), () async {
      final controller = Get.find<LocalStorageService>();
      final token = await controller.getString(StorageKey.token);

      if (isOpenedWithDeepLink.value) {
        return;
      }

      if (token == null) {
        navigateToPage(RoleSelectionPage());
      } else {
        navigateToPage(returnPage(token));
      }
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
