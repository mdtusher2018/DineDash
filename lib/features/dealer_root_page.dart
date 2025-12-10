import 'package:dine_dash/features/business/dealer/dealer_all_business/dealer_all_business_page.dart';
import 'package:dine_dash/features/home/dealer/dealer_homepage.dart';
import 'package:dine_dash/features/profile/common/profile/profile_screen.dart';
import 'package:dine_dash/features/ratting_and_feedback/dealer/dealer_review.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/deals/dealer/dealer_all_deals/dealer_deals_root_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealerRootPage extends StatefulWidget {
  const DealerRootPage({super.key});

  @override
  _DealerRootPageState createState() => _DealerRootPageState();
}

class _DealerRootPageState extends State<DealerRootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DealerHomepage(),
    DealerDealsRootPage(),
    DealerBusinessPage(),
    DealerReview(),
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
      icon: CommonImage(
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
        backgroundColor: AppColors.white,
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
