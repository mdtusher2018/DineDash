import 'package:dine_dash/core/models/user_model.dart';

class UpdateProfileResponse {
  final String status;
  final int statusCode;
  final String message;
  final UserModel? user;
  final List<dynamic> errors;

  UpdateProfileResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.user,
    this.errors = const [],
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {

    final Map<String, dynamic>? data = json['data'] as Map<String, dynamic>?;
    final Map<String, dynamic>? attributes = data?['attributes'] as Map<String, dynamic>?;

    return UpdateProfileResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      // Map attributes to the user field
      user: attributes != null ? UserModel.fromJson(attributes) : null,
      errors: json['errors'] as List<dynamic>? ?? [],
    );
  }
}
