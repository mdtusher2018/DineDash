import 'package:dine_dash/features/view%20must%20be%20edited/res/colors.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/res/commonWidgets.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/res/image_paths.dart';
import 'package:dine_dash/features/auth/common/forget_password_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(   backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: commonText("Change Password".tr, size: 18, isBold: true),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: double.infinity,
        child: Column(
          children: [
        
            const SizedBox(height: 10),

            // Current Password Field
            commonTextfieldWithTitle(
              "Current Password".tr,
              currentPasswordController,
              hintText: "Enter your password".tr,
              assetIconPath: ImagePaths.lockIcon,

              isPasswordVisible: isCurrentPasswordVisible,
              issuffixIconVisible: true,
              changePasswordVisibility: () {
                setState(() {
                  isCurrentPasswordVisible = !isCurrentPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 15),

            // New Password Field
            commonTextfieldWithTitle(
              "New Password".tr,
              newPasswordController,
              hintText: "Enter your password".tr,
              assetIconPath: ImagePaths.lockIcon,

              isPasswordVisible: isNewPasswordVisible,
              issuffixIconVisible: true,
              changePasswordVisibility: () {
                setState(() {
                  isNewPasswordVisible = !isNewPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 15),

            // Confirm New Password Field
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
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                InkWell(
                  onTap: () {
                    Get.to(ForgotPasswordScreen());
                  },
                  child: Column(
                    children: [
                      commonText("Forgot Password".tr, isBold: true),
                      Container(
                        width: 95,
                        height: 0.5,
                        color: AppColors.black,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Change Password Button
            commonButton(
              "Change Password".tr,

              textColor: AppColors.white,
              onTap: () {
                Get.back();
                print("Password changed!".tr);
              },
            ),
          ],
        ),
      ),
    );
  }
}