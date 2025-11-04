import 'package:dine_dash/core/models/pagination_model.dart';
import 'package:dine_dash/features/deals/user/model_and_response/deal_model.dart';

class UserAllDealsResponse {
  final bool status;
  final num statusCode;
  final String message;
  final List<UserDealItem> results;
  final Pagination pagination;
  final List<dynamic> errors;

  UserAllDealsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.results,
    required this.pagination,
    required this.errors,
  });

  factory UserAllDealsResponse.fromJson(Map<String, dynamic> json) {
    final attributes = json['data']?['attributes'] ?? {};

    return UserAllDealsResponse(
      status: json['status'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      results: (attributes['results'] as List<dynamic>? ?? [])
          .map((e) => UserDealItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(attributes['pagination']??{}),
          
      errors: List<dynamic>.from(json['errors'] ?? []),
    );
  }

}
