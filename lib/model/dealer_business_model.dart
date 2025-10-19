class DealerBusinessModel {
  final String id;
  final String businessName;
  final String? image;
  final String? businessAddress;
  final double rating;
  final int userRatingsTotal;
  final int redeemCount;
  final int totalReviews;
  final int activeDeals;
  final String? dealType;
  final DateTime? createdAt;

  DealerBusinessModel({
    required this.id,
    required this.businessName,
    this.image,
    this.businessAddress,
    required this.rating,
    required this.userRatingsTotal,
    required this.redeemCount,
    required this.totalReviews,
    required this.activeDeals,
    this.dealType,
    this.createdAt,
  });

  factory DealerBusinessModel.fromJson(Map<String, dynamic> json) {
    return DealerBusinessModel(
      id: json['_id'] ?? '',
      businessName: json['businessName'] ?? '',
      image: json['image'],
      businessAddress: json['businessAddress'],
      rating: (json['rating'] ?? 0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      redeemCount: json['redeemCount'] ?? 0,
      totalReviews: json['totalReviews'] ?? 0,
      activeDeals: json['activeDeals'] ?? 0,
      dealType: json['dealType'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
