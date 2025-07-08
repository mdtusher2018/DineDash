import 'package:dine_dash/colors.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:dine_dash/user/home/RestaurantDetailsPage.dart';
import 'package:dine_dash/user/home/home_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UserHomeView(),
    RestaurantDetailsPage(),
    Center(child: commonText('Favorite Page')),
    Center(child: commonText('Details Page')),
    Center(child: commonText('Profile Page')),
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
        width: 24,
        height: 24,
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
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: AppColors.primaryColor, // selected text color
        unselectedItemColor: Colors.grey, // unselected text color
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold, // bold text for selected item
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
        ),
        items: List.generate(5, (index) {
          return _buildNavItem(
            labels[index],
            selectedIcons[index],
            unselectedIcons[index],
            _selectedIndex == index,
          );
        }),
      ),
    );
  }
}
