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
    List<dynamic> rawFeatures = json['feature'] ?? [];
    List<String> featureList = rawFeatures.map((e) => e.toString()).toList();

    return PlanModel(
      id: json['_id'] ?? "",
      planName: json['planName'] ?? "N/A",
      description: json['description'] ?? "No Subscription Found",
      price: (json['price'] ?? 0 as num).toDouble(),
      duration: json['duration'] ?? 30,
      feature: featureList,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? "",
    );
  }
}
