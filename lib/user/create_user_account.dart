import 'package:dine_dash/colors.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:dine_dash/image_paths.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
      appBar: commonAppBar(title: "Create Account",backGroundColor: AppColors.primaryColor,textColor: AppColors.white),
      backgroundColor: AppColors.primaryColor,
      bottomSheet: Padding(
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
                  "Full name",
                  fullNameController,
                  hintText: "Enter your email",
                  assetIconPath: ImagePaths.userIcon,
                ),
                const SizedBox(height: 15),

                // Email TextField
                commonTextfieldWithTitle(
                  "Email",
                  emailController,
                  hintText: "Enter your email",
                  assetIconPath: ImagePaths.emailIcon,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                    commonTextfieldWithTitle(
                  "Postcode",
                  posterCodeController,
                  hintText: "Enter your postcode",
                  assetIconPath: ImagePaths.locationIcon,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                // Password TextField
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
                const SizedBox(height: 15),

                // Confirm Password TextField
                commonTextfieldWithTitle(
                  "Confirm Password",
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
                    RichText(
                      text: TextSpan(
                        text: "Agree with ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms and Conditions",
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
                  ],
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                commonButton(
                  "Sign Up",
                  onTap: () {
        
                  },
                ),
                const SizedBox(height: 20),

      

                // Sign Up with Google
                commonBorderButton(
                  "Sign Up With Google",
                  imagePath: ImagePaths.googleIcon,

                  onTap: () {},
                ),

                const SizedBox(height: 15),

           


                // Already have an account? Sign In
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonText("Already have an account? ", size: 14.0),
                    GestureDetector(
                      onTap: () {
                        // navigateToPage(SignInScreen());
                      },
                      child: commonText(
                        "Sign In",
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
    );
  }
}