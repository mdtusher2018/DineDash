import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/res/image_paths.dart';
import 'package:dine_dash/view/user/auth/create_user_account.dart';
import 'package:dine_dash/view/user/auth/forget_password_page.dart';
import 'package:dine_dash/view/user/root_page.dart';
import 'package:flutter/material.dart';

class UserSignInScreen extends StatefulWidget {
  const UserSignInScreen({super.key});

  @override
  State<UserSignInScreen> createState() => _UserSignInScreenState();
}

class _UserSignInScreenState extends State<UserSignInScreen> {
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
        title: "Sign In to Your Account",
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
                  "Email",
                  emailController,
                  hintText: "Enter your email",
                  assetIconPath: ImagePaths.emailIcon,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                // Password TextField with Visibility Toggle
                commonTextfieldWithTitle(
                  "Password",
                  passwordController,
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
                        commonText("Remember me", size: 12.0),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToPage(UserForgotPasswordScreen());
                      },
                      child: commonText(
                        "Forgot Password",
                        size: 12.0,
                        isBold: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // Sign In Button
                commonButton(
                  "Sign In",
                  onTap: () {
                    navigateToPage(UserRootPage());
                  },
                ),

                const SizedBox(height: 20),

                // Sign In with Google
                commonBorderButton(
                  "Sign In With Google",
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
                    commonText("Don't have an account? ", size: 12.0),
                    GestureDetector(
                      onTap: () {
                        navigateToPage(CreateUserAccount());
                      },
                      child: commonText(
                        "Sign Up",
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
