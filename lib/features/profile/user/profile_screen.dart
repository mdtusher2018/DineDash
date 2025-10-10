import 'package:dine_dash/dealer_user_chooser.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/onboarding/DealerOnboarding.dart';
import 'package:dine_dash/features/profile/widgets/common_dialog.dart';
import 'package:dine_dash/features/profile/user/user_subscription.dart';
import 'package:dine_dash/features/profile/common/about_us.dart';
import 'package:dine_dash/features/profile/common/contact_us.dart';
import 'package:dine_dash/features/profile/common/edit_profile.dart';
import 'package:dine_dash/features/profile/common/privacy_policy.dart';
import 'package:dine_dash/features/profile/common/settings.dart';
import 'package:dine_dash/features/profile/common/tearms_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'journey_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 74),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText(
                            "Jhon Doi",
                            size: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          commonText(
                            "example.gmail.com",
                            size: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff555555),
                          ),
                        ],
                      ),
                      Container(
                        height: 77,
                        width: 77,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/profilepic.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => JourneyScreen());
                    },
                    child: Container(
                      height: 84,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          commonText(
                            "Your Journey".tr,
                            size: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(width: 50),
                          Image.asset(
                            "assets/images/track.png",
                            height: 66,
                            width: 66,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildcontainer(
                        image: 'assets/images/edit.png',
                        title: 'Edit Profile',
                        onTap: () {
                          navigateToPage(EditProfileView());
                        },
                      ),
                      buildcontainer(
                        image: 'assets/images/setting.png',
                        title: 'Settings',
                        onTap: () {
                          navigateToPage(SettingsScreen());
                        },
                      ),
                      buildcontainer(
                        image: 'assets/images/contact.png',
                        title: 'Contact Us',
                        onTap: () {
                          navigateToPage(ContactUsPage());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 2, color: Colors.grey.shade300),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  buildRowCon(
                    image: 'assets/images/subscription.png',
                    title: 'Subscription',
                    onTap: () {
                      navigateToPage(SubscriptionView());
                    },
                  ),

                  buildRowCon(
                    image: 'assets/images/policy.png',
                    title: 'Privacy Policy',
                    onTap: () {
                      navigateToPage(PrivacyPolicyScreen());
                    },
                  ),
                  buildRowCon(
                    image: 'assets/images/termscon.png',
                    title: 'Terms and Condition',
                    onTap: () {
                      navigateToPage(TermsAndConditonScreen());
                    },
                  ),
                  buildRowCon(
                    image: 'assets/images/about.png',
                    title: 'About Us',
                    onTap: () {
                      navigateToPage(AboutUsPage());
                    },
                  ),
                  buildRowCon(
                    image:
                        'assets/images/language.png', // Add a globe or language icon in your assets
                    title: 'Language', // This should be localized later
                    onTap: () {
                      showLanguageSelector(context);
                    },
                  ),
                  buildRowCon(
                    image: 'assets/images/become.png',
                    title: 'Become a Dealer',
                    onTap: () {
                      navigateToPage(DealerOnboardingView());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 62),
            GestureDetector(
              onTap: () {
                showLogoutDialog(context, () {
                  Get.offAll(DealerUserChooeser());
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                    top: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    Image.asset(
                      "assets/images/logout.png",
                      height: 35,
                      width: 35,
                      fit: BoxFit.fill,
                    ),
                    commonText(
                      "Log Out".tr,
                      size: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showLogoutDialog(
    BuildContext context,
    VoidCallback onLogout,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: commonText(
            "Do you want to Log Out?".tr,
            size: 18,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: commonButton(
                    "Cancel".tr,
                    color: Color(0xFFDDDDDD),
                    textColor: Colors.black,
                    height: 40,
                    width: 100,
                    boarderRadious: 10,
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: commonButton(
                    "Log Out".tr,
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    height: 40,
                    boarderRadious: 10,
                    width: 100,
                    onTap: onLogout,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class buildRowCon extends StatelessWidget {
  const buildRowCon({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                Image.asset(image, height: 35, width: 35, fit: BoxFit.fill),
                commonText(title.tr, size: 16, fontWeight: FontWeight.w600),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey.shade400,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class buildcontainer extends StatelessWidget {
  const buildcontainer({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 84,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Image.asset(image, height: 35, width: 35, fit: BoxFit.cover),
            commonText(title.tr, size: 14, fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}
