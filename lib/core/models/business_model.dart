import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class BusinessModel {
  final String id;
  final String name;
  final String? image;
  final List<String> types;
  final String? formattedAddress;
  final String? postalCode;
  final String? formattedPhoneNumber;
  final double rating;
  final int userRatingsTotal;
  final int totalReview;
  final int redeemCount;
  final List<OpeningHour> openingHours;
  final Location? location;
  final List<DealData> deals;
  final List<FeedbackData>? feedbacks;
  bool isFavourite;
  final PriceRange? priceRange;

  BusinessModel({
    required this.id,
    required this.name,
    this.image,
    this.types = const [],
    this.formattedAddress,
    this.postalCode,
    this.formattedPhoneNumber,
    required this.rating,
    required this.userRatingsTotal,
    this.totalReview = 0,
    this.redeemCount = 0,
    required this.openingHours,
    this.location,
    required this.deals,
    this.feedbacks,
    this.isFavourite = false,
    this.priceRange,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    List<String> parseTypes(dynamic list) =>
        list != null ? List<String>.from(list.map((e) => e.toString())) : [];

    List<OpeningHour> parseOpeningHours(dynamic list) =>
        list != null
            ? (list as List).map((e) => OpeningHour.fromJson(e)).toList()
            : [];

    List<DealData> parseDeals(dynamic list) =>
        list != null
            ? (list as List).map((e) => DealData.fromJson(e)).toList()
            : [];

    List<FeedbackData>? parseFeedbacks(dynamic list) =>
        list != null
            ? (list as List).map((e) => FeedbackData.fromJson(e)).toList()
            : null;

    return BusinessModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
      types: parseTypes(json['types']),
      formattedAddress: json['formatted_address'],
      postalCode: json['postalCode'],
      formattedPhoneNumber: json['formatted_phone_number'],
      rating: (json['rating'] ?? 0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      totalReview: json['totalReview'] ?? 0,
      redeemCount: json['redeemCount'] ?? 0,
      openingHours: parseOpeningHours(json['openingHours']),
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      deals: parseDeals(json['dealsData'] ?? json['deals']),
      feedbacks: parseFeedbacks(json['feedbacksData']),
      isFavourite: json['isFavourite'] ?? false,
      priceRange:
          json['priceRange'] != null
              ? PriceRange.fromJson(json['priceRange'])
              : null,
    );
  }

  /// Convenience getters

  String get openTimeText {
    if (openingHours.isNotEmpty) {
      final first = openingHours.first;

      String formatTime(String time24) {
        try {
          final dt = DateFormat("HH:mm").parse(time24);
          return DateFormat("h:mm a").format(dt); // converts to AM/PM
        } catch (e) {
          return time24; // fallback
        }
      }

      final opening = formatTime(first.openingTime);
      final closing = formatTime(first.closingTime);
      return first.isOpen ? "$opening - $closing" : "Closed";
    }
    return "Closed";
  }

  String get phoneText =>
      (formattedPhoneNumber != null && formattedPhoneNumber!.isNotEmpty)
          ? formattedPhoneNumber!
          : "N/A";

  String get addressText => formattedAddress ?? "N/A";

  String get priceRangeText {
    if (priceRange != null &&
        priceRange!.min != null &&
        priceRange!.max != null) {
      return "€${priceRange!.min}-${priceRange!.max}";
    }
    return "N/A";
  }

  Future<String> get distanceFromCurrentUser async {
    if (location == null || location!.coordinates.length < 2) {
      return "N/A";
    }
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final lat = location!.coordinates[1]; // GeoJSON format [lon, lat]
      final lon = location!.coordinates[0];

      double distanceInMeters = Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        lat,
        lon,
      );

      if (distanceInMeters >= 1000) {
        return "${(distanceInMeters / 1000).toStringAsFixed(1)} km";
      } else {
        return "${distanceInMeters.toStringAsFixed(0)} m";
      }
    } catch (e) {
      return "N/A";
    }
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

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates:
          (json['coordinates'] as List?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
    );
  }
}

class DealData {
  final String id;
  final String description;
  final num benefitAmount;
  final String dealType;
  final int reuseableAfter;
  final int redeemCount;
  final bool isActive;

  DealData({
    required this.id,
    required this.description,
    required this.benefitAmount,
    required this.dealType,
    required this.reuseableAfter,
    required this.redeemCount,
    required this.isActive,
  });

  factory DealData.fromJson(Map<String, dynamic> json) {
    return DealData(
      id: json['_id'] ?? '',
      description: json['description'] ?? '',
      benefitAmount: json['benefitAmmount'] ?? 0,
      dealType: json['dealType'] ?? '',
      reuseableAfter: json['reuseableAfter'] ?? 0,
      redeemCount: json['redeemCount'] ?? 0,
      isActive: json['isActive'] ?? false,
    );
  }
}

class FeedbackData {
  final String id;
  final num rating;
  final String text;
  final String createdAt;
  final ReviewerData reviewer;

  FeedbackData({
    required this.id,
    required this.rating,
    required this.text,
    required this.createdAt,
    required this.reviewer,
  });

  factory FeedbackData.fromJson(Map<String, dynamic> json) {
    return FeedbackData(
      id: json['_id'] ?? '',
      rating: json['rating'] ?? 0,
      text: json['text'] ?? '',
      createdAt: json['createdAt'] ?? '',
      reviewer:
          json['reviewerData'] != null
              ? ReviewerData.fromJson(json['reviewerData'])
              : ReviewerData(id: '', fullName: 'Unknown', image: ''),
    );
  }
}

class ReviewerData {
  final String id;
  final String fullName;
  final String image;

  ReviewerData({required this.id, required this.fullName, required this.image});

  factory ReviewerData.fromJson(Map<String, dynamic> json) {
    return ReviewerData(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? 'Unknown',
      image: json['image'] ?? '',
    );
  }
}

class PriceRange {
  final double? min;
  final double? max;

  PriceRange({this.min, this.max});

  factory PriceRange.fromJson(Map<String, dynamic> json) {
    return PriceRange(
      min: json['min'] != null ? (json['min'] as num).toDouble() : null,
      max: json['max'] != null ? (json['max'] as num).toDouble() : null,
    );
  }
}
