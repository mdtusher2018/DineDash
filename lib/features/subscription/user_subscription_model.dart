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

class PlanModel {
  final String id;
  final String planName;
  final String description;
  final double price;
  final int duration;
  final List<String> feature;
  final String createdAt;
  final String updatedAt;

  PlanModel({
    required this.id,
    required this.planName,
    required this.description,
    required this.price,
    required this.duration,
    required this.feature,
    required this.createdAt,
    required this.updatedAt,
  });
  factory PlanModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> rawFeatures = json['feature'] ?? ["feature 1", "feature 2"];
    List<String> featureList = rawFeatures.map((e) => e.toString()).toList();

    return PlanModel(
      id: json['_id'],
      planName: json['planName'] ?? "",
      description: json['description'] ?? "",
      price: (json['price'] ?? 0 as num).toDouble(),
      duration: json['duration'] ?? 30,
      feature: featureList,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? "",
    );
  }
}
