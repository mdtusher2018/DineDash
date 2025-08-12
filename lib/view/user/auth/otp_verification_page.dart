import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/res/image_paths.dart';
import 'package:dine_dash/view/user/auth/reset_password_page.dart';
import 'package:flutter/material.dart';

class UserOTPVerificationScreen extends StatefulWidget {

  UserOTPVerificationScreen({super.key});

  @override
  State<UserOTPVerificationScreen> createState() => _UserOTPVerificationScreenState();
}

class _UserOTPVerificationScreenState extends State<UserOTPVerificationScreen> {
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
      appBar: commonAppBar(title: "Verify Email",textColor: AppColors.white,backGroundColor: AppColors.primaryColor),
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
                  width: 240,
                  height: 240,
                  child: Image.asset(ImagePaths.verificationPageImage)),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(
                        text: "Enter ",
                        style: TextStyle(color: Colors.black),
                      ),
                  
                        const TextSpan(
                        text: "Verification ",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      const TextSpan(
                        text: " Code.",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                commonText(
                  "Enter the code that was sent to your email.",
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
                      "Didn't receive the code? ",
                      size: 14.0,
                    
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: commonText(
                        "Resend",
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
                  "Verify",
            
                  textColor: Colors.white,
                  onTap: () {
               navigateToPage(UserResetPasswordScreen());
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