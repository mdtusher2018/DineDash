import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLanguageSelector(BuildContext context) {
  final LocalStorageService localStorage = Get.find();
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonText(
              "Select Language",
              size: 18,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(
                Icons.language,
                color: AppColors.primaryColor,
              ),
              title: commonText('English'),
              onTap: () {
                Get.updateLocale(const Locale('en', 'US'));

                localStorage.saveString(StorageKey.languageCode, 'en');
                localStorage.saveString(StorageKey.postalCode, 'US');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.language,
                color: AppColors.primaryColor,
              ),
              title: commonText('Deutsch'),
              onTap: () {
                Get.updateLocale(const Locale('de', 'DE'));
                localStorage.saveString(StorageKey.languageCode, 'de');
                localStorage.saveString(StorageKey.postalCode, 'DE');
                Navigator.pop(context);
              },
            ),
            // Add more languages here
          ],
        ),
      );
    },
  );
}




Future<void> showDealerCreateDialog(
    BuildContext context,
  {required  VoidCallback onContinue}
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: commonText(
            "Are you sure to become a Dealer?".tr,
            size: 18,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: commonButton(
                    "Cancel".tr,
                    color: Color(0xFFDDDDDD),
                    textColor: Colors.black,
                    height: 40,
                    width: 100,
                    boarderRadious: 10,
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: commonButton(
                    "Continue",
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    height: 40,
                    boarderRadious: 10,
                    width: 100,
                    onTap: onContinue,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  
}




