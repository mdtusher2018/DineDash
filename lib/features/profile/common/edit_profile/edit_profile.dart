import 'dart:io';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dine_dash/features/profile/common/profile/profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({
    super.key,
    required this.profileImage,
    required this.name,
    required this.email,
    required this.postcode,
  });

  final String profileImage, name, email, postcode;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final postcodeController = TextEditingController();

  File? selectedImage;
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
    nameController.text = widget.name;
    postcodeController.text = widget.postcode;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: pickImage,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 48,
                              backgroundColor: AppColors.primaryColor,
                              backgroundImage:
                                  selectedImage != null
                                      ? FileImage(selectedImage!)
                                      : (widget.profileImage.isNotEmpty
                                          ? NetworkImage(
                                                getFullImagePath(
                                                  widget.profileImage,
                                                ),
                                              )
                                              as ImageProvider
                                          : const AssetImage(
                                            "assets/images/profileimage.png",
                                          )),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
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
                      enable: false, // email is not editable
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
              child: Obx(() {
                return commonButton(
                  "Save".tr,
                  isLoading: profileController.isLoading.value,
                  onTap: () async {
                    // Validate input
                    final fullName = nameController.text.trim();
                    final postcode = postcodeController.text.trim();

                    if (fullName.isEmpty) {
                      showSnackBar("Please enter your full name".tr);
                      return;
                    }

                    // Call updateProfile
                    await profileController.updateProfile(
                      fullName: fullName,
                      postalCode: postcode.isNotEmpty ? postcode : null,
                      image: selectedImage,
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
