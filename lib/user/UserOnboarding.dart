import 'package:dine_dash/colors.dart';
import 'package:dine_dash/user/create_user_account.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:dine_dash/padding.dart';

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

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      navigateToPage(CreateUserAccount(),clearStack: true);
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
              Image.asset(
                data.imagePath,
                fit: BoxFit.cover,
              ),

              /// Overlay content
              Container(
                padding: AppPadding.all,
             
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 30,),
                    Image.asset("assets/images/logo.png", height: 80),

                    Spacer(),

                Row(
    
    children: List.generate(
      pages.length,
      (index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: currentIndex == index ? 32 : 16,
        height:  6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: currentIndex == index ? AppColors.primaryColor : AppColors.white,
        ),
      ),
    ),
  ),
  SizedBox(height: 16,),
                    Row(
                      children: [
                        commonText(
                          data.title,
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
                            data.subtitle,
                            size: 14,
                            color: AppColors.white,
                            
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    /// Next or Get Started
                    commonButton(
                      index == pages.length - 1 ? "Start Managing" : "Next",
                      haveNextIcon: true,
                      onTap: nextPage,
                    ),

                    const SizedBox(height: 20),

                    /// Skip Button
                    if (index < pages.length - 1)
                      GestureDetector(
                        onTap: () {
                          // Optionally jump to last or main screen
                          _pageController.jumpToPage(pages.length - 1);
                        },
                        child: commonText(
                          "Skip",
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
