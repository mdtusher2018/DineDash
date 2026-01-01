import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final int reviewCount;
  final String priceRange;
  final String openTime;
  final String location;
  final List<String> tags;

  const RestaurantCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.reviewCount,
    required this.priceRange,
    required this.openTime,
    required this.location,
    this.tags = const [],
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Responsive font sizing
    final titleSize = width * 0.035; // roughly 14px on mid-size phones
    final smallTextSize = width * 0.03; // 12px-ish
    final imageHeight = width * 0.4; // dynamic image height

    return Container(
      constraints: BoxConstraints(maxHeight: 300),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        border: Border.all(width: 1.5, color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                getFullImagePath(imageUrl),
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      height: imageHeight,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported, size: 40),
                    ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Price Range
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 16,

                  children: [
                    Flexible(
                      child: commonText(
                        title,
                        maxline: 1,
                        size: titleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (priceRange.isNotEmpty)
                      Flexible(
                        child: commonText(
                          "${"Price Range :".tr} $priceRange",
                          maxline: 1,
                          size: smallTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 6),

                /// Rating + Open Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 16,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            size: smallTextSize * 1.3,
                            color: Colors.orange,
                          );
                        }),
                        const SizedBox(width: 4),
                        commonText(
                          "($reviewCount)",
                          maxline: 1,
                          fontWeight: FontWeight.w600,
                          size: smallTextSize,
                        ),
                      ],
                    ),
                    Flexible(
                      child: commonText(
                        "${"Open Time :".tr} $openTime",
                        size: smallTextSize,
                        maxline: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Location
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.blue),
                    const SizedBox(width: 4),
                    Expanded(
                      child: commonText(
                        "${"Location :".tr} $location",
                        size: smallTextSize,
                        maxline: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Tags
                if (tags.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children:
                        tags
                            .take(3) // ✅ show only first 3 tags
                            .map(
                              (tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.lightBlue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: commonText(tag, size: smallTextSize),
                              ),
                            )
                            .toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
