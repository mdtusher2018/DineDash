import 'package:dine_dash/model/user_model.dart';

class ProfileResponse {
  final String status;
  final int statusCode;
  final String message;
  final UserModel? user; 
  final List<dynamic> errors;

  ProfileResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.user, // Changed from this.users
    this.errors = const [],
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    final attributes = data?['attributes'] as List?;
    
    final UserModel? singleUser = (attributes != null && attributes.isNotEmpty)
        ? UserModel.fromJson(attributes.first)
        : null;

    return ProfileResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      user: singleUser, // Assign the single user
      errors: json['errors'] ?? [],
    );
  }
}