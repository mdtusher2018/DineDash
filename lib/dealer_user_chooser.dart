import 'package:dine_dash/colors.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:dine_dash/delar/rootpage.dart';
import 'package:dine_dash/image_paths.dart';
import 'package:dine_dash/user/auth/UserOnboarding.dart';
import 'package:flutter/material.dart';

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
                  "Welcome!",
                  size: 21,
                  isBold: true,
                  color: AppColors.white,
                ),
                SizedBox(height: 20),
                commonText(
                  "Are You Dealer or User?",
                  size: 14,
                  color: AppColors.white,
                ),
                SizedBox(height: 20),
                commonButton(
                  "User",
                  onTap: () {
                    navigateToPage(UserOnboardingView());
                  },
                ),

                SizedBox(height: 20),
                commonBorderButton(
                  "Dealer",
                  textColor: AppColors.white,
                  onTap: () {
                    navigateToPage(DealerRootPage());
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
