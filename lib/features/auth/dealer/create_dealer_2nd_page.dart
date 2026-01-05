import 'dart:io';

import 'package:dine_dash/core/models/user_model.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/auth/common/email_verification/verify_email.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get/get.dart';

import 'create_dealer_account_controller.dart';

class CreateDealerAccount2ndPage extends StatefulWidget {
  final Place? businessDetails;
  final UserModel? userData;
  final String email;
  final String businessName;
  final String address;
  final double longitude, latitude;
  final List<String> types;
  final String businessType;
  final String phoneNumber;
  final String postalCode;
  final List<Map<String, dynamic>> openingHours;
  final File imageFile;

  const CreateDealerAccount2ndPage({
    super.key,
    required this.businessDetails,
    required this.userData,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.businessName,
    required this.address,

    required this.types,
    required this.businessType,
    required this.phoneNumber,
    required this.postalCode,
    required this.openingHours,
    required this.imageFile,
  });

  @override
  State<CreateDealerAccount2ndPage> createState() =>
      _CreateDealerAccount2ndPageState();
}

class _CreateDealerAccount2ndPageState
    extends State<CreateDealerAccount2ndPage> {
  final nameController = TextEditingController();
  final referralController = TextEditingController();
  final passwordController = TextEditingController();

  final controller = Get.find<DealerCreateAccountController>();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.userData != null) {
        nameController.text = widget.userData!.fullName;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: commonAppBar(
        title: "Register",
        context: context,
        backGroundColor: AppColors.primaryColor,
        textColor: AppColors.white,
      ),
      bottomSheet: Column(
        children: [
          SizedBox(height: 10),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonTextfieldWithTitle(
                    "Your Name",
                    nameController,
                    hintText: "Enter your full name",
                  ),

                  const SizedBox(height: 16),

                  commonTextfieldWithTitle(
                    "How did you hear about us?",
                    referralController,
                    hintText: "Referral source",
                  ),

                  if (widget.userData == null) const SizedBox(height: 16),

                  if (widget.userData == null)
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

                  const SizedBox(height: 24),

                  Obx(() {
                    return commonButton(
                      "Submit",
                      isLoading: controller.isLoading.value,
                      onTap: () async {
                        await controller.signUp(
                          fullName: nameController.text,
                          businessName: widget.businessName,
                          businessType: widget.businessType,
                          email: widget.email,
                          postalCode: widget.postalCode,
                          address: widget.address,
                          password: passwordController.text,

                          phoneNumber: widget.phoneNumber,
                          coordinates: [widget.longitude, widget.latitude],
                          openingHours: widget.openingHours,
                          types: widget.types,
                          imageFile: widget.imageFile,
                          hearFrom: referralController.text,
                          next: () {
                            navigateToPage(
                              EmailVerificationScreen(),
                              context: context,
                            );
                          },
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
