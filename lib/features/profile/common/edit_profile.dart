import 'package:flutter/material.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:get/get.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final postcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        elevation: 1,
        centerTitle: true,
        title: commonText(
          "Edit Profile".tr,
          size: 20,
          isBold: true,
          color: Colors.black87,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 48,
                              backgroundColor: AppColors.primaryColor,
                              backgroundImage: const AssetImage(
                                "assets/images/profileimage.png",
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    commonTextfieldWithTitle(
                      "Email".tr,
                      emailController,
                      hintText: "Enter your email".tr,
                      issuffixIconVisible: false,
                      enable: true,
                      textSize: 14.0,
                      assetIconPath: ImagePaths.emailIcon,
                    ),
                    const SizedBox(height: 16),
                    commonTextfieldWithTitle(
                      "Full name".tr,
                      nameController,
                      hintText: "Enter your name".tr,
                      issuffixIconVisible: false,
                      enable: true,
                      textSize: 14.0,
                      keyboardType: TextInputType.name,
                      assetIconPath: ImagePaths.userIcon,
                    ),
                    const SizedBox(height: 16),
                    commonTextfieldWithTitle(
                      "Postcode".tr,
                      postcodeController,
                      hintText: "Enter your postcode".tr,
                      issuffixIconVisible: false,
                      enable: true,
                      textSize: 14.0,
                      keyboardType: TextInputType.number,
                      assetIconPath: ImagePaths.locationIcon,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: commonButton("Save".tr,onTap: () {
                Get.back();
              },),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
