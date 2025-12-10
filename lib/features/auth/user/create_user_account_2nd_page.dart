// ignore_for_file: must_be_immutable

import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/auth/user/user_sign_up_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserAccount2ndPage extends StatefulWidget {
  CreateUserAccount2ndPage({super.key, this.email, this.name, this.postalCode});
  String? email, name, postalCode;

  @override
  State<CreateUserAccount2ndPage> createState() =>
      _CreateUserAccount2ndPageState();
}

class _CreateUserAccount2ndPageState extends State<CreateUserAccount2ndPage> {
  final controller = Get.find<SignUpController>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController posterCodeController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isAgree = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      emailController.text = widget.email ?? "";
      fullNameController.text = widget.name ?? "";
      posterCodeController.text = widget.postalCode ?? "";
    });
  }

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
      appBar: commonAppBar(
        title: "Create Account".tr,
        context: context,
        backGroundColor: AppColors.primaryColor,
        textColor: AppColors.white,
      ),
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

                    hintText: "Enter your name".tr,
                    assetIconPath: ImagePaths.userIcon,
                  ),
                  const SizedBox(height: 15),

                  // Email TextField
                  commonTextfieldWithTitle(
                    "Email".tr,
                    emailController,
                    enable: false,
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
                  if (widget.name == null || widget.name!.isEmpty) ...[
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
                  ],
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
                                recognizer:
                                    TapGestureRecognizer()..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sign Up Button
                  Obx(() {
                    return commonButton(
                      "Sign Up".tr,
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        controller.signUp(
                          fullName: fullNameController.text,
                          context: context,
                          email: emailController.text,
                          postalCode: posterCodeController.text,
                          password: passwordController.text,
                          confirlPassword: confirmPasswordController.text,
                          tremsAndCondition: isAgree,
                          passwrodExist:
                              widget.name == null || widget.name!.isEmpty
                                  ? false
                                  : true,
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 20),

                  // Sign Up with Google
                  // commonBorderButton(
                  //   "Sign Up With Google".tr,
                  //   imagePath: ImagePaths.googleIcon,

                  //   onTap: () {},
                  // ),
                  const SizedBox(height: 15),

                  // Already have an account? Sign In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonText("Already have an account? ".tr, size: 14.0),
                      GestureDetector(
                        onTap: () {
                          navigateToPage(SignInScreen(), context: context);
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
