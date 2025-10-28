class DealerBusinessModel {
  final String id;
  final String businessName;
  final String? image;
  final String? businessAddress;
  final double rating;
  final List<String> category;
  final int userRatingsTotal;
  final int redeemCount;
  final int totalReviews;
  final int activeDeals;
  final String?
  businessType; // Updated to capture the businessType field from JSON.
  final List<OpeningHour>?
  openingHours; // Added opening hours field to capture daily opening times.
  final String? phoneNumber;
  final String? postalCode;
  final String? createdAt;

  DealerBusinessModel({
    required this.id,
    required this.businessName,
    this.image,
    this.category = const [],
    this.businessAddress,
    required this.rating,
    required this.userRatingsTotal,
    required this.redeemCount,
    required this.totalReviews,
    required this.activeDeals,
    this.businessType,
    this.openingHours,
    this.phoneNumber,
    this.postalCode,
    this.createdAt,
  });

  factory DealerBusinessModel.fromJson(Map<String, dynamic> json) {
    return DealerBusinessModel(
      id: json['_id'] ?? '',
      businessName: json['businessName'] ?? '',
      image: json['image'],
      category: List<String>.from(json["types"] ?? []),
      businessAddress: json['businessAddress'],
      rating: (json['rating'] ?? 0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      redeemCount: json['redeemCount'] ?? 0,
      totalReviews: json['totalReviews'] ?? 0,
      activeDeals: json['activeDeals'] ?? json['dealCount'] ?? 0,
      businessType: json['businessType'], // Capture business type
      openingHours:
          json['openingHours'] != null
              ? (json['openingHours'] as List)
                  .map((e) => OpeningHour.fromJson(e))
                  .toList()
              : null, // Deserialize opening hours
      phoneNumber: json['formatted_phone_number'],
      postalCode: json['postalCode'],
      createdAt:
          json['createdAt']??"",
            
    );
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
