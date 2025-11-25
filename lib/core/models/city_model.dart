class CityResponse {
  final String status;
  final int statusCode;
  final String message;
  final CityData? data;
  final List<dynamic> errors;

  CityResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
    required this.errors,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) {
    return CityResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? CityData.fromJson(json['data']) : null,
      errors: json['errors'] ?? [],
    );
  }
}

class CityData {
  final List<CityModel> results;

  CityData({required this.results});

  factory CityData.fromJson(Map<String, dynamic> json) {
    final resultsList = json['attributes']?['results'] as List? ?? [];
    return CityData(
      results: resultsList.map((e) => CityModel.fromJson(e)).toList(),
    );
  }
}

class CityModel {
  final String id;
  final List<dynamic> postalCode;
  final String cityName;

  CityModel({
    required this.id,
    required this.postalCode,
    required this.cityName,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['_id'] ?? '',
      postalCode: json['postalCode'] as List<dynamic>? ?? [],
      cityName: json['cityName'] ?? '',
    );
  }
}
