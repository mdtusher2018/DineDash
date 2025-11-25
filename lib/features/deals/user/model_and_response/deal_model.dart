class UserDealItem {
  final String id;
  final num minPrice;
  final num maxPrice;
  final String businessImage;
  final String businessId;
  final String businessName;
  final List<OpeningHour> openingHours;
  final num rating;
  final num totalRating;
  final String address;
  final String dealType;
  final String dealId;
  final num reuseableAfter;
  final num redeemCount;
  final num benefitAmmount;
  final String description;
  final List<dynamic> catgory;
  final String bookingStart;
  final String bookingEnd;
  final String redeemedRedeemedAt;

  UserDealItem({
    required this.id,
    required this.minPrice,
    required this.maxPrice,
    required this.businessImage,
    required this.businessId,
    required this.businessName,
    required this.openingHours,
    required this.rating,
    required this.totalRating,
    required this.address,
    required this.dealType,
    required this.dealId,
    required this.reuseableAfter,
    required this.redeemCount,
    required this.description,
    required this.benefitAmmount,
    required this.catgory,
    required this.bookingStart,
    required this.bookingEnd,
    required this.redeemedRedeemedAt,
  });

  factory UserDealItem.fromJson(Map<String, dynamic> json) => UserDealItem(
    id: json['_id'] ?? '',
    minPrice: json['minPrice'] ?? 0,
    maxPrice: json['maxPrice'] ?? 0,
    businessImage: json['businessImage'] ?? '',
    businessId: json['businessId'] ?? '',
    businessName: json['businessName'] ?? '',
    openingHours:
        (json['openingHours'] as List<dynamic>? ?? [])
            .map((e) => OpeningHour.fromJson(e as Map<String, dynamic>))
            .toList(),
    rating: json['rating'] ?? 0,
    totalRating: json['totalRating'] ?? 0,
    address: json['address'] ?? '',
    dealType: json['dealType'] ?? '',
    dealId: json['dealId'] ?? '',
    reuseableAfter: json['reuseableAfter'] ?? 0,
    redeemCount: json['redeemCount'] ?? 0,
    description: json['description'] ?? '',
    benefitAmmount: json['benefitAmmount'] ?? 0,
    catgory: json['businessCategories'] as List<dynamic>? ?? [],
    bookingStart: json['bookinfor'] ?? '',
    bookingEnd: json['bookinEnd'] ?? '',
    redeemedRedeemedAt: json['redeemedRedeemedAt'] ?? '',
  );
}

class OpeningHour {
  final String day;
  final bool isOpen;
  final String openingTime;
  final String closingTime;
  final String id;

  OpeningHour({
    required this.day,
    required this.isOpen,
    required this.openingTime,
    required this.closingTime,
    required this.id,
  });

  factory OpeningHour.fromJson(Map<String, dynamic> json) => OpeningHour(
    day: json['day'] ?? '',
    isOpen: json['isOpen'] ?? false,
    openingTime: json['openingTime'] ?? '',
    closingTime: json['closingTime'] ?? '',
    id: json['_id'] ?? '',
  );
}

extension UserDealItemExtension on UserDealItem {
  /// Returns the next opening day and time as a Map
  Map<String, String> getNextOpening() {
    if (openingHours.isEmpty) return {'day': 'Closed', 'time': '-- - --'};

    final today = DateTime.now();
    final todayNum = today.weekday; // 1=Monday, 7=Sunday

    // Map weekday names to numbers
    final Map<String, int> dayToNumber = {
      'monday': 1,
      'tuesday': 2,
      'wednesday': 3,
      'thursday': 4,
      'friday': 5,
      'saturday': 6,
      'sunday': 7,
    };

    // Filter only open days
    final openDays = openingHours.where((o) => o.isOpen).toList();
    if (openDays.isEmpty) return {'day': 'Closed', 'time': '-- - --'};

    // Sort by next occurrence
    openDays.sort((a, b) {
      int diffA = ((dayToNumber[a.day.toLowerCase()] ?? 0) - todayNum + 7) % 7;
      int diffB = ((dayToNumber[b.day.toLowerCase()] ?? 0) - todayNum + 7) % 7;
      return diffA.compareTo(diffB);
    });

    final nextDay = openDays.first;
    return {
      'day': nextDay.day,
      'time': '${nextDay.openingTime} - ${nextDay.closingTime}',
    };
  }
}
