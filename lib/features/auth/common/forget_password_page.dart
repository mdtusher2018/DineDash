import 'package:dine_dash/features/view%20must%20be%20edited/res/colors.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/res/commonWidgets.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/res/image_paths.dart';
import 'package:dine_dash/features/auth/common/otp_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Get Verification Code".tr,backGroundColor: AppColors.primaryColor,textColor: AppColors.white),
      backgroundColor: AppColors.primaryColor,
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
        
                SizedBox(
                  width: 240,height: 240,
                  child: Image.asset(ImagePaths.forgetPageImage)),
            
      
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                       TextSpan(
                        text: "Forget Your ".tr,
                        style: TextStyle(color: Colors.black),
                      ),
                          TextSpan(
                        text: "Password".tr,
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                        const TextSpan(
                        text: "?",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 5),
                commonText(
                  "Enter your email address to reset your password.".tr,
                  textAlign: TextAlign.center,
                  size: 14.0,
                ),
                const SizedBox(height: 30),
            
                // Email TextField
                commonTextfieldWithTitle(
                  "Email".tr,
                  emailController,
                  hintText: "Enter your email".tr,
                  assetIconPath: ImagePaths.emailIcon,
                  keyboardType: TextInputType.emailAddress,
                ),

              const SizedBox(height: 40),
                commonButton(
                  "Get Verification Code".tr,
                  textColor: Colors.white,
                  onTap: () {
                 navigateToPage(OTPVerificationScreen());
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}