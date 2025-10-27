import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/auth/dealer/create_dealer_account_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:dine_dash/features/onboarding/UserOnboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealerUserChooeser extends StatefulWidget {
  const DealerUserChooeser({super.key});

  @override
  State<DealerUserChooeser> createState() => _DealerUserChooeserState();
}

class _DealerUserChooeserState extends State<DealerUserChooeser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/Register.png",
            colorBlendMode: BlendMode.multiply,
            color: Colors.black45,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                Center(child: Image.asset(ImagePaths.logo)),
                Spacer(flex: 5),
                commonText(
                  "Welcome!".tr,
                  size: 21,
                  isBold: true,
                  color: AppColors.white,
                ),
                SizedBox(height: 20),
                commonText(
                  "Are You Dealer or User?".tr,
                  size: 14,
                  color: AppColors.white,
                ),
                SizedBox(height: 20),
                commonButton(
                  "User".tr,
                  onTap: () {
                    navigateToPage(UserOnboardingView());
                  },
                ),

                SizedBox(height: 20),
                commonBorderButton(
                  "Dealer".tr,
                  textColor: AppColors.white,
                  onTap: () {
                    navigateToPage(CreateDealerAccount());
                  },
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
