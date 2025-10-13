import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/user_resturant_card.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/user_business_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserExplorePage extends StatefulWidget {
  const UserExplorePage({super.key});

  @override
  State<UserExplorePage> createState() => _UserExplorePageState();
}

class _UserExplorePageState extends State<UserExplorePage> {
  bool showMap = false;

  String? selectedExpense ;
  String selectedSortBy = 'Gulshan';
  RxString selectedLocation = 'Rampura, Dhaka.'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          /// Content
          showMap
              ? _buildMapView()
              : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildListView(),
                ),
              ),

          if (showMap)
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16, right: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFDCE7FA),
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
                    SizedBox(width: 8),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),

          /// Toggle: Map / List
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  toggleButton(
                    icon: "assets/images/location2.png",
                    label: 'Map',
                    isSelected: showMap,
                    onTap: () => setState(() => showMap = true),
                    isleft: true,
                  ),

                  toggleButton(
                    icon: "assets/images/bottom nav/explore_u.png",
                    label: 'List',

                    isSelected: !showMap,
                    onTap: () => setState(() => showMap = false),
                    isleft: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Toggle button (Map / List)
  Widget toggleButton({
    required String icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isleft,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular((isleft) ? 30 : 0),
            bottomLeft: Radius.circular((isleft) ? 30 : 0),
            bottomRight: Radius.circular((isleft) ? 0 : 30),
            topRight: Radius.circular((isleft) ? 0 : 30),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              color: isSelected ? Colors.white : AppColors.primaryColor,width: 24,
            ),
            const SizedBox(width: 6),
            commonText(
              label,
              size: 14,
              color: isSelected ? Colors.white : AppColors.primaryColor,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  /// Map Placeholder
  Widget _buildMapView() {
    return Image.network(
      "https://th.bing.com/th/id/R.e6a56687376115edc42563b61fef9044?rik=fwSanhEc0otGvQ&pid=ImgRaw&r=0", // Place a map placeholder image here
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  /// List of Business Cards
  Widget _buildListView() {

    return SingleChildScrollView(
      child: Column(
        children: [
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  
      
        Obx(
           () {
            return DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedLocation.value,
                icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedLocation.value = newValue;
                    });
                  }
                },
                items: <String>[
                  'Rampura, Dhaka.',
                  'Gulshan, Dhaka.',
                  'Banani, Dhaka.',
                  'Dhanmondi, Dhaka.',
                ].map<DropdownMenuItem<String>>((String location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
              ),
            );
          }
        ),
      ],
    ),

          const SizedBox(height: 16),

          /// Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.lightBlue.withOpacity(0.4),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children:  [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search restaurants, foods...".tr,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.search),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// Filter and Sort
          Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightBlue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      value: selectedExpense,hint: commonText("What do you want to do".tr),
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                      ),
                      items:
                          ['Restaurants', 'Activities'].map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              
                              child: commonText(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedExpense = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightBlue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      value: selectedSortBy,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                      ),
                      items:
                          ['Gulshan', 'Banani', 'Uttara'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: commonText("Sort By: $value"),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSortBy = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ListView.separated(itemCount: 4,
          shrinkWrap: true,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                    navigateToPage(UserBusinessDetailsPage(businessId: "",));
                },
                child: RestaurantCard(
                  imageUrl:
                      "https://tse4.mm.bing.net/th/id/OIP.r3wgjJHOPaQo1GnGCkMnwgHaE8?rs=1&pid=ImgDetMain&o=7&rm=3",
                  title: "The Rio Lounge",
                  rating: 4,
                  reviewCount: 120,
                  priceRange: "€50–5000",
                  openTime: "9 AM - 10 PM",
                  location: "Gulshan 2, Dhaka.",
                  tags: ["Free cold drinks", "2 for 1"],
                ),
              ), separatorBuilder: (context, index) =>   SizedBox(height: 8),
            
            physics: NeverScrollableScrollPhysics(),
          
          ),
        ],
      ),
    );
  }
}
