class DealerFeedBackResponse {
  final String status;
  final num statusCode;
  final String message;
  final DealerFeedBackAttributes feedBackAttributes;
  final List<dynamic> errors;

  DealerFeedBackResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.feedBackAttributes,
    required this.errors,
  });

  factory DealerFeedBackResponse.fromJson(Map<String, dynamic> json) {
    // Safely access nested maps, allowing null and defaulting to empty map
    final Map<String, dynamic> dataJson =
        (json['data'] is Map<String, dynamic> ? json['data'] : null) ??
            <String, dynamic>{};
    final Map<String, dynamic> attributesJson =
        (dataJson['attributes'] is Map<String, dynamic>
                ? dataJson['attributes']
                : null) ??
            <String, dynamic>{};

    // Use toString() for strings, and .toNum() for nums (implicitly handles int/double)
    return DealerFeedBackResponse(
      status: json['status']?.toString() ?? '',
      // Directly check type and use value or convert it to num
      statusCode: (json['statusCode'] is num) ? json['statusCode'] : 0,
      message: json['message']?.toString() ?? '',
      feedBackAttributes: DealerFeedBackAttributes.fromJson(attributesJson),
      errors: (json['errors'] is List<dynamic> ? json['errors'] : null) ??
          <dynamic>[],
    );
  }
}

// -----------------------------------------------------------------------------

class DealerFeedBackAttributes {
  final num totalReview;
  final num userRatingsTotal;
  final num businessRating;
  final List<DealerFeedBackItem> data;
  final num total;
  final List<RatingGroup> ratingGroups;

  DealerFeedBackAttributes({
    required this.totalReview,
    required this.userRatingsTotal,
    required this.businessRating,
    required this.data,
    required this.total,
    required this.ratingGroups,
  });

  factory DealerFeedBackAttributes.fromJson(Map<String, dynamic> json) {
    // Safely access lists, providing an empty list as a default
    final List<dynamic> dataList =
        (json['data'] is List<dynamic> ? json['data'] : null) ?? <dynamic>[];
    final List<DealerFeedBackItem> dealerFeedBackItems = dataList
        .whereType<Map<String, dynamic>>()
        .map((e) => DealerFeedBackItem.fromJson(e))
        .toList();

    final List<dynamic> ratingGroupsList =
        (json['ratingGroups'] is List<dynamic> ? json['ratingGroups'] : null) ??
            <dynamic>[];
    final List<RatingGroup> groups = ratingGroupsList
        .whereType<Map<String, dynamic>>()
        .map((e) => RatingGroup.fromJson(e))
        .toList();

    // Use explicit type check for num values
    num safeNum(dynamic value) => (value is num) ? value : 0;

    return DealerFeedBackAttributes(
      totalReview: safeNum(json['totalReview']),
      userRatingsTotal: safeNum(json['user_ratings_total']),
      businessRating: safeNum(json['businessRating']),
      data: dealerFeedBackItems,
      total: safeNum(json['total']),
      ratingGroups: groups,
    );
  }
}

// -----------------------------------------------------------------------------

class DealerFeedBackItem {
  final String id;
  final String type;
  final num rating;
  final String text;
  final String createdAt;
  final String dealType;
  final String dealId;
  final String businessName;
  final String business;
  final String reviewerFullName;
  final String reviewerImage;

  DealerFeedBackItem({
    required this.id,
    required this.type,
    required this.rating,
    required this.text,
    required this.createdAt,
    required this.dealType,
    required this.dealId,
    required this.businessName,
    required this.business,
    required this.reviewerFullName,
    required this.reviewerImage,
  });

  factory DealerFeedBackItem.fromJson(Map<String, dynamic> json) {
    
    num safeNum(dynamic value) => (value is num) ? value : 0;

    return DealerFeedBackItem(
      // Use null-aware access and toString() for strings
      id: json['_id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      rating: safeNum(json['rating']),
      text: json['text']?.toString() ?? '',
      createdAt: json['createdAt']??"",
      dealType: json['dealType']?.toString() ?? '',
      dealId: json['dealId']?.toString() ?? '',
      businessName: json['businessName']?.toString() ?? '',
      business: json['business']?.toString() ?? '',
      reviewerFullName: json['reviewerFullName']?.toString() ?? '',
      reviewerImage: json['reviewerImage']?.toString() ?? '',
    );
  }
}

// -----------------------------------------------------------------------------

class RatingGroup {
  final num id;
  final num count;

  RatingGroup({
    required this.id,
    required this.count,
  });

  factory RatingGroup.fromJson(Map<String, dynamic> json) {
    // Use explicit type check for num values
    num safeNum(dynamic value) => (value is num) ? value : 0;
    
    return RatingGroup(
      id: safeNum(json['_id']),
      count: safeNum(json['count']),
    );
  }
}