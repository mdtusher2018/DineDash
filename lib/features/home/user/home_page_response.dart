import 'package:dine_dash/core/models/business_model.dart';

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
  final List<BusinessModel> restaurants;
  final List<BusinessModel> activities;
  final List<BusinessModel> hotDeals;
  final List<BusinessModel> topRated;
  final List<BusinessModel> newRestaurants;

  final List<String> quotesImages;

  HomeData({
    required this.restaurants,
    required this.activities,
    required this.hotDeals,
    required this.topRated,
    required this.newRestaurants,
    required this.quotesImages,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    List<BusinessModel> parseRestaurants(dynamic list) =>
        list != null
            ? (list as List).map((e) => BusinessModel.fromJson(e)).toList()
            : [];

    List<BusinessModel> parseActivities(dynamic list) =>
        list != null
            ? (list as List).map((e) => BusinessModel.fromJson(e)).toList()
            : [];

    List<String> parseQuotes(dynamic list) {
      if (list == null) return [];
      return (list as List)
          .map((e) => e['image']?.toString() ?? '')
          .where((url) => url.isNotEmpty)
          .toList();
    }

    return HomeData(
      restaurants: parseRestaurants(json['attributes']?['restaurants']),
      activities: parseActivities(json['attributes']?['activities']),
      hotDeals: parseRestaurants(json['attributes']?['hotDeals']),
      topRated: parseRestaurants(json['attributes']?['topRated']),
      newRestaurants: parseRestaurants(json['attributes']?['newRestaurants']),
      quotesImages: parseQuotes(json['attributes']?['quotes']),
    );
  }
}
