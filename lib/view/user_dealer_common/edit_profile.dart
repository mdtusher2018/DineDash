import 'package:flutter/material.dart';
import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/res/image_paths.dart';
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
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: commonText(
          "Edit Profile",
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
                      "Email",
                      emailController,
                      hintText: "Enter your email",
                      issuffixIconVisible: false,
                      enable: true,
                      textSize: 14.0,
                      assetIconPath: ImagePaths.emailIcon,
                    ),
                    const SizedBox(height: 16),
                    commonTextfieldWithTitle(
                      "Full name",
                      nameController,
                      hintText: "Enter your name",
                      issuffixIconVisible: false,
                      enable: true,
                      textSize: 14.0,
                      keyboardType: TextInputType.name,
                      assetIconPath: ImagePaths.userIcon,
                    ),
                    const SizedBox(height: 16),
                    commonTextfieldWithTitle(
                      "Postcode",
                      postcodeController,
                      hintText: "Enter your postcode",
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
              child: commonButton("Save",onTap: () {
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
