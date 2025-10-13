class HomeResponse {
  final String status;
  final int statusCode;
  final String message;
  final HomeData? data;

  HomeResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? HomeData.fromJson(json['data']) : null,
    );
  }
}

class HomeData {
  final List<Restaurant> restaurants;
  final List<Restaurant> activities;
  final List<Restaurant> hotDeals;
  final List<Restaurant> topRated;
  final List<Restaurant> newRestaurants;

  HomeData({
    required this.restaurants,
    required this.activities,
    required this.hotDeals,
    required this.topRated,
    required this.newRestaurants,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    List<Restaurant> parseRestaurants(dynamic list) =>
        list != null ? (list as List).map((e) => Restaurant.fromJson(e)).toList() : [];

    List<Restaurant> parseActivities(dynamic list) =>
        list != null ? (list as List).map((e) => Restaurant.fromJson(e)).toList() : [];

    return HomeData(
      restaurants: parseRestaurants(json['attributes']?['restaurants']),
      activities: parseActivities(json['attributes']?['activities']),
      hotDeals: parseRestaurants(json['attributes']?['hotDeals']),
      topRated: parseRestaurants(json['attributes']?['topRated']),
      newRestaurants: parseRestaurants(json['attributes']?['newRestaurants']),
    );
  }
}

// ------------------- Restaurant Model -------------------

class Restaurant {
  final String id;
  final String userId;
  final String name;
  final String? image;
  final String? formattedAddress;
  final String? postalCode;
  final double rating;
  final int userRatingsTotal;
  final int redeemCount;
  final List<OpeningHour> openingHours;
  final List<Deal> deals;
  final PriceRange priceRange;

  Restaurant({
    required this.id,
    required this.userId,
    required this.name,
    this.image,
    this.formattedAddress,
    this.postalCode,
    required this.rating,
    required this.userRatingsTotal,
    required this.redeemCount,
    required this.openingHours,
    required this.deals,
    required this.priceRange,
  });

  String get priceRangeText {
    if (priceRange.min != null && priceRange.max != null) {
      return "€${priceRange.min}-${priceRange.max}";
    }
    return "N/A";
  }

  /// Computed property: Open Time string
  String get openingHoursText {
    if (openingHours.isNotEmpty) {
      final firstHour = openingHours.first;
      return "${firstHour.openingTime} - ${firstHour.closingTime}";
    }
    return "Closed";
  }




  factory Restaurant.fromJson(Map<String, dynamic> json) {
    List<OpeningHour> parseOpeningHours(dynamic list) =>
        list != null ? (list as List).map((e) => OpeningHour.fromJson(e)).toList() : [];

    List<Deal> parseDeals(dynamic list) =>
        list != null ? (list as List).map((e) => Deal.fromJson(e)).toList() : [];

    return Restaurant(
      id: json['_id'] ?? '',
      userId: json['user'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
      formattedAddress: json['formatted_address'],
      postalCode: json['postalCode'],
      rating: (json['rating'] ?? 0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      redeemCount: json['redeemCount'] ?? 0,
      openingHours: parseOpeningHours(json['openingHours']),
      deals: parseDeals(json['deals']),
      priceRange: json['priceRange'] != null ? PriceRange.fromJson(json['priceRange']) : PriceRange(min: 0,max: 0),
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

class Deal {
  final String dealType;

  Deal({required this.dealType});

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(dealType: json['dealType'] ?? '');
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
