import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/auth/user/user_sign_up_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserAccountFristPage extends StatefulWidget {
  const CreateUserAccountFristPage({super.key});

  @override
  State<CreateUserAccountFristPage> createState() =>
      _CreateUserAccountFristPageState();
}

class _CreateUserAccountFristPageState
    extends State<CreateUserAccountFristPage> {
  final controller = Get.find<SignUpController>();

  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.clear();
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

                  // Email TextField
                  commonTextfieldWithTitle(
                    "Email".tr,
                    emailController,
                    hintText: "Enter your email".tr,
                    assetIconPath: ImagePaths.emailIcon,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Button
                  Obx(() {
                    return commonButton(
                      "Next".tr,
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        controller.checkEmail(
                          emailController.text,
                          context: context,
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
