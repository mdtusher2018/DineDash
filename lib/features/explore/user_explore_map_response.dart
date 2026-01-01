import 'package:intl/intl.dart';

class UserExploreMapResponse {
  final int status;
  final int statusCode;
  final String message;
  final List<BusinessOnMap> businesses;

  UserExploreMapResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.businesses,
  });

  factory UserExploreMapResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['attributes'] as List? ?? [];
    return UserExploreMapResponse(
      status: json['status'] ?? 0,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      businesses: data.map((e) => BusinessOnMap.fromJson(e)).toList(),
    );
  }
}

class BusinessOnMap {
  final String id;
  final String name;
  final String image;
  final String formattedAddress;
  final double rating;
  final int totalReview;
  final List<OpeningHour> openingHours;
  final List<double> coordinates;
  final List<dynamic> type;

  BusinessOnMap({
    required this.id,
    required this.name,
    required this.image,
    required this.formattedAddress,
    required this.rating,
    required this.totalReview,
    required this.openingHours,
    required this.coordinates,
    required this.type,
  });

  factory BusinessOnMap.fromJson(Map<String, dynamic> json) {
    final location = json['location'] ?? {};
    final coords =
        (location['coordinates'] as List?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [];

    final openingHoursList = json['openingHours'] as List? ?? [];
    List<OpeningHour> openingHours =
        openingHoursList.map((e) => OpeningHour.fromJson(e)).toList();

    return BusinessOnMap(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      formattedAddress: json['formatted_address'] ?? 'N/A',
      rating: json['rating']?.toDouble() ?? 0.0,
      totalReview: json['totalReview'] ?? 0,
      openingHours: openingHours,
      coordinates: coords,
      type: json['types'] ?? [],
    );
  }
  String get openTimeText {
    if (openingHours.isNotEmpty) {
      final now = DateTime.now();
      final currentDay = DateFormat('EEEE').format(now);

      const daysOfWeek = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      ];

      for (int i = 0; i < daysOfWeek.length; i++) {
        final currentIndex = daysOfWeek.indexOf(currentDay);

        for (int j = 0; j < openingHours.length; j++) {
          final first = openingHours[j];

          if (daysOfWeek.indexOf(first.day) > currentIndex) {
            String formatTime(String time24) {
              try {
                final dt = DateFormat("HH:mm").parse(time24);
                return DateFormat("h:mm a").format(dt);
              } catch (e) {
                return time24;
              }
            }

            final opening = formatTime(first.openingTime);
            final closing = formatTime(first.closingTime);
            return "$opening - $closing";
          }
        }
      }
    }

    return "Closed";
  }
}

class OpeningHour {
  final String day;
  final bool isOpen;
  final String openingTime;
  final String closingTime;

  OpeningHour({
    required this.day,
    required this.isOpen,
    required this.openingTime,
    required this.closingTime,
  });

  factory OpeningHour.fromJson(Map<String, dynamic> json) {
    return OpeningHour(
      day: json['day'] ?? '',
      isOpen: json['isOpen'] ?? false,
      openingTime: json['openingTime'] ?? '',
      closingTime: json['closingTime'] ?? '',
    );
  }
}
