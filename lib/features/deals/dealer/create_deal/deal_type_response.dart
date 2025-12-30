class DealTypeResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<DealType> deals;

  // Constructor
  DealTypeResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.deals,
  });

  // Factory constructor to create DealResponse from JSON
  factory DealTypeResponse.fromJson(Map<String, dynamic> json) {
    var dealsList =
        (json['data']['attributes'] as List)
            .map((dealJson) => DealType.fromJson(dealJson))
            .toList();

    return DealTypeResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      deals: dealsList,
    );
  }
}

class DealType {
  final String id;
  final String name;

  // Constructor
  DealType({required this.id, required this.name});

  // Factory constructor to create Deal from JSON
  factory DealType.fromJson(Map<String, dynamic> json) {
    return DealType(id: json['_id'], name: json['name']);
  }
}
