import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/features/auth/common/sign_in_sign_up_chooeser.dart';
import 'package:dine_dash/features/onboarding/DealerOnboarding.dart';
import 'package:dine_dash/features/onboarding/UserOnboarding.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';

class RoleSelectionPage extends StatefulWidget {
  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  @override
  void initState() {
    super.initState();
    LocalStorageService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/Onboarding 1.png", fit: BoxFit.cover),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png"),

                  commonText(
                    'Please select a role',
                    size: 18,
                    isBold: true,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 40),

                  commonButton(
                    "USER",
                    onTap: () {
                      SessionMemory.isUser = true;
                      if (LocalStorageService.isUserOnboardingCompleated) {
                        navigateToPage(SignInSignUpChooeser());
                      } else {
                        navigateToPage(UserOnboardingView());
                      }
                    },
                  ),

                  const SizedBox(height: 20),

                  commonButton(
                    "DEALER",
                    onTap: () {
                      SessionMemory.isUser = false;
                      if (LocalStorageService.isDealerOnBoardingCompleated) {
                        navigateToPage(SignInSignUpChooeser());
                      } else {
                        navigateToPage(DealerOnboardingView());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
