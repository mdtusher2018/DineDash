
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/auth/common/sign_in_sign_up_chooeser.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:get/get.dart';

class UserOnboardingView extends StatefulWidget {
  const UserOnboardingView({super.key});

  @override
  State<UserOnboardingView> createState() => _UserOnboardingViewState();
}

class _UserOnboardingViewState extends State<UserOnboardingView> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingData> pages = [
    OnboardingData(
      imagePath: "assets/images/Onboarding 4.png",
      title: "Exclusive Deals",
      subtitle:
          "Access special promotions and discounts available only to DEALR. users.",
    ),
    OnboardingData(
      imagePath: "assets/images/Onboarding 5.png",
      title: "Read & Write Reviews",
      subtitle:
          "Share your experiences and learn from others with ratings and detailed reviews.",
    ),
    OnboardingData(
      imagePath: "assets/images/Onboarding 6.png",
      title: "Discover Local Gems",
      subtitle:
          "Find the best restaurants near you, with personalized recommendations and detailed profiles.",
    ),
  ];

  void nextPage() async {
    if (currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await Get.find<LocalStorageService>().saveBool(
        StorageKey.isUserOnboardingCompleated,
        true,
      );

      navigateToPage(SignInSignUpChooeser(), clearStack: true);
    }
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) => setState(() => currentIndex = index),
        itemBuilder: (context, index) {
          final data = pages[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              /// Background image
              Image.asset(data.imagePath, fit: BoxFit.cover),

              /// Overlay content
              Container(
                padding: EdgeInsets.all(16),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 30),
                    Image.asset("assets/images/logo.png", height: 80),

                    Spacer(),

                    Row(
                      children: List.generate(
                        pages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentIndex == index ? 32 : 16,
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color:
                                currentIndex == index
                                    ? AppColors.primaryColor
                                    : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        commonText(
                          data.title.tr,
                          size: 24,
                          isBold: true,
                          color: AppColors.white,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// Subtitle
                    Row(
                      children: [
                        Flexible(
                          child: commonText(
                            data.subtitle.tr,
                            size: 14,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    /// Next or Get Started
                    commonButton(
                      index == pages.length - 1
                          ? "Start Managing".tr
                          : "Next".tr,
                      haveNextIcon: true,
                      onTap: nextPage,
                    ),

                    const SizedBox(height: 20),

                    /// Skip Button
                    if (index < pages.length - 1)
                      GestureDetector(
                        onTap: () {
                          currentIndex = pages.length;
                          nextPage();
                        },
                        child: commonText(
                          "Skip".tr,
                          color: Colors.white,
                          size: 14,
                          isBold: true,
                          textAlign: TextAlign.center,
                        ),
                      ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class OnboardingData {
  final String imagePath;
  final String title;
  final String subtitle;

  OnboardingData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}
