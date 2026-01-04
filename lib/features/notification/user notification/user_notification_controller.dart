import 'dart:developer';

import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/notification/user%20notification/user_notification_response.dart';
import 'package:dine_dash/features/ratting_and_feedback/user/user_giving_start_screen.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserNotificationController extends BaseController {
  final ApiService _apiService = Get.find();

  /// All fetched notifications
  var notifications = <NotificationItem>[].obs;

  /// Pagination tracking
  var currentPage = 1;
  var totalPages = 1;

  var isMoreLoading = false.obs;

  /// Fetch paginated notifications
  Future<void> fetchNotifications({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      notifications.clear();
    }

    if (isMoreLoading.value || isLoading.value) return;

    final isFirstPage = currentPage == 1;
    if (isFirstPage) {
      isLoading.value = true;
    } else {
      isMoreLoading.value = true;
    }

    await safeCall(
      task: () async {
        log("is user ${SessionMemory.isUser}");
        final response = await _apiService.get(
        (SessionMemory.isUser)?  ApiEndpoints.userNotifications(page: currentPage):
        ApiEndpoints.dealerNotifications(page: currentPage),
        );

        final parsed = NotificationResponse.fromJson(response);

        if (parsed.statusCode == 200 &&
            parsed.data?.attributes.notifications != null) {
          final items = parsed.data!.attributes.notifications;
          totalPages = parsed.data!.attributes.pagination.totalPages;

          if (currentPage == 1) {
            notifications.assignAll(items);
          } else {
            notifications.addAll(items);
          }

          if (currentPage < totalPages) {
            currentPage++;
          }
        } else {
          throw Exception(parsed.message);
        }
      },
    );
  }

  Future<void> markAsRead(String notificationId, BuildContext context) async {
    await safeCall(
      task: () async {
        await _apiService.put(
          ApiEndpoints.markNotificationAsRead(notificationId),
          {},
        );
        // Update local state
        final index = notifications.indexWhere((n) => n.id == notificationId);
        if (index != -1) {
          notifications[index] = NotificationItem(
            id: notifications[index].id,
            businessId: notifications[index].businessId,
            dealId: notifications[index].dealId,
            rasturentName: notifications[index].rasturentName,
            type: notifications[index].type,
            targetUser: notifications[index].targetUser,
            target: notifications[index].target,
            title: notifications[index].title,
            message: notifications[index].message,
            isRead: true,
            createdAt: notifications[index].createdAt,
            updatedAt: DateTime.now(),
          );
          notifications.refresh();
        }
        if (notifications[index].type == "rating") {
          navigateToPage(
            UserGivingStarsPage(
              businessId: notifications[index].businessId,
              dealId: notifications[index].dealId,
              rasturentName: notifications[index].rasturentName,
            ),
            replace: true,
            context: context,
          );
        } else {
          // ✅ Show toast/snackbar
          showSnackBar("This notification has been marked as read.".tr);
        }
      },
    );
  }

  Future<void> refreshNotifications() async {
    await fetchNotifications(refresh: true);
  }
}
