import 'package:dine_dash/core/models/business_model.dart';
import 'package:dine_dash/core/models/pagination_model.dart';

class UserExploreBusinessListResponse {
  final int statusCode;
  final String message;
  final List<BusinessModel> businesses;
  final Pagination pagination;

  UserExploreBusinessListResponse({
    required this.statusCode,
    required this.message,
    required this.businesses,
    required this.pagination,
  });

  factory UserExploreBusinessListResponse.fromJson(Map<String, dynamic> json) {
    final attributes = json['data']?['attributes'];
    final businessList = attributes?['data'] as List<dynamic>? ?? [];
    final paginationJson = attributes?['pagination'] ?? {};

    return UserExploreBusinessListResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      businesses: businessList.map((e) => BusinessModel.fromJson(e)).toList(),
      pagination: Pagination.fromJson(paginationJson),
    );
  }
}

