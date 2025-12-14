class DealerDealDetailsData {
  final String id;
  final String description;
  final num benefitAmount;
  final String dealType;
  final int reuseableAfter;
  final int redeemCount;
  final int maxClaimCount;
  final bool isRedeemedBefore;
  final String? redeemedRedeemedAt;
  final int rating;
  final String businessName;
  final String businessImage;
  final String businessId;
  final List<String> businessCategories;
  final String businessAddress;
  final BusinessLocation businessLocation;
  final List<ActiveTime> activeTime;

  DealerDealDetailsData({
    required this.id,
    required this.description,
    required this.benefitAmount,
    required this.dealType,
    required this.reuseableAfter,
    required this.redeemCount,
    required this.maxClaimCount,
    required this.isRedeemedBefore,
    required this.redeemedRedeemedAt,
    required this.rating,
    required this.businessName,
    required this.businessImage,
    required this.businessId,
    required this.businessCategories,
    required this.businessAddress,
    required this.businessLocation,
    required this.activeTime,
  });

  // Factory method to parse JSON
  factory DealerDealDetailsData.fromJson(Map<String, dynamic> json) {
    return DealerDealDetailsData(
      id: json['_id'] ?? '',
      description: json['description'] ?? '',
      benefitAmount: json['benefitAmmount'] ?? 0,
      dealType: json['dealType'] ?? '',
      reuseableAfter: json['reuseableAfter'] ?? 0,
      redeemCount: json['redeemCount'] ?? 0,
      maxClaimCount: json['maxClaimCount'] ?? 0,
      isRedeemedBefore: json['isRedeemedBefore'] ?? false,
      redeemedRedeemedAt: json['redeemedRedeemedAt'],
      rating: json['rating'] ?? 0,
      businessName: json['businessName'] ?? '',
      businessImage: json['businessImage'] ?? '',
      businessId: json['businessId'] ?? '',
      businessCategories: List<String>.from(json['businessCategories'] ?? []),
      businessAddress: json['businessAddress'] ?? '',
      businessLocation: BusinessLocation.fromJson(
        json['businessLocation'] ?? {},
      ),
      activeTime:
          (json['activeTime'] as List<dynamic>? ?? [])
              .map((item) => ActiveTime.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}

// BusinessLocation class to represent the business location
class BusinessLocation {
  final String type;
  final List<double> coordinates;

  BusinessLocation({required this.type, required this.coordinates});

  factory BusinessLocation.fromJson(Map<String, dynamic> json) {
    return BusinessLocation(
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates'] ?? []),
    );
  }
}

// ActiveTime class to represent the active time details
class ActiveTime {
  final String day;
  final String startTime;
  final String endTime;
  final String id;

  ActiveTime({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.id,
  });

  factory ActiveTime.fromJson(Map<String, dynamic> json) {
    return ActiveTime(
      day: json['day'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}
