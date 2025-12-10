// ignore_for_file: must_be_immutable

import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/notification/user%20notification/user_notification_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserNotificationsPage extends StatelessWidget {
  UserNotificationsPage({super.key});

  final UserNotificationController controller =
      Get.find<UserNotificationController>();

  @override
  Widget build(BuildContext context) {
    // Fetch notifications initially
    controller.fetchNotifications();

    return Scaffold(
      appBar: commonAppBar(title: "Notification".tr,context: context),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return _noNotificationsView();
        }

        return NotificationList(controller: controller);
      }),
    );
  }

  Widget _noNotificationsView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            Image.asset(
              'assets/images/no_notification.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),
            commonText("There’s no notifications".tr, size: 21, isBold: true),
            const SizedBox(height: 10),
            commonText(
              "Your notifications will appear on this page.".tr,
              size: 16,
              color: Colors.black54,
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class NotificationList extends StatefulWidget {
  final UserNotificationController controller;

  const NotificationList({super.key, required this.controller});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    /// Infinite Scroll Pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !widget.controller.isMoreLoading.value &&
          widget.controller.currentPage <= widget.controller.totalPages) {
        widget.controller.fetchNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.controller.refreshNotifications,
      child: Obx(() {
        final notifications = widget.controller.notifications;

        return ListView.separated(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          separatorBuilder:
              (context, index) => Container(
                color: AppColors.white,
                width: double.infinity,
                height: 3,
              ),
          itemCount:
              notifications.length +
              (widget.controller.isMoreLoading.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == notifications.length) {
              // Pagination loader at bottom
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final n = notifications[index];
            bool isRead = n.isRead;
            String timeAgo = _formatTimeAgo(n.createdAt);

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(
                Icons.notifications_active,
                size: 32,
                color: AppColors.primaryColor,
              ),
              title: commonText(n.title.en, size: 16, isBold: true),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  commonText(n.message.en, size: 13, color: Colors.black87),
                  const SizedBox(height: 4),
                  commonText(
                    timeAgo,
                    isBold: true,
                    size: 12,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
              tileColor: isRead ? Colors.white : const Color(0xFFB7CDF5),
              onTap: () {
                if (!isRead) {
                  widget.controller.markAsRead(n.id);
                }
              },
            );
          },
        );
      }),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
