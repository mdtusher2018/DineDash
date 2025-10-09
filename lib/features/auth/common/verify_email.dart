import 'package:dine_dash/features/view%20must%20be%20edited/res/colors.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/res/commonWidgets.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/res/image_paths.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/user/root_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {

  EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Verify Email".tr,textColor: AppColors.white,backGroundColor: AppColors.primaryColor),
backgroundColor: AppColors.primaryColor,
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  width: 240,height: 240,
                  child: Image.asset(ImagePaths.verificationPageImage)),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                       TextSpan(
                        text: "Enter ".tr,
                        style: TextStyle(color: Colors.black),
                      ),
                  
                         TextSpan(
                        text: "Verification ".tr,
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                     TextSpan(
                        text: " Code.".tr,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                commonText(
                  "Enter the code that was sent to your email.".tr,
                  size: 14.0,
                ),
                const SizedBox(height: 20),
            
                // OTP Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: buildOTPTextField(
                        otpControllers[index],
                        index,
                        context,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
            
                // Resend Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonText(
                      "Didn't receive the code? ".tr,
                      size: 14.0,
                    
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: commonText(
                        "Resend".tr,
                        size: 14.0,
                        color: Colors.black,
                        isBold: true,
                      ),
                    ),
                  ],
                ),
                   SizedBox(height: 20,),
            
                // Verify Button
                commonButton(
                  "Verify".tr,
            
                  textColor: Colors.white,
                  onTap: () {
               navigateToPage(UserRootPage());
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}