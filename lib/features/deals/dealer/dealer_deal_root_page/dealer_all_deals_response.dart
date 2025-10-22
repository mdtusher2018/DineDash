class CreateDealResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final DealData? data;
  final List<dynamic>? errors;

  CreateDealResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.errors,
  });

  factory CreateDealResponse.fromJson(Map<String, dynamic> json) =>
      CreateDealResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] != null ? DealData.fromJson(json["data"]) : null,
        errors:
            json["errors"] == null
                ? []
                : List<dynamic>.from(json["errors"].map((x) => x)),
      );
}

class DealData {
  final String? type;
  final List<DealAttribute>? attributes;

  DealData({this.type, this.attributes});

  factory DealData.fromJson(Map<String, dynamic> json) => DealData(
    type: json["type"],
    attributes:
        json["attributes"] == null
            ? []
            : List<DealAttribute>.from(
              json["attributes"].map((x) => DealAttribute.fromJson(x)),
            ),
  );
}

class DealAttribute {
  final String id;
  final String businessName;
  final String description;
  final num benefitAmmount;
  final String dealType;
  final num reuseableAfter;
  final num redeemCount;
  final bool isActive;

  DealAttribute({
    required this.id,
    required this.businessName,
    required this.description,
    required this.benefitAmmount,
    required this.dealType,
    required this.reuseableAfter,
    required this.redeemCount,
    required this.isActive,
  });

  factory DealAttribute.fromJson(Map<String, dynamic> json) => DealAttribute(
    id: json["_id"] ?? "",
    businessName: json["businessName"] ?? "N/A",
    description: json["description"] ?? "",
    benefitAmmount: json["benefitAmmount"] ?? 0,
    dealType: json["dealType"] ?? "",
    reuseableAfter: json["reuseableAfter"] ?? 60,
    redeemCount: json["redeemCount"] ?? 0,
    isActive: json["isActive"] ?? false,
  );
}
