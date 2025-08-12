import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/res/image_paths.dart';
import 'package:flutter/material.dart';

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
      appBar: commonAppBar(title: "Reset Password",backGroundColor: AppColors.primaryColor,textColor: AppColors.white),
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
                      const TextSpan(
                        text: "Now Reset Your ",
                        style: TextStyle(color: Colors.black),
                      ),
                   const TextSpan(
                        text: "Password.",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                commonText("Password  must have 6-8 characters.", size: 14.0),
                const SizedBox(height: 30),
            
                // New Password TextField
                commonTextfieldWithTitle(
                  "New Password",
                  newPasswordController,
                  hintText: "Enter your password",
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
                  "Confirm New Password",
                  confirmPasswordController,
                  hintText: "Enter your password",
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
                  "Reset Password",
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