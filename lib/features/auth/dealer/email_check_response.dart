import 'package:dine_dash/core/models/user_model.dart';

class EmailCheckResponse {
  final String status;
  final int statusCode;
  final UserModel? data;
  final List<String> errors;

  EmailCheckResponse({
    required this.status,
    required this.statusCode,
    required this.data,
    required this.errors,
  });

  factory EmailCheckResponse.fromJson(Map<String, dynamic> json) {
    return EmailCheckResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      data:
          (json['data']['attributes'] == null)
              ? null
              : UserModel.fromJson(json['data']['attributes']),
      errors: json['errors'] != null ? List<String>.from(json['errors']) : [],
    );
  }
}
