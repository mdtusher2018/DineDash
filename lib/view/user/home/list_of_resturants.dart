// ignore_for_file: must_be_immutable

import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/user/common_designs/common_design.dart';
import 'package:dine_dash/view/user/home/RestaurantDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllResturentPage extends StatefulWidget {
  String title;
   SeeAllResturentPage({super.key,required this.title});

  @override
  State<SeeAllResturentPage> createState() => _SeeAllResturentPageState();
}

class _SeeAllResturentPageState extends State<SeeAllResturentPage> {
  bool showMap = false;

  RxString selectedLocation = 'Rampura, Dhaka.'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:commonAppBar(title: widget.title.tr),
      
      body: ListView.separated(itemCount: 4,
      padding: EdgeInsets.all(16),
          shrinkWrap: true,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                    navigateToPage(RestaurantDetailsPage());
                },
                child: BusinessCard(
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
    );
  }



}
