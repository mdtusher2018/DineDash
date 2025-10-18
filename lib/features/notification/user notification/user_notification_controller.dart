import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/notification/user%20notification/user_notification_response.dart';
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
        final response = await _apiService.get(
          ApiEndpoints.userNotifications(page: currentPage),
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

  Future<void> markAsRead(String notificationId) async {
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
        // ✅ Show toast/snackbar
        Get.snackbar(
          "Marked as Read".tr,
          "This notification has been marked as read.".tr,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          duration: const Duration(seconds: 2),
        );
      },
    );
  }

  Future<void> refreshNotifications() async {
    await fetchNotifications(refresh: true);
  }
}
