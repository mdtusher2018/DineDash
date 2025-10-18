import 'package:dine_dash/model/business_model.dart';
import 'package:dine_dash/model/pagination_model.dart';

class AllBusinessResponse {
  final String status;
  final int statusCode;
  final String message;
  final List<BusinessModel> results;
  final Pagination pagination;

  AllBusinessResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.results,
    required this.pagination,
  });

  factory AllBusinessResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['attributes'];
    final resultsList = data?['results'] as List? ?? [];

    List<BusinessModel> parseResults(List list) {
      return list.map((item) {
        // Map API fields to BusinessModel fields
        return BusinessModel(
          id: item['_id'] ?? '',
          name: item['businessName'] ?? '',
          image: item['image'],
          types: item['dealType'] != null ? [item['dealType']] : [],
          formattedAddress: item['businessAddress'],
          postalCode: null,
          formattedPhoneNumber: null,
          rating: (item['rating'] ?? 0).toDouble(),
          userRatingsTotal: item['user_ratings_total'] ?? 0,
          totalReview: 0,
          redeemCount: item['redeemCount'] ?? 0,
          openingHours: [],
          location: null,
          deals: [],
          feedbacks: [],
          isFavourite: false,
          priceRange: null,
        );
      }).toList();
    }

    return AllBusinessResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      results: parseResults(resultsList),
      pagination: Pagination.fromJson(data?['pagination'] ?? {}),
    );
  }
}