import 'package:dine_dash/core/models/business_model.dart';

class DealerBusinessDetailResponse {
  final String status;
  final int statusCode;
  final String message;
  final DealerBusinessDetailData? data;
  final List<dynamic> errors;

  DealerBusinessDetailResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
    this.errors = const [],
  });

  factory DealerBusinessDetailResponse.fromJson(Map<String, dynamic> json) {
    return DealerBusinessDetailResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? DealerBusinessDetailData.fromJson(json['data'])
          : null,
      errors: json['errors'] ?? [],
    );
  }
}

class DealerBusinessDetailData {
  final String type;
  final DealerBusinessAttributes? attributes;

  DealerBusinessDetailData({
    required this.type,
    this.attributes,
  });

  factory DealerBusinessDetailData.fromJson(Map<String, dynamic> json) {
    return DealerBusinessDetailData(
      type: json['type'] ?? '',
      attributes: json['attributes'] != null
          ? DealerBusinessAttributes.fromJson(json['attributes'])
          : null,
    );
  }
}

class DealerBusinessAttributes {
  final String id;
  final String name;
  final String? image;
  final String? formattedAddress;
  final double rating;
  final int userRatingsTotal;
  final int totalReview;
  final int redeemCount;
  final List<MenuItem> menuData;
  final List<DealData> dealsData;
  final List<FeedbackData> feedbacksData;
  final RatingCounts? ratingCounts;
  final int totalDealCount;
  final int totalMenuCount;
  final int activeDealCount;


  DealerBusinessAttributes({
    required this.id,
    required this.name,
    this.image,
    this.formattedAddress,
    required this.rating,
    required this.userRatingsTotal,
    required this.totalReview,
    required this.redeemCount,
    this.menuData = const [],
    this.dealsData = const [],
    this.feedbacksData = const [],
    this.ratingCounts,
    required this.totalDealCount,
    required this.totalMenuCount,
    required this.activeDealCount,
  });

  factory DealerBusinessAttributes.fromJson(Map<String, dynamic> json) {
    
    return DealerBusinessAttributes(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
      formattedAddress: json['formatted_address'],
      rating: (json['rating'] ?? 0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      totalReview: json['totalReview'] ?? 0,
      redeemCount: json['redeemCount'] ?? 0,
      menuData: (json['menuData'] as List<dynamic>? ?? [])
          .map((e) => MenuItem.fromJson(e))
          .toList(),
      dealsData: (json['dealsData'] as List<dynamic>? ?? [])
          .map((e) => DealData.fromJson(e))
          .toList(),
      feedbacksData: (json['feedbacksData'] as List<dynamic>? ?? [])
          .map((e) => FeedbackData.fromJson(e))
          .toList(),
      ratingCounts: json['ratingCounts'] != null
          ? RatingCounts.fromJson(json['ratingCounts'])
          : null,
      totalDealCount: json['totalDealCount'] ?? 0,
      totalMenuCount: json['totalMenuCount'] ?? 0,
      activeDealCount: json['activeDealCount'] ?? 0,
    );
  }
}

class MenuItem {
  final String id;
  final String businessId;
  final String itemName;
  final String description;
  final num price;
  final int v;

  MenuItem({
    required this.id,
    required this.businessId,
    required this.itemName,
    required this.description,
    required this.price,
    required this.v,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['_id'] ?? '',
      businessId: json['business'] ?? '',
      itemName: json['itemName'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      v: json['__v'] ?? 0,
    );
  }
}

class RatingCounts {
  final int rating1;
  final int rating2;
  final int rating3;
  final int rating4;
  final int rating5;


  RatingCounts({
    required this.rating1,
    required this.rating2,
    required this.rating3,
    required this.rating4,
    required this.rating5,
  });

  factory RatingCounts.fromJson(Map<String, dynamic> json) {
    return RatingCounts(
      rating1: json['rating1'] ?? 0,
      rating2: json['rating2'] ?? 0,
      rating3: json['rating3'] ?? 0,
      rating4: json['rating4'] ?? 0,
      rating5: json['rating5'] ?? 0,
    );
  }
}

extension RatingCountsExtension on RatingCounts {
  Map<int, double> get ratingPercentages {
    final total = rating1 + rating2 + rating3 + rating4 + rating5;
    if (total == 0) {
      return {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    }
    return {
      5: rating5 / total,
      4: rating4 / total,
      3: rating3 / total,
      2: rating2 / total,
      1: rating1 / total,
    };
  }
}


