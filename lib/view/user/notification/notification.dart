// ignore_for_file: must_be_immutable

import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserNotificationsPage extends StatelessWidget {
  UserNotificationsPage({super.key});

  List<String> notification = [""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Notification".tr),
      body:
          (notification.isEmpty)
              ? _noNotificationsView()
              : ListView.separated(
                separatorBuilder:
                    (context, index) => Container(
                      color: AppColors.white,
                      width: double.infinity,
                      height: 3,
                    ),
                itemCount: 10, // You can adjust this based on your data
                itemBuilder: (context, index) {
                  // Simulate whether a notification is read or not (use real data in actual app)
                  bool isRead =
                      index >
                      2; // Just an example: alternate between read and unread

                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(
                      Icons.notifications_active,
                      size: 32,
                      color:
                          AppColors
                              .primaryColor, // Different color based on read/unread
                    ),
                    title: commonText(
                      'New Notification #${index + 1}',
                      size: 16,
                      isBold: true,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        commonText(
                          '{minutes} minutes ago'.trParams({'minutes': '16'}),
                          
                          // Example usage of translation with parameters
                          // 'just now'.tr
                          // '{hours} hours ago'.trParams({'hours': '3'})
                          // '{days} days ago'.trParams({'days': '2'})

                          isBold: true,
                          size: 12,
                          color:
                              Colors
                                  .black87, // Subtitle color change based on read/unread
                        ),
                      ],
                    ),
                    tileColor:
                        isRead
                            ? AppColors.white
                            : Color(
                              0xFFB7CDF5,
                            ), // Background color for read/unread
                  );
                },
              ),
    );
  }

  Widget _noNotificationsView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Image.asset(
              'assets/images/no_notification.png', // Update this with your image path
              width: 100, // Adjust the size as needed
              height: 100,
            ),
            const SizedBox(height: 20),

            commonText("There’s no notifications".tr, size: 21, isBold: true),
            const SizedBox(height: 10),
            // Text for "Your notifications will appear on this page"
            commonText(
              "Your notifications will appear on this page.".tr,
              size: 18,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
