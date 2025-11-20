import 'package:dine_dash/features/subscription/subscription_model.dart';

class SubscriptionPlansResponse {
  final String status;
  final int statusCode;
  final String message;
  final PlanData data;
  final List<dynamic> errors;

  SubscriptionPlansResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory SubscriptionPlansResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlansResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: PlanData.fromJson(json['data'] ?? {}),
      errors: json['errors'] ?? [],
    );
  }
}

class PlanData {
  final String type;
  final List<PlanModel> attributes;

  PlanData({required this.type, required this.attributes});

  factory PlanData.fromJson(Map<String, dynamic> json) {
    var list = json['attributes'] as List;
    List<PlanModel> attributesList =
        list.map((i) => PlanModel.fromJson(i)).toList();

    return PlanData(type: json['type'], attributes: attributesList);
  }
}
