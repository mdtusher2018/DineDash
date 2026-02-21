import 'package:dine_dash/core/models/business_model.dart';
import 'package:dine_dash/core/models/pagination_model.dart';

class ListOfBusinessResponse {
  String status;
  int statusCode;
  String message;
  Data data;

  ListOfBusinessResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ListOfBusinessResponse.fromJson(Map<String, dynamic> json) {
    return ListOfBusinessResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  String type;
  Attributes attributes;

  Data({required this.type, required this.attributes});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      type: json['type'],
      attributes: Attributes.fromJson(json['attributes']),
    );
  }
}

class Attributes {
  List<BusinessModel> restaurants;
  List<BusinessModel> activity;
  Pagination pagination;

  Attributes({
    required this.restaurants,
    required this.pagination,
    required this.activity,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      restaurants: List<BusinessModel>.from(
        (json['restaurants'] as List? ?? []).map(
          (x) => BusinessModel.fromJson(x),
        ),
      ),
      activity: List<BusinessModel>.from(
        (json['activities'] as List? ?? []).map(
          (x) => BusinessModel.fromJson(x),
        ),
      ),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}
