import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/auth/common/reset_password/reset_password_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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

  final controller = Get.find<ResetPasswordController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        title: "Reset Password".tr,
        context: context,
        backGroundColor: AppColors.primaryColor,
        textColor: AppColors.white,
      ),
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
                  width: 240,
                  height: 240,
                  child: Image.asset(ImagePaths.resetPageImage),
                ),
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
                commonText(
                  "Password  must have 6-8 characters.".tr,
                  size: 14.0,
                ),
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
                SizedBox(height: 20),
                Obx(() {
                  return commonButton(
                    "Reset Password".tr,
                    isLoading: controller.isLoading.value,
                    textColor: Colors.white,
                    onTap: () {
                      controller.resetPassword(
                        password: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text,
                        context: context,
                      );
                    },
                  );
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
