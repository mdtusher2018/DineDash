import 'dart:io';

import 'package:dine_dash/core/models/user_model.dart';
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_dealer_account_controller.dart';

class CreateDealerAccount3rdPage extends StatefulWidget {
  final dynamic businessDetails;
  final UserModel? userData;
  final String email;
  final double? longitude, latitude;

  final String name;
  final List<String> types;
  final String businessType;
  final String address;
  final String phoneNumber;
  final String postalCode;
  final List<Map<String, dynamic>> openingHours;
  final List<double> coordinates;
  final File imageFile;

  const CreateDealerAccount3rdPage({
    super.key,
    required this.businessDetails,
    required this.userData,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.types,
    required this.businessType,
    required this.address,
    required this.phoneNumber,
    required this.postalCode,
    required this.openingHours,
    required this.coordinates,
    required this.imageFile,
  });

  @override
  State<CreateDealerAccount3rdPage> createState() =>
      _CreateDealerAccount3rdPageState();
}

class _CreateDealerAccount3rdPageState
    extends State<CreateDealerAccount3rdPage> {
  final businessController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final referralController = TextEditingController();

  final controller = Get.find<DealerCreateAccountController>();

  String? selectedBusinessType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    businessController.text =
        widget.businessDetails['displayName']?['text'] ?? 'Unknown';
    addressController.text =
        widget.businessDetails['shortFormattedAddress'] ?? '';
    phoneController.text =
        widget.businessDetails['internationalPhoneNumber'] ?? '';
    emailController.text = widget.email;
    if (widget.userData != null) {
      nameController.text = widget.userData!.fullName;
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
                    "Business",
                    businessController,
                    enable: false,
                  ),
                  SizedBox(height: 16),
                  commonTextfieldWithTitle(
                    "Business Address",
                    addressController,
                    enable: false,
                  ),

                  SizedBox(height: 16),
                  commonTextfieldWithTitle(
                    "Your Email",
                    emailController,
                    hintText: "Enter your email",
                    enable: false,
                  ),

                  const SizedBox(height: 16),

                  commonTextfieldWithTitle(
                    "Your Phone Number",
                    phoneController,
                    hintText: "Phone number with country code",
                  ),
                  SizedBox(height: 16),
                  commonTextfieldWithTitle(
                    "Your Name",
                    nameController,
                    hintText: "Enter your full name",
                  ),
                  const SizedBox(height: 16),

                  if (widget.userData == null)
                    commonTextfieldWithTitle(
                      "How did you hear about us?",
                      referralController,
                      hintText: "Referral source",
                    ),
                  const SizedBox(height: 24),

                  Obx(() {
                    return commonButton(
                      "Submit",
                      isLoading: controller.isLoading.value,
                      onTap: () async {},
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

  void showPendingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismiss on tap outside
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wrap content
              children: [
                const SizedBox(height: 16),
                commonText(
                  "Your request is under review. You will get a notification after acceptance.",
                  size: 16,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                commonButton(
                  "Go to Customer",
                  height: 40,
                  onTap: () {
                    Navigator.pop(context); // Close the dialog
                    navigateToPage(DealerRootPage());
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
