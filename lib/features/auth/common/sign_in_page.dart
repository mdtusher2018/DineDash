import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:dine_dash/features/auth/user/create_user_account.dart';
import 'package:dine_dash/features/auth/common/forget_password_page.dart';
import 'package:dine_dash/features/user_root_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool isPasswordVisible = false;
  int selectedPlayerType = 0; // 0: Player, 1: Coach

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        title: "Sign In to Your Account".tr,
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                // Email TextField
                commonTextfieldWithTitle(
                  "Email".tr,
                  emailController,
                  hintText: "Enter your email".tr,
                  assetIconPath: ImagePaths.emailIcon,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                // Password TextField with Visibility Toggle
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

                // Remember Me and Forgot Password Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                        ),
                        commonText("Remember me".tr, size: 12.0),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToPage(ForgotPasswordScreen());
                      },
                      child: commonText(
                        "Forgot Password".tr,
                        size: 12.0,
                        isBold: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // Sign In Button
                commonButton(
                  "Sign In".tr,
                  onTap: () {
                    navigateToPage(UserRootPage());
                  },
                ),

                const SizedBox(height: 20),

                // Sign In with Google
                commonBorderButton(
                  "Sign In With Google".tr,
                  imagePath: ImagePaths.googleIcon,

                  onTap: () {
                    // Handle Google Sign In
                  },
                ),

                const SizedBox(height: 30),

                // Already have an account? Sign In
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonText("Don't have an account? ".tr, size: 12.0),
                    GestureDetector(
                      onTap: () {
                        navigateToPage(CreateUserAccount());
                      },
                      child: commonText(
                        "Sign Up".tr,
                        size: 12.0,
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
    );
  }
}

class PlayerSelector extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String label;

  const PlayerSelector({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey,
                width: 2,
              ),
            ),
            child:
                isSelected
                    ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                    : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
