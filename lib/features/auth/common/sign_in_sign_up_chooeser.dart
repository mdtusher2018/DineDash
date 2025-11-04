import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/auth/dealer/create_dealer_account_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:dine_dash/features/auth/user/create_user_account.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInSignUpChooeser extends StatefulWidget {
  const SignInSignUpChooeser({super.key});

  @override
  State<SignInSignUpChooeser> createState() => _SignInSignUpChooeserState();
}

class _SignInSignUpChooeserState extends State<SignInSignUpChooeser> {
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
                  "Now continue after register in ${SessionMemory.isUser ? "\"USER\"" : "\"DEALER\""}"
                      .tr,
                  size: 14,
                  color: AppColors.white,
                ),
                SizedBox(height: 20),
                commonButton(
                  "Sign In".tr,
                  onTap: () {
                    navigateToPage(SignInScreen());
                  },
                ),

                SizedBox(height: 20),
                commonBorderButton(
                  "Sign Up".tr,
                  textColor: AppColors.white,
                  onTap: () {
                    if (SessionMemory.isUser) {
                      navigateToPage(CreateUserAccount());
                    } else {
                      navigateToPage(CreateDealerAccount());
                    }
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
