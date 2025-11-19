import 'package:dine_dash/features/deals/user/model_and_response/deal_model.dart';

class UserDealDetailsResponse {
  final bool status;
  final num statusCode;
  final String message;
  final UserDealItem result;
  final List<dynamic> errors;

  UserDealDetailsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.result,
    required this.errors,
  });

  factory UserDealDetailsResponse.fromJson(Map<String, dynamic> json) {
    final attributes = json['data']?['attributes'] ?? {};

    return UserDealDetailsResponse(
      status: json['status'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      result: UserDealItem.fromJson(attributes),
      errors: List<dynamic>.from(json['errors'] ?? []),
    );
  }
}
