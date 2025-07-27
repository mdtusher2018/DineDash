import 'package:dine_dash/view/dealer/rootpage.dart';
import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';

import 'package:flutter/material.dart';

class CreateDealerAccount extends StatefulWidget {
  const CreateDealerAccount({super.key});

  @override
  State<CreateDealerAccount> createState() => _CreateDealerAccountState();
}

class _CreateDealerAccountState extends State<CreateDealerAccount> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final businessController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final referralController = TextEditingController();

  void nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void previousPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: 
     AppBar(
    backgroundColor: AppColors.primaryColor,
    leading: (_currentPage!=1)?null: InkWell(
    onTap: (){
      previousPage();
    },
    child: Icon(Icons.arrow_back_ios,color: AppColors.white,)),
    title: commonText("Register",size: 21,isBold: true,color: AppColors.white,
  ),
  centerTitle: true,
  ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(), // prevent swipe
          children: [
            /// PAGE 1: Business Name
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonTextfieldWithTitle("Business Name", businessController,
                      hintText: "Search your business"),
                  const SizedBox(height: 24),
                  commonButton("Continue", onTap: nextPage),
                ],
              ),
            ),
        
            /// PAGE 2: Personal Info
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonTextfieldWithTitle("Your Name", nameController,
                        hintText: "Enter your full name"),
                    const SizedBox(height: 16),
                    commonTextfieldWithTitle("Your Email", emailController,
                        hintText: "Enter your email"),
                    const SizedBox(height: 16),
                    commonTextfieldWithTitle("Your Phone Number", phoneController,
                        hintText: "Enter your phone"),
                    const SizedBox(height: 16),
                    commonTextfieldWithTitle("How did you hear about us?", referralController,
                        hintText: "Referral source"),
                    const SizedBox(height: 24),
              
                    /// Buttons
                    commonButton("Submit", onTap: () {
                      showPendingDialog(context);
                      // ✅ Submit logic
                      print("Business Name: ${businessController.text}");
                      print("Name: ${nameController.text}");
                      print("Email: ${emailController.text}");
                      print("Phone: ${phoneController.text}");
                      print("Referral: ${referralController.text}");
                                
                      // You could call an API here or navigate
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
void showPendingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismiss on tap outside
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content
            children: [
              const SizedBox(height: 16),
              commonText(
                "Your request is under review. You will get a notification after acceptance.",size: 16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              commonButton("Go to Customer", 
              height: 40,
              onTap: () {
   
                Navigator.pop(context); // Close the dialog
                navigateToPage(DealerRootPage());
              }),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}

}
