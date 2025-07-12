import 'package:dine_dash/Razu/DealerBusinessPage/dealer_business_page.dart';
import 'package:dine_dash/Razu/DealerHomePage/dealer_homepage.dart';
import 'package:dine_dash/Razu/DealerProfile/dealer_profile.dart';
import 'package:dine_dash/Razu/DealerReview/dealer_review.dart';
import 'package:dine_dash/colors.dart';
import 'package:dine_dash/delar/BusinessDealsPage.dart';
import 'package:dine_dash/delar/deals/dealer_deals.dart';
import 'package:flutter/material.dart';

class DealerRootPage extends StatefulWidget {
  @override
  _DealerRootPageState createState() => _DealerRootPageState();
}

class _DealerRootPageState extends State<DealerRootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DealerHomepage(),
    DealerDealsPage(),
    DealerBusinessPage(),
    DealerReview(),
    DealerProfile(),
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
    final labels = ["DeshBoard", "Deals", "Bussiness", "Review", "Profile"];
    final selectedIcons = [
      "assets/images/bottom nav/d_d_s.png",
      "assets/images/bottom nav/details_s.png",
      "assets/images/bottom nav/b_d_s.png",
      "assets/images/bottom nav/r_d_s.png",

      "assets/images/bottom nav/profile_s.png",
    ];
    final unselectedIcons = [
      "assets/images/bottom nav/d_d_u.png",
      "assets/images/bottom nav/details_u.png",
      "assets/images/bottom nav/b_d_u.png",
      "assets/images/bottom nav/r_d_u.png",

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
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
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
