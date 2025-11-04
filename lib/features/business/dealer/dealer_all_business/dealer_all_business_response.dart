import 'package:dine_dash/core/models/dealer_business_model.dart';

class DealerAllBusinessResponse {
  final String status;
  final int statusCode;
  final String message;

  final List<DealerBusinessModel> results;
  final _Pagination pagination;

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
      results:
          (attributes['results'] as List<dynamic>? ?? [])
              .map((item) => DealerBusinessModel.fromJson(item))
              .toList(),
      pagination: _Pagination.fromJson(attributes['pagination'] ?? {}),
    );
  }
}

class _Pagination {
  final int totalResults;
  final int totalPages;
  final int currentPage;
  final int limit;

  _Pagination({
    required this.totalResults,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
  });

  factory _Pagination.fromJson(Map<String, dynamic> json) {
    return _Pagination(
      totalResults: json['totalResults'] ?? 0,
      totalPages: json['totalPages'] ?? 1,
      currentPage: json['currentpage'] ?? 1,
      limit: json['limit'] ?? 10,
    );
  }
}
