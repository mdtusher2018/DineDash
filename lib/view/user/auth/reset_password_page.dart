import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/res/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserResetPasswordScreen extends StatefulWidget {
  const UserResetPasswordScreen({super.key});

  @override
  State<UserResetPasswordScreen> createState() => _UserResetPasswordScreenState();
}

class _UserResetPasswordScreenState extends State<UserResetPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  @override
  void dispose() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Reset Password".tr,backGroundColor: AppColors.primaryColor,textColor: AppColors.white),
      backgroundColor: AppColors.primaryColor,
      bottomSheet: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 240,height: 240,
                  child: Image.asset(ImagePaths.resetPageImage)),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                       TextSpan(
                        text: "Now Reset Your ".tr,
                        style: TextStyle(color: Colors.black),
                      ),
                    TextSpan(
                        text: "Password.".tr,
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                commonText("Password  must have 6-8 characters.".tr, size: 14.0),
                const SizedBox(height: 30),
            
                // New Password TextField
                commonTextfieldWithTitle(
                  "New Password".tr,
                  newPasswordController,
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
            
                // Confirm New Password TextField
                commonTextfieldWithTitle(
                  "Confirm New Password".tr,
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
                   SizedBox(height: 20,),
                commonButton(
                  "Reset Password".tr,
                  textColor: Colors.white,
                  onTap: () {
                   
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