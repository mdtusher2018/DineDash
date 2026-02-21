// ignore_for_file: must_be_immutable

import 'package:dine_dash/features/business/user/list_of_business_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/user_resturant_card.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/user_business_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfBusinessPage extends StatefulWidget {
  String title;
  String? city, searchTerm;
  ListOfBusinessPage({
    super.key,
    required this.title,
    this.searchTerm,
    this.city,
  });

  @override
  State<ListOfBusinessPage> createState() => _ListOfBusinessPageState();
}

class _ListOfBusinessPageState extends State<ListOfBusinessPage> {
  final controller = Get.find<ListOfBusinessController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchListOfBusinessData(
      isBusiness: widget.title != "Activities",
      city: widget.city,
      searchTerm: widget.searchTerm,
    );
    return Scaffold(
      appBar: commonAppBar(title: widget.title.tr, context: context),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemCount: controller.listOfBusiness.length,

          padding: EdgeInsets.all(16),

          itemBuilder: (context, index) {
            final restaurant = controller.listOfBusiness[index];
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 360,
                child: InkWell(
                  onTap:
                      () => navigateToPage(
                        UserBusinessDetailsPage(businessId: restaurant.id),
                        context: context, //restaurantId: restaurant.id
                      ),
                  child: RestaurantCard(
                    imageUrl: restaurant.image ?? "",
                    title: restaurant.name,
                    rating: restaurant.rating.toDouble(),
                    reviewCount: restaurant.userRatingsTotal,
                    priceRange: restaurant.priceRangeText,
                    openTime: restaurant.openTimeText,
                    location: restaurant.formattedAddress ?? "N/A",
                    tags: restaurant.deals.map((e) => e.dealType).toList(),
                  ),
                ),
              ),
            );
          },

          separatorBuilder: (context, index) => SizedBox(height: 8),
        );
      }),
    );
  }
}
