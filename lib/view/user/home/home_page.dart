import 'dart:async';

import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/user/common_designs/common_design.dart';
import 'package:dine_dash/view/user/home/RestaurantDetailsPage.dart';
import 'package:dine_dash/view/user/notification/notification.dart';
import 'package:flutter/material.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// Top location + bell icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:  [
                    commonText("Rampura, Dhaka.", size: 18, fontWeight: FontWeight.bold),
                    Icon(Icons.arrow_drop_down,color: AppColors.primaryColor,),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    navigateToPage(UserNotificationsPage());
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(100),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      
                      child: Icon(Icons.notifications_active, color: Colors.orange),
                    )),
                ),
              ],
            ),

            const SizedBox(height: 16),

             PromotionBanner(), // 👈 This is where you call it
          SizedBox(height: 20),
            /// Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.lightBlue.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: const [
                 
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search restaurants, foods...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),SizedBox(width: 8),
                   Icon(Icons.search,),
                  
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Sections
            buildSection("Nearby Open Restaurants"),
            buildHorizontalList(),

            buildSection("Activities"),
            buildHorizontalList(),

            buildSection("Hot Deals 🔥"),
            buildHorizontalList(),

            buildSection("Top rated Restaurants"),
            buildHorizontalList(),

            buildSection("New"),
            buildHorizontalList(),
          ],
        ),
      ),
    );
  }

  /// Section title with "See all"
  Widget buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonText(title, fontWeight: FontWeight.bold, size: 16),
          commonText("See all", color: Colors.blueGrey,isBold: true),
        ],
      ),
    );
  }

  /// Horizontally scrollable list of BusinessCard widgets
  Widget buildHorizontalList() {
    return SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: List.generate(5, (index) {
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: SizedBox(
          width: 320,
          child: InkWell(
            onTap: () {
              navigateToPage(RestaurantDetailsPage());
            },
            child: BusinessCard(
              imageUrl: "https://tse4.mm.bing.net/th/id/OIP.r3wgjJHOPaQo1GnGCkMnwgHaE8?rs=1&pid=ImgDetMain&o=7&rm=3",
              title: "The Rio Lounge",
              rating: 4.0,
              reviewCount: 120,
              priceRange: "€50–5000",
              openTime: "9 AM - 10 PM",
              location: "Gulshan 2, Dhaka.",
              tags: ["Free cold drinks", "2 for 1"],
            ),
          ),
        ),
      );
    }),
  ),
)
;
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
                    children:  [
                      commonText("ICE CREAM DAY", size: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      commonText("GET YOUR SWEET\nICE CREAM",  size: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      commonText("40% OFF",  size: 14, color: Colors.white),
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







