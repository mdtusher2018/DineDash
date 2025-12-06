class UserModel {
  final String id;
  final String fullName;
  final String email;
  final List<dynamic> role;
  final String currentRole;
  final bool isAdmin;
  final String? postalCode;
  final bool isBan;
  final bool isApproved;
  final String? formattedPhoneNumber;
  final String? formattedAddress;
  final String? qa;
  final int totalDeal;
  final int totalSavings;
  final int visitedCityCount;
  final int visitedPlaceCount;
  final int givenReviewCount;
  final double avgrating;
  final int totalRatings;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLogin;
  final int? v;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.role = const [],
    required this.currentRole,
    required this.isAdmin,
    this.postalCode,
    required this.isBan,
    required this.isApproved,
    this.formattedPhoneNumber,
    this.formattedAddress,
    this.qa,
    required this.totalDeal,
    required this.totalSavings,
    required this.visitedCityCount,
    required this.visitedPlaceCount,
    required this.givenReviewCount,
    required this.avgrating,
    required this.totalRatings,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
    this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] != null ? List<dynamic>.from(json['role']) : [],
      currentRole: json['currentRole'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      postalCode: json['postalCode'],
      isBan: json['isBan'] ?? false,
      isApproved: json['isApproved'] ?? false,
      formattedPhoneNumber: json['formatted_phone_number'],
      formattedAddress: json['formatted_address'],
      qa: json['qa'],
      totalDeal: json['totalDeal'] ?? 0,
      totalSavings: json['totalSavings'] ?? 0,
      visitedCityCount: json['visitedCityCount'] ?? 0,
      visitedPlaceCount: json['visitedPlaceCount'] ?? 0,
      givenReviewCount: json['givenReviewCount'] ?? 0,
      avgrating: (json['avgrating'] ?? 0).toDouble(),
      totalRatings: json['totalRatings'] ?? 0,
      image: json['image'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      lastLogin:
          json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      v: json['__v'],
    );
  }
}
