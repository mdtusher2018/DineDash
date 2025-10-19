import 'package:dine_dash/model/dealer_business_model.dart';
import 'package:dine_dash/model/pagination_model.dart';

class DealerAllBusinessResponse {
  final String status;
  final int statusCode;
  final String message;

  final List<DealerBusinessModel> results;
  final Pagination pagination;

  DealerAllBusinessResponse({
    required this.status,
    required this.statusCode,
    required this.message,

    required this.results,
    required this.pagination,
  });

  factory DealerAllBusinessResponse.fromJson(Map<String, dynamic> json) {
    final attributes = json['data']?['attributes'] ?? {};
    return DealerAllBusinessResponse(
      status: json['status'] ?? "",
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      results: (attributes['results'] as List<dynamic>? ?? [])
          .map((item) => DealerBusinessModel.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(attributes['pagination'] ?? {}),
    );
  }
}

