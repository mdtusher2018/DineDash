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
  final BusinessAttributes attributes;

  BusinessDetailData({
    required this.type,
    required this.attributes,
  });

  factory BusinessDetailData.fromJson(Map<String, dynamic> json) {
    return BusinessDetailData(
      type: json['type'] ?? '',
      attributes: BusinessAttributes.fromJson(json['attributes'] ?? {}),
    );
  }
}

class BusinessAttributes {
  final String id;
  final String name;
  final String? image;
  final List<String> types;
  final String? formattedAddress;
  final String? formattedPhoneNumber;
  final double rating;
  final int userRatingsTotal;
  final int totalReview;
  final List<OpeningHour> openingHours;
  final Location? location;
  final List<DealData> dealsData;
  final List<FeedbackData> feedbacksData;
  final bool isFavourite;

  BusinessAttributes({
    required this.id,
    required this.name,
    this.image,
    required this.types,
    this.formattedAddress,
    this.formattedPhoneNumber,
    required this.rating,
    required this.userRatingsTotal,
    required this.totalReview,
    required this.openingHours,
    this.location,
    required this.dealsData,
    required this.feedbacksData,
    required this.isFavourite,
  });

  factory BusinessAttributes.fromJson(Map<String, dynamic> json) {
    List<String> parseTypes(dynamic list) =>
        list != null ? List<String>.from(list.map((e) => e.toString())) : [];

    List<OpeningHour> parseOpeningHours(dynamic list) =>
        list != null ? (list as List).map((e) => OpeningHour.fromJson(e)).toList() : [];

    List<DealData> parseDeals(dynamic list) =>
        list != null ? (list as List).map((e) => DealData.fromJson(e)).toList() : [];

    List<FeedbackData> parseFeedbacks(dynamic list) =>
        list != null ? (list as List).map((e) => FeedbackData.fromJson(e)).toList() : [];

    return BusinessAttributes(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
      types: parseTypes(json['types']),
      formattedAddress: json['formatted_address'],
      formattedPhoneNumber: json['formatted_phone_number'],
      rating: (json['rating'] ?? 0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      totalReview: json['totalReview'] ?? 0,
      openingHours: parseOpeningHours(json['openingHours']),
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      dealsData: parseDeals(json['dealsData']),
      feedbacksData: parseFeedbacks(json['feedbacksData']),
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  /// 🔹 Convenience getters
  String get openTimeText {
    if (openingHours.isNotEmpty) {
      final first = openingHours.first;
      return "${first.openingTime} - ${first.closingTime}";
    }
    return "Closed";
  }

  String get phoneText => formattedPhoneNumber ?? "N/A";
  String get addressText => formattedAddress ?? "N/A";
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
      coordinates: (json['coordinates'] as List?)
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
  // Empty list, but structured for future use
  FeedbackData();

  factory FeedbackData.fromJson(Map<String, dynamic> json) {
    return FeedbackData();
  }
}
