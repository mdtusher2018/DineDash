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
      appBar: AppBar(title: const Text("Select Your Role")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please select a role', style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                SessionMemory.isUser = true;
                if (LocalStorageService.isUserOnboardingCompleated) {
                  navigateToPage(SignInSignUpChooeser());
                } else {
                  navigateToPage(UserOnboardingView());
                }
              },
              child: const Text("User"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                SessionMemory.isUser = false;
                if (LocalStorageService.isDealerOnBoardingCompleated) {
                  navigateToPage(SignInSignUpChooeser());
                } else {
                  navigateToPage(DealerOnboardingView());
                }
              },
              child: const Text("Dealer"),
            ),
          ],
        ),
      ),
    );
  }
}
