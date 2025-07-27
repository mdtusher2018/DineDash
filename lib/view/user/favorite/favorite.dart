import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/user/common_designs/common_design.dart';
import 'package:dine_dash/view/user/home/RestaurantDetailsPage.dart';
import 'package:flutter/material.dart';

class UserFavoritePage extends StatefulWidget {
  const UserFavoritePage({super.key});

  @override
  State<UserFavoritePage> createState() => _UserFavoritePageState();
}

class _UserFavoritePageState extends State<UserFavoritePage> {

List<String> favorite=[""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
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
                  SizedBox(height: 16,),
                  Expanded(child:
                  (favorite.isEmpty)?
                  
                  Center(child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 330
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/images/favorite.png"),
                        commonText("No favorites yet",size: 16,isBold: true),
                        SizedBox(height: 16,),
                        commonText("Start exploring our recipes and save your favorites to build your personal collection",size: 14,fontWeight: FontWeight.w500,textAlign: TextAlign.center),
                        SizedBox(height: 16,),
                        commonButton("Start Exploring",width: 160,boarderRadious: 50,height: 60)
                      ],
                    ),
                  ))
                  :                 
                   ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    navigateToPage(RestaurantDetailsPage());
                  },
                  child: BusinessCard(
                  imageUrl: "https://tse4.mm.bing.net/th/id/OIP.r3wgjJHOPaQo1GnGCkMnwgHaE8?rs=1&pid=ImgDetMain&o=7&rm=3",
                  title: "Football Mania",
                  rating: 4,
                  reviewCount: 120,
                  priceRange: "€50–5000",
                  openTime: "9 AM - 10 PM",
                  location: "Gulshan 2, Dhaka.",
                  tags: ["2 for 1"],
                                ),
                );
                  },))
            ],
          ),
        ),
      ),
    );
  }
}