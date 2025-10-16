class UserExploreMapResponse {
  final int status;
  final int statusCode;
  final String message;
  final List<BusinessOnMap> businesses;

  UserExploreMapResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.businesses,
  });

  factory UserExploreMapResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['attributes'] as List? ?? [];
    return UserExploreMapResponse(
      status: json['status'] ?? 0,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      businesses: data.map((e) => BusinessOnMap.fromJson(e)).toList(),
    );
  }
}

class BusinessOnMap {
  final String id;
  final String name;
  final String type;
  final List<double> coordinates;

  BusinessOnMap({
    required this.id,
    required this.name,
    required this.type,
    required this.coordinates,
  });

  factory BusinessOnMap.fromJson(Map<String, dynamic> json) {
    final location = json['location'] ?? {};
    final coords = (location['coordinates'] as List?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [];

    return BusinessOnMap(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      type: location['type'] ?? '',
      coordinates: coords,
    );
  }
}
