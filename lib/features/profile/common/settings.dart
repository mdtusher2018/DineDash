import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/profile/common/delete_account_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/profile/common/change%20password/change_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: commonText("General Settings".tr, size: 18, isBold: true),
        centerTitle: true,
      ),

      bottomSheet: Container(
        color: AppColors.white,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Security
              _buildSettingOption(
                icon: "assets/images/Lock 3.png",
                title: "Change Password".tr,
                iconColor: AppColors.primaryColor,
                haveArrow: true,
                onTap: () {
                  navigateToPage(ChangePasswordScreen());
                },
              ),

              // Help
              _buildSettingOption(
                icon: "assets/images/delete.png",
                title: "Delete Account".tr,
                iconColor: Colors.red,
                onTap: () {
                  navigateToPage(DeleteAccountScreen());
                  // showDeleteAccountDialog(context, () {
                  //   Navigator.pop(context);
                  // });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingOption({
    required String icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
    bool haveArrow = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),

        child: ListTile(
          leading: Image.asset(icon, color: iconColor, width: 20,fit: BoxFit.fill),
          title: commonText(title, size: 16, color: AppColors.black),
          trailing: (haveArrow) ? Icon(Icons.arrow_forward_ios_outlined) : null,
        ),
      ),
    );
  }


}