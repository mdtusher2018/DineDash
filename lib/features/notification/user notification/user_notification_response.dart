import 'package:dine_dash/core/models/pagination_model.dart';

class NotificationResponse {
  final String status;
  final int statusCode;
  final String message;
  final NotificationData? data;
  final List<dynamic>? errors;

  NotificationResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
    this.errors,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data:
          json['data'] != null ? NotificationData.fromJson(json['data']) : null,
      errors: json['errors'] != null ? List<dynamic>.from(json['errors']) : [],
    );
  }
}

class NotificationData {
  final String type;
  final NotificationAttributes attributes;

  NotificationData({required this.type, required this.attributes});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      type: json['type'] ?? '',
      attributes: NotificationAttributes.fromJson(json['attributes'] ?? {}),
    );
  }
}

class NotificationAttributes {
  final List<NotificationItem> notifications;
  final Pagination pagination;

  NotificationAttributes({
    required this.notifications,
    required this.pagination,
  });

  factory NotificationAttributes.fromJson(Map<String, dynamic> json) {
    return NotificationAttributes(
      notifications:
          (json['notification'] as List<dynamic>?)
              ?.map((e) => NotificationItem.fromJson(e))
              .toList() ??
          [],
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }
}

class NotificationItem {
  final String id;
  final String type;
  final String businessId;
  final String dealId;
  final String rasturentName;
  final TargetUser targetUser;
  final String target;
  final LocalizedText title;
  final LocalizedText message;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationItem({
    required this.id,
    required this.type,
    required this.businessId,
    required this.dealId,
    required this.rasturentName,
    required this.targetUser,
    required this.target,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'] ?? '',
      type: json['type'] ?? "",
      businessId: json['businessId'] ?? "",
      dealId: json['dealId'] ?? "",
      rasturentName: json['businessName'] ?? "",
      targetUser: TargetUser.fromJson(json['targetUser'] ?? {}),
      target: json['target'] ?? '',
      title: LocalizedText.fromJson(json['title'] ?? {}),
      message: LocalizedText.fromJson(json['message'] ?? {}),
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class TargetUser {
  final String id;
  final String fullName;
  final String image;

  TargetUser({required this.id, required this.fullName, required this.image});

  factory TargetUser.fromJson(Map<String, dynamic> json) {
    return TargetUser(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class LocalizedText {
  final String en;
  final String de;

  LocalizedText({required this.en, required this.de});

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    return LocalizedText(en: json['en'] ?? '', de: json['de'] ?? '');
  }
}
