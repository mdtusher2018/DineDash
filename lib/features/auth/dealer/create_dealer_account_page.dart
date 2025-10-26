
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/google_location_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_dealer_account_controller.dart';

class CreateDealerAccount extends StatefulWidget {
  const CreateDealerAccount({super.key});

  @override
  State<CreateDealerAccount> createState() => _CreateDealerAccountState();
}

class _CreateDealerAccountState extends State<CreateDealerAccount> {
  final businessController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final referralController = TextEditingController();

  final controller = Get.find<DealerCreateAccountController>();

final latitude = RxnDouble();
final longitude = RxnDouble();


  List<String> businessTypes = [
    "restaurant",
    "cafe",
    "bakery",
    "bar",
    "meal_takeaway",
    "meal_delivery",
    "food",
  ];
  String? selectedBusinessType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: commonText(
          "Register",
          size: 21,
          isBold: true,
          color: AppColors.white,
        ),
        centerTitle: true,
      ),
      bottomSheet: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: commonText(
              "Fill the information accourding to\nyour google business",
              size: 18,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Business Name
                  commonTextfieldWithTitle(
                    "Business Name",
                    businessController,
                    hintText: "Search your business",
                  ),
                  const SizedBox(height: 16),

                  // Address Picker
                  GoogleLocationPicker(
                    label: "Business Detailed Address",
                    controller: addressController,
                    onPicked: (lat, lng, address) {
                      addressController.text = address;
                      longitude.value=lng;
                      latitude.value=lat;
                    },
                  ),
                  const SizedBox(height: 16),

                  Obx(() {
                    return commonButton(
                      "Next",
                      isLoading: controller.isLoading.value,
                      onTap: () async {
                        controller.fetchBusinessFromGoogle(
                          businessController: businessController,
                          addressController: addressController,
                latitude: latitude.value,
                longitude: longitude.value,
                    fromSignup:true
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
