import 'package:dine_dash/model/business_model.dart';

class FavoriteResponse {
  final String status;
  final int statusCode;
  final String message;
  final FavoriteData data;
  final List<dynamic> errors;

  FavoriteResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: FavoriteData.fromJson(json['data'] ?? {}),
      errors: json['errors'] ?? [],
    );
  }
}

class FavoriteData {
  final String type;
  final List<BusinessModel> attributes;

  FavoriteData({required this.type, required this.attributes});

  factory FavoriteData.fromJson(Map<String, dynamic> json) {
    List<BusinessModel> parseAttributes(dynamic list) =>
        list != null
            ? (list as List).map((e) => BusinessModel.fromJson(e)).toList()
            : [];

    return FavoriteData(
      type: json['type'] ?? '',
      attributes: parseAttributes(json['attributes']),
    );
  }
}
