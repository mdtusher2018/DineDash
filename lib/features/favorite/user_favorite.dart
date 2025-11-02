import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/favorite/favorite_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/user_resturant_card.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/user_business_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserFavoritePage extends StatefulWidget {
  const UserFavoritePage({super.key});

  @override
  State<UserFavoritePage> createState() => _UserFavoritePageState();
}

class _UserFavoritePageState extends State<UserFavoritePage> {
  final FavoriteController controller = Get.find<FavoriteController>();
  final TextEditingController searchTermController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              /// Search bar
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchTermController,
                        onChanged:
                            (value) =>
                                controller.searchQuery.value =
                                    value, // 🔥 updates filter live
                        decoration: InputDecoration(
                          hintText: "Search restaurants, foods...".tr,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.search),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.favoriteData.value == null) {
                    // Loading or empty
                    return Center(child: CircularProgressIndicator());
                  }

                  // final favorites = controller.favoriteData.value!.attributes;
               

                  if (controller.filteredFavorites.isEmpty) {
                    return Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 330),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/favorite.png"),
                            commonText(
                              "No favorites yet".tr,
                              size: 16,
                              isBold: true,
                            ),
                            SizedBox(height: 16),
                            commonText(
                              "Start exploring our recipes and save your favorites to build your personal collection"
                                  .tr,
                              size: 14,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            commonButton(
                              "Start Exploring".tr,
                              width: 160,
                              boarderRadious: 50,
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async{
                      controller.fetchFavoriteList();
                    },
                    child: ListView.builder(
                      itemCount: controller.filteredFavorites.length,
                      itemBuilder: (context, index) {
                        final business = controller.filteredFavorites[index];
                        return GestureDetector(
                          onTap: () {
                            navigateToPage(
                              UserBusinessDetailsPage(businessId: business.businessId),
                            );
                          },
                          child: RestaurantCard(
                            imageUrl: getFullImagePath(business.image ?? ""),
                    
                            title: business.name,
                            rating: business.rating.toDouble(),
                            reviewCount: business.userRatingsTotal,
                            priceRange:
                                business.priceRange != null
                                    ? "€${business.priceRange!.min}-${business.priceRange!.max}"
                                    : "N/A",
                            openTime: business.openTimeText,
                            location: business.addressText,
                            tags: business.types,
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
