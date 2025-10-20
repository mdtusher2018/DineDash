class DealerMyBusinessNameResponse {
  final String? status;
  final int? statusCode;
  final String? message;
  final List<DealerBusinessItem>? businessNameList;
  final List<dynamic>? errors;

  DealerMyBusinessNameResponse({
    this.status,
    this.statusCode,
    this.message,
    this.businessNameList,
    this.errors,
  });

  factory DealerMyBusinessNameResponse.fromJson(Map<String, dynamic> json) {
    return DealerMyBusinessNameResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      businessNameList:
          (json['data']?['attributes'] as List?)
              ?.map((e) => DealerBusinessItem.fromJson(e))
              .toList(),

      errors: json['errors'] ?? [],
    );
  }
}

class DealerBusinessItem {
  final String id;
  final String businessName;

  DealerBusinessItem({required this.id, required this.businessName});

  factory DealerBusinessItem.fromJson(Map<String, dynamic> json) {
    return DealerBusinessItem(
      id: json['_id'] ?? "",
      businessName: json['businessName'] ?? "N/A",
    );
  }
}
