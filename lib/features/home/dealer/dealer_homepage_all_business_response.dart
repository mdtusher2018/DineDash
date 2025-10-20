import 'package:dine_dash/core/models/dealer_business_model.dart';
import 'package:dine_dash/core/models/pagination_model.dart';

class DealerHomepageAllBusinessResponse {
  final int status;
  final int statusCode;
  final String message;
  final BusinessSummary summary;
  final List<DealerBusinessModel> results;
  final Pagination pagination;

  DealerHomepageAllBusinessResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.summary,
    required this.results,
    required this.pagination,
  });

  factory DealerHomepageAllBusinessResponse.fromJson(Map<String, dynamic> json) {
    final attributes = json['data']?['attributes'] ?? {};

    return DealerHomepageAllBusinessResponse(
      status: json['status'] ?? 0,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      summary: BusinessSummary.fromJson(attributes['summary'] ?? {}),
      results: (attributes['results'] as List<dynamic>? ?? [])
          .map((item) => DealerBusinessModel.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(attributes['pagination'] ?? {}),
    );
  }
}

class BusinessSummary {
  final int totalReviews;
  final double avgRating;
  final int totalBusiness;
  final int activeDeals;

  BusinessSummary({
    required this.totalReviews,
    required this.avgRating,
    required this.totalBusiness,
    required this.activeDeals,
  });

  factory BusinessSummary.fromJson(Map<String, dynamic> json) {
    return BusinessSummary(
      totalReviews: json['totalReviews'] ?? 0,
      avgRating: (json['avgRating'] ?? 0).toDouble(),
      totalBusiness: json['totalBusiness'] ?? 0,
      activeDeals: json['activeDeals'] ?? 0,
    );
  }
}

