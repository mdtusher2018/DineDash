import 'package:dine_dash/features/deals/user/user_deals_page.dart';
import 'package:dine_dash/features/profile/common/profile/profile_screen.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/explore/user_explore.dart';
import 'package:dine_dash/features/favorite/user_favorite.dart';
import 'package:dine_dash/features/home/user/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRootPage extends StatefulWidget {
  const UserRootPage({super.key});

  @override
  _UserRootPageState createState() => _UserRootPageState();
}

class _UserRootPageState extends State<UserRootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UserHomeView(),
    UserExplorePage(),
    UserFavoritePage(),
    UserDealsPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavItem(
    String label,
    String selectedAsset,
    String unselectedAsset,
    bool isSelected,
  ) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        isSelected ? selectedAsset : unselectedAsset,
        width: 30,
        height: 30,
        
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = ["Home", "Explore", "Favorite", "Details", "Profile"];
    final selectedIcons = [
      "assets/images/bottom nav/home_s.png",
      "assets/images/bottom nav/explore_s.png",
      "assets/images/bottom nav/fav_s.png",
      "assets/images/bottom nav/details_s.png",
      "assets/images/bottom nav/profile_s.png",
    ];
    final unselectedIcons = [
      "assets/images/bottom nav/home_u.png",
      "assets/images/bottom nav/explore_u.png",
      "assets/images/bottom nav/fav_u.png",
      "assets/images/bottom nav/details_u.png",
      "assets/images/bottom nav/profile_u.png",
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: AppColors.primaryColor, // selected text color
        unselectedItemColor: Colors.grey, // unselected text color
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold, // bold text for selected item
        ),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        items: List.generate(5, (index) {
          return _buildNavItem(
            labels[index].tr,
            selectedIcons[index],
            unselectedIcons[index],
            _selectedIndex == index,
          );
        }),
      ),
    );
  }
}
