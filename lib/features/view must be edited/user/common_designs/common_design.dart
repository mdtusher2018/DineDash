import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final int reviewCount;
  final String priceRange;
  final String openTime;
  final String location;
  final List<String> tags;

  const BusinessCard({
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
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        border: Border.all(width: 2,color: Colors.grey.withOpacity(0.2)),
      
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Price/Time Row
                Column(
               
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: commonText(
                            title,maxline: 2,
                            size: 14, fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 16,),
                        Flexible(
                          child: commonText(
                            "${"Price Range :".tr}$priceRange",
                            size: 12,fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < rating.floor()
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 16,
                                    color: Colors.orange,
                                  );
                                }),
                              ),
                              const SizedBox(width: 4),
                              commonText("($reviewCount)",fontWeight: FontWeight.w600),
                            ],
                          ),
                   SizedBox(width: 16,),
                        Flexible(
                          child: commonText(
                            "${"Open Time :".tr} $openTime",
                                             size: 12,fontWeight: FontWeight.w600,textAlign: TextAlign.right
                          ),
                        ),
                      ],
                    )
                  ],
                ),


  
                const SizedBox(height: 8),

                /// Location Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 20, color: Colors.blue),
                    const SizedBox(width: 4),
                    Expanded(
                      child: commonText(
                        "${"Location :".tr} $location",
                   size: 12,
                        maxline:2,fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags
                      .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: commonText(
                              tag,
                              
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
