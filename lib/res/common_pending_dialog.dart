import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/profile/common/profile/profile_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showPendingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismiss on tap outside
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  Navigator.pop(context);
                  Get.find<ProfileController>().logOut(context);
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
