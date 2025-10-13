import 'dart:async';

import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/home/user/home_page_controller.dart';
import 'package:dine_dash/features/home/user/home_page_response.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/user_resturant_card.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/user_business_details_page.dart';
import 'package:dine_dash/features/business/user/list_of_business.dart';
import 'package:dine_dash/features/notification/user_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  String selectedLocation = 'Rampura, Dhaka.';

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final homeData = controller.homeData.value;

          if (homeData == null) {
            return Center(child: commonText("No data available"));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// Top location + bell icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedLocation,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.primaryColor,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedLocation = newValue;
                              });
                            }
                          },
                          items:
                              <String>[
                                'Rampura, Dhaka.',
                                'Gulshan, Dhaka.',
                                'Banani, Dhaka.',
                                'Dhanmondi, Dhaka.',
                              ].map<DropdownMenuItem<String>>((
                                String location,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Text(location),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => navigateToPage(UserNotificationsPage()),
                    child: Material(
                      borderRadius: BorderRadius.circular(100),
                      elevation: 2,
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.notifications_active,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const PromotionBanner(),

              const SizedBox(height: 20),

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

              const SizedBox(height: 24),

              /// Sections dynamically populated
              buildSection("Nearby Open Restaurants", homeData.restaurants, () {
                navigateToPage(
                  ListOfBusinessPage(title: "Nearby Open Restaurants"),
                );
              }),

              buildSection("Activities", homeData.activities, () {
                navigateToPage(ListOfBusinessPage(title: "Activities"));
              }),

              buildSection("Hot Deals 🔥", homeData.hotDeals, () {
                navigateToPage(ListOfBusinessPage(title: "Hot Deals 🔥"));
              }),

              buildSection("Top rated Restaurants", homeData.topRated, () {
                navigateToPage(
                  ListOfBusinessPage(title: "Top rated Restaurants"),
                );
              }),

              buildSection("New", homeData.newRestaurants, () {
                navigateToPage(ListOfBusinessPage(title: "New"));
              }),
            ],
          );
        }),
      ),
    );
  }

  Widget buildSection(String title, List<Restaurant> items, Function() onTap) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonText(title.tr, fontWeight: FontWeight.bold, size: 16),
              GestureDetector(
                onTap: onTap,
                child: commonText(
                  "See all".tr,
                  color: Colors.blueGrey,
                  isBold: true,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final restaurant = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SizedBox(
                  width: 360,
                  child: InkWell(
                    onTap:
                        () => navigateToPage(
                          UserBusinessDetailsPage(businessId: restaurant.id,), //restaurantId: restaurant.id
                        ),
                    child: RestaurantCard(
                      imageUrl: restaurant.image ?? "",
                      title: restaurant.name,
                      rating: restaurant.rating.toDouble(),
                      reviewCount: restaurant.userRatingsTotal,
                      priceRange: restaurant.priceRangeText,
                      openTime: restaurant.openingHoursText,
                      location: restaurant.formattedAddress ?? "N/A",
                      tags: restaurant.deals.map((e) => e.dealType).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PromotionBanner extends StatefulWidget {
  const PromotionBanner({super.key});

  @override
  _PromotionBannerState createState() => _PromotionBannerState();
}

class _PromotionBannerState extends State<PromotionBanner> {
  late final PageController _controller;
  Timer? _timer;

  final List<String> banners = [
    "https://i.pinimg.com/736x/85/92/34/859234899962aa19370919cfeb8b09d1.jpg",
    "https://i.pinimg.com/736x/85/92/34/859234899962aa19370919cfeb8b09d1.jpg",
    "https://i.pinimg.com/736x/85/92/34/859234899962aa19370919cfeb8b09d1.jpg",
  ];

  static const int _initialPage = 1000;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _initialPage);

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_controller.hasClients) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// PageView with infinite scroll effect
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index % banners.length;
              });
            },
            itemBuilder: (context, index) {
              final realIndex = index % banners.length;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(banners[realIndex]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      commonText(
                        "ICE CREAM DAY",
                        size: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      commonText(
                        "GET YOUR SWEET\nICE CREAM",
                        size: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      commonText("40% OFF", size: 14, color: Colors.white),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        /// Dot indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.black : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
