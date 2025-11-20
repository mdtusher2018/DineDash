import 'package:dine_dash/features/subscription/subscription_model.dart'; // Import PlanModel

class MySubscriptionPlanResponse {
  final String status;
  final int statusCode;
  final String message;
  final SubscriptionData data; // This holds the subscription data
  final List<dynamic> errors;

  MySubscriptionPlanResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  // Factory constructor to parse the response into a MySubscriptionPlanResponse object
  factory MySubscriptionPlanResponse.fromJson(Map<String, dynamic> json) {
    return MySubscriptionPlanResponse(
      status: json['status'], // Status of the response
      statusCode: json['statusCode'], // Status code of the response
      message: json['message'], // Message associated with the response
      data: SubscriptionData.fromJson(json['data']?['attributes'] ?? {}),
      errors: json['errors'] ?? [], // List of errors, defaults to empty if none
    );
  }
}

class SubscriptionData {
  final PlanModel subscriptionPlan; // PlanModel that holds subscription details
  final String stripeSubscriptionId; // Stripe subscription ID
  final String expiredAt; // Expiry date of the subscription
  final String createdAt; // Created date of the subscription
  final String updatedAt; // Last updated date of the subscription

  SubscriptionData({
    required this.subscriptionPlan,
    required this.stripeSubscriptionId,
    required this.expiredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to parse the subscription data into a SubscriptionData object
  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(
      subscriptionPlan: PlanModel.fromJson(json['subscriptionPlan'] ?? {}),
      stripeSubscriptionId: json['stripeSubscriptionId'] ?? '',
      expiredAt: json['expiredAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
