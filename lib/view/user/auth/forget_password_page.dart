import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/res/image_paths.dart';
import 'package:dine_dash/view/user/auth/otp_verification_page.dart';
import 'package:flutter/material.dart';


class UserForgotPasswordScreen extends StatefulWidget {
  UserForgotPasswordScreen({super.key});

  @override
  State<UserForgotPasswordScreen> createState() => _UserForgotPasswordScreenState();
}

class _UserForgotPasswordScreenState extends State<UserForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Get Verification Code",backGroundColor: AppColors.primaryColor,textColor: AppColors.white),
      backgroundColor: AppColors.primaryColor,
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
        
                Image.asset(ImagePaths.forgetPageImage),
            
      
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(
                        text: "Forget Your ",
                        style: TextStyle(color: Colors.black),
                      ),
                         const TextSpan(
                        text: "Password",
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
                  "Enter your email address to reset your password.",
                  textAlign: TextAlign.center,
                  size: 14.0,
                ),
                const SizedBox(height: 30),
            
                // Email TextField
                commonTextfieldWithTitle(
                  "Email",
                  emailController,
                  hintText: "Enter your email",
                  assetIconPath: ImagePaths.emailIcon,
                  keyboardType: TextInputType.emailAddress,
                ),

              const SizedBox(height: 40),
                commonButton(
                  "Get Verification Code",
                  textColor: Colors.white,
                  onTap: () {
                 navigateToPage(UserOTPVerificationScreen());
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