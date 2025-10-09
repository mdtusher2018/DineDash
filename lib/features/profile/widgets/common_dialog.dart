import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void showLanguageSelector(BuildContext context) {
  final box = GetStorage();
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
                box.write('langCode', 'en');
                box.write('countryCode', 'US');
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
                box.write('langCode', 'de');
                box.write('countryCode', 'DE');
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
