import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:dine_dash/features/auth/common/sign_in_page.dart';
import 'package:dine_dash/features/auth/common/verify_email.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserAccount extends StatefulWidget {
  const CreateUserAccount({super.key});

  @override
  State<CreateUserAccount> createState() => _CreateUserAccountState();
}

class _CreateUserAccountState extends State<CreateUserAccount> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController posterCodeController=TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isAgree = false;

  @override
  void dispose() {
    emailController.clear();
    fullNameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Create Account".tr,backGroundColor: AppColors.primaryColor,textColor: AppColors.white),
      backgroundColor: AppColors.primaryColor,
      bottomSheet: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
        
                  const SizedBox(height: 20),
        
                  // Full Name TextField
                  commonTextfieldWithTitle(
                    "Full name".tr,
                    fullNameController,
                    hintText: "Enter your email".tr,
                    assetIconPath: ImagePaths.userIcon,
                  ),
                  const SizedBox(height: 15),
        
                  // Email TextField
                  commonTextfieldWithTitle(
                    "Email".tr,
                    emailController,
                    hintText: "Enter your email".tr,
                    assetIconPath: ImagePaths.emailIcon,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
        
                      commonTextfieldWithTitle(
                    "Postcode".tr,
                    posterCodeController,
                    hintText: "Enter your postcode".tr,
                    assetIconPath: ImagePaths.locationIcon,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
        
                  // Password TextField
                  commonTextfieldWithTitle(
                    "Password".tr,
                    passwordController,
                    hintText: "Enter your password".tr,
                    assetIconPath: ImagePaths.lockIcon,
        
                    isPasswordVisible: isPasswordVisible,
                    issuffixIconVisible: true,
                    changePasswordVisibility: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
        
                  // Confirm Password TextField
                  commonTextfieldWithTitle(
                    "Confirm Password".tr,
                    confirmPasswordController,
                    hintText: "Enter your password".tr,
                    assetIconPath: ImagePaths.lockIcon,
        
                    isPasswordVisible: isConfirmPasswordVisible,
                    issuffixIconVisible: true,
                    changePasswordVisibility: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
        
                  Row(
                    children: [
                      Checkbox(
                        value: isAgree,
                        onChanged: (value) {
                          setState(() {
                            isAgree = value!;
                          });
                        },
                      ),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            text: "Agree with ".tr,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms and Conditions".tr,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
        
                  // Sign Up Button
                  commonButton(
                    "Sign Up".tr,
                    onTap: () {
          navigateToPage(EmailVerificationScreen());
                    },
                  ),
                  const SizedBox(height: 20),
        
        
        
                  // Sign Up with Google
                  commonBorderButton(
                    "Sign Up With Google".tr,
                    imagePath: ImagePaths.googleIcon,
        
                    onTap: () {},
                  ),
        
                  const SizedBox(height: 15),
        
             
        
        
                  // Already have an account? Sign In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonText("Already have an account? ".tr, size: 14.0),
                      GestureDetector(
                        onTap: () {
                          navigateToPage(SignInScreen());
                        },
                        child: commonText(
                          "Sign In".tr,
                          size: 14.0,
                          color: AppColors.black,
                          isBold: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}