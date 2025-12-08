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
  final double? longitude, latitude;

  const CreateDealerAccount2ndPage({
    super.key,
    required this.businessDetails,
    required this.userData,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.businessName,
    required this.address,
  });

  @override
  State<CreateDealerAccount2ndPage> createState() =>
      _CreateDealerAccount2ndPageState();
}

class _CreateDealerAccount2ndPageState
    extends State<CreateDealerAccount2ndPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final referralController = TextEditingController();
  final passwordController = TextEditingController();

  final controller = Get.find<DealerCreateAccountController>();

  String? selectedBusinessType;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    emailController.text = widget.email;
    if (widget.userData != null) {
      nameController.text = widget.userData!.fullName;
    }
    if (widget.businessDetails?.phoneNumber != null) {
      phoneController.text = widget.businessDetails!.phoneNumber!;
    }

    // Optional: business type mapping
    if (widget.businessDetails!.types != null &&
        widget.businessDetails!.types!.contains(PlaceType.RESTAURANT)) {
      selectedBusinessType = "Restaurant";
    } else {
      selectedBusinessType ??= "Activity";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: commonAppBar(
        title: "Register",
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
                    "Your Phone Number",
                    phoneController,
                    hintText: "Phone number with country code",
                  ),
                  SizedBox(height: 16),
                  commonText(
                    "Business Type*",
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8),
                  commonDropdown<String>(
                    items: const ["Restaurant", "Activity"],
                    value: selectedBusinessType,
                    hint: "Select your business".tr,
                    onChanged: (val) {
                      setState(() => selectedBusinessType = val);
                    },
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
                        if (selectedBusinessType == null) {
                          showSnackBar("Please sellect a Business Type");
                          return;
                        }
                        await controller.signUp(
                          fullName: nameController.text,
                          businessName: widget.businessName,
                          businessType: selectedBusinessType!,
                          email: widget.email,
                          postalCode:
                              (widget.businessDetails?.addressComponents !=
                                      null)
                                  ? widget.businessDetails?.addressComponents!
                                      .firstWhere(
                                        (c) => c.types.contains("postal_code"),
                                      )
                                      .name
                                  : null,
                          address: widget.address,
                          password: passwordController.text,
                          confirlPassword: passwordController.text,
                          phoneNumber: phoneController.text,
                          next: () {
                            navigateToPage(EmailVerificationScreen());
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
