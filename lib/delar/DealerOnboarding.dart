import 'package:dine_dash/colors.dart';
import 'package:dine_dash/delar/create_dealer_account_page.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/commonWidgets.dart';

class DealerOnboardingView extends StatefulWidget {
  const DealerOnboardingView({super.key});

  @override
  State<DealerOnboardingView> createState() => _DealerOnboardingViewState();
}

class _DealerOnboardingViewState extends State<DealerOnboardingView> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingData> pages = [
        OnboardingData(
      imagePath: "assets/images/Onboarding 1.png",
      title: "Manage Your Offers",
      subtitle:
          "Create and manage deals, update your menu, and showcase your restaurant to attract more customers.",
    ),
    OnboardingData(
      imagePath: "assets/images/Onboarding 2.png",
      title: "Track Your Performance",
      subtitle:
          "Monitor deal redemptions, customer engagement, and revenue insights with comprehensive analytics.",
    ),
    OnboardingData(
      imagePath: "assets/images/Onboarding 3.png",
      title: "Grow Your Customer Base",
      subtitle:
          "Reach new customers, build loyalty with existing ones, and increase repeat visits through targeted promotions.",
    ),
  ];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      navigateToPage(CreateDealerAccount(),clearStack: true);
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
                padding: EdgeInsets.all(16),
             
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
