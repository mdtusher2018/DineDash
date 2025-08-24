import 'package:dine_dash/dealer_user_chooser.dart';
import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/user_dealer_common/about_us.dart';
import 'package:dine_dash/view/user_dealer_common/contact_us.dart';
import 'package:dine_dash/view/user_dealer_common/edit_profile.dart';
import 'package:dine_dash/view/user_dealer_common/privacy_policy.dart';
import 'package:dine_dash/view/user_dealer_common/settings.dart';
import 'package:dine_dash/view/user_dealer_common/tearms_and_condition.dart';
import 'package:dine_dash/view/user/root_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/commonWidgets.dart';

class DealerProfile extends StatelessWidget {
  const DealerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 74,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText("Jhon Doi",size: 18,fontWeight: FontWeight.w600),
                          commonText("example.gmail.com",size: 16,fontWeight: FontWeight.w400,color: Color(0xff555555)),
                        ],
                      ),
                      Container(
                        height: 77,
                        width: 77,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/profilepic.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      )

                    ],
                  ),
                  SizedBox(height: 15,),
  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildcontainer(image: 'assets/images/edit.png', title: 'Edit Profile', onTap: () {
                        navigateToPage(EditProfileView());
                      },),
                      buildcontainer(image: 'assets/images/setting.png', title: 'Settings', onTap: () { 
                        navigateToPage(SettingsScreen());
                       },),
                      buildcontainer(image: 'assets/images/contact.png', title: 'Contact Us', onTap: () {
                        navigateToPage(ContactUsPage());
                      },),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(thickness: 2,color: Colors.grey.shade300,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  //   buildRowCon(image: 'assets/images/subscription.png', title: 'Subscription', onTap: () {
                  //   navigateToPage(SubscriptionView());
                  // },),

                  buildRowCon(image: 'assets/images/policy.png', title: 'Privacy Policy', onTap: () {
                    navigateToPage(PrivacyPolicyScreen());
                  },),
                  buildRowCon(image: 'assets/images/termscon.png', title: 'Terms and Condition', onTap: () {
                    navigateToPage(TermsAndConditonScreen());
                  },),
                  buildRowCon(image: 'assets/images/about.png', title: 'About Us', onTap: () {
                    navigateToPage(AboutUsPage());
                  },),
                                                        buildRowCon(
  image: 'assets/images/language.png', // Add a globe or language icon in your assets
  title: 'Language', // This should be localized later
  onTap: () {
    _showLanguageSelector(context);
  },
),
                  buildRowCon(image: 'assets/images/become.png', title: 'Back to User', onTap: () {
                    navigateToPage(UserRootPage(),clearStack: true);
                  },),
                ],
              ),
            ),
            SizedBox(height: 62,),
            GestureDetector(
              onTap: () {
                showLogoutDialog(context, (){
                  Get.offAll(DealerUserChooeser());
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                decoration: BoxDecoration(
                    border: Border(
                      bottom:BorderSide(color: Colors.grey.shade300),
                      top:BorderSide(color: Colors.grey.shade300),)
                ),
                child:Row(
                  spacing: 10,
                  children: [
                    Image.asset("assets/images/logout.png",height: 35,width: 35,fit: BoxFit.fill,),
                    commonText("Log Out",size: 16,fontWeight: FontWeight.w600),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50,),

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
            "Do you want to Log Out?",
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
                    "Cancel",
                    color: Color(0xFFDDDDDD),
                    textColor: Colors.black,
                    height: 40,
                    width: 100,boarderRadious: 10,
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: commonButton(
                    "Log Out",
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    height: 40,
                    boarderRadious: 10,
                    width: 100,
                    onTap: onLogout
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }



void _showLanguageSelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonText("Select Language", size: 18, fontWeight: FontWeight.w600),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.language,color: AppColors.primaryColor),
              title: commonText('English'),
              onTap: () {
                Get.updateLocale(const Locale('en', 'US'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language,color: AppColors.primaryColor,),
              title: commonText('Deutsch'),
              onTap: () {
                Get.updateLocale(const Locale('de', 'DE'));
                Navigator.pop(context);
              },
            ),
            // Add more languages here
          ],
        ),
      );
    },
  );
}




}
class buildRowCon extends StatelessWidget {
  const buildRowCon({
    super.key, required this.image, required this.title, required this.onTap,
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
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                Image.asset(image,height: 35,width: 35,fit: BoxFit.fill,),
                commonText(title,size: 16,fontWeight: FontWeight.w600),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey.shade400,size: 25,),
          ],
        ),
      ),
    );
  }
}

class buildcontainer extends StatelessWidget {
  const buildcontainer({
    super.key, required this.image, required this.title, required this.onTap,
  });
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: 84,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Image.asset(image,height: 32,width: 32,fit: BoxFit.cover,),
            commonText(title,size: 14,fontWeight: FontWeight.w500,textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}



