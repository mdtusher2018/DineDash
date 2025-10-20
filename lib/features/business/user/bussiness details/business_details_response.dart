
import 'package:dine_dash/core/models/business_model.dart';
import 'package:intl/intl.dart';

class BusinessDetailResponse {
  final String status;
  final int statusCode;
  final String message;
  final BusinessDetailData data;

  BusinessDetailResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory BusinessDetailResponse.fromJson(Map<String, dynamic> json) {
    return BusinessDetailResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: BusinessDetailData.fromJson(json['data'] ?? {}),
    );
  }
}

class BusinessDetailData {
  final String type;
  final BusinessModel attributes;

  BusinessDetailData({required this.type, required this.attributes});

  factory BusinessDetailData.fromJson(Map<String, dynamic> json) {
    return BusinessDetailData(
      type: json['type'] ?? '',
      attributes: BusinessModel.fromJson(json['attributes'] ?? {}),
    );
  }
}



extension BusinessOpeningHoursExtension on BusinessModel {

  Map<String, String> get formattedOpeningHours {
    final Map<String, String> hoursMap = {};
    final daysOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    for (var day in daysOfWeek) {
      final entry = openingHours.firstWhere(
        (e) => e.day == day,
        orElse: () => OpeningHour(
          day: day,
          isOpen: false,
          openingTime: "",
          closingTime: "",
        ),
      );

      if (!entry.isOpen || entry.openingTime.isEmpty || entry.closingTime.isEmpty) {
        hoursMap[day] = "Closed";
      } else {
        String formatTime(String time24) {
          try {
            final dt = DateFormat("HH:mm").parse(time24);
            return DateFormat("h:mm a").format(dt);
          } catch (e) {
            return time24;
          }
        }

        hoursMap[day] = "${formatTime(entry.openingTime)} - ${formatTime(entry.closingTime)}";
      }
    }

    return hoursMap;
  }
}
