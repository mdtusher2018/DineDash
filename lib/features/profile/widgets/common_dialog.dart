import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLanguageSelector(BuildContext context) {
  final LocalStorageService _localStorage = Get.find();
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

                _localStorage.saveString(StorageKey.languageCode, 'en');
                _localStorage.saveString(StorageKey.countryCode, 'US');
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
                _localStorage.saveString(StorageKey.languageCode, 'de');
                _localStorage.saveString(StorageKey.countryCode, 'DE');
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
