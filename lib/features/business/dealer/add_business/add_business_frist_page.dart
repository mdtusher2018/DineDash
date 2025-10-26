import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/business/dealer/add_business/dealer_business_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/google_location_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBusinessScreenFrist extends StatefulWidget {
  const AddBusinessScreenFrist({super.key});

  @override
  _AddBusinessScreenFristState createState() => _AddBusinessScreenFristState();
}

class _AddBusinessScreenFristState extends State<AddBusinessScreenFrist> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final controller = Get.find<DealerAddBusinessController>();

  final selectedLat = RxnDouble();
  final selectedLng = RxnDouble();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Add Business"),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Basic Information", size: 16, isBold: true),
            const SizedBox(height: 8),

            commonTextfieldWithTitle(
              "Business Name*",
              businessNameController,
              hintText: "Enter your restaurant name",
            ),

            const SizedBox(height: 16),
            GoogleLocationPicker(
              controller: addressController,
              onPicked: (lat, lng, address) {
                selectedLat.value = lat;
                selectedLng.value = lng;
                addressController.text = address;
              },
            ),

            SizedBox(height: 16),
            Obx(() {
              return commonButton(
                "Search",
                isLoading: controller.isLoading.value,
                onTap: () {
                  controller.fetchBusinessFromGoogle(
                    businessController: businessNameController,
                    addressController: addressController,
                    latitude: selectedLat.value,
                    longitude: selectedLng.value,

                    fromSignup: false,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
