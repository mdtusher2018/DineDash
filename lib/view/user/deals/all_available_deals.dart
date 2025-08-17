import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'deals_details.dart';

class AllAvailableDeals extends StatelessWidget {
  const AllAvailableDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Available Deals"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => DealsDetails());
              },
              child: _dealCard(context, isUsed: false),
            );
          },
        ),
      ),
    );
  }

  // Function to generate the deal card
  Widget _dealCard(BuildContext context, {required bool isUsed}) {
    return Opacity(
      opacity: isUsed ? 0.5 : 1.0, // Adjust opacity for used deals
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffE8EFFC),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 134,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    "assets/images/banner.png",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonText(
                        "The Rio Lounge",
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        children: [
                          commonText(
                            "Price Range :".tr,
                            size: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          commonText(
                            " €50-5000",
                            size: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 3,
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            itemSize: 20,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0),
                            itemBuilder:
                                (context, _) =>
                                    Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          commonText(
                            "(120)",
                            size: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          commonText(
                            "Open Time :".tr,
                            size: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          commonText(
                            "9 AM - 10 PM",
                            size: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: Colors.blueAccent),
                      commonText(
                        "Location :".tr,
                        size: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      commonText(
                        "Gulshan 2, Dhaka.",
                        size: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28),
                Divider(thickness: 2, color: Colors.blueAccent),
                SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText(
                        "Free cold drinks",
                        size: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      commonText(
                        "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
                        size: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff0A0A0A),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 5,
                            children: [
                              Container(
                                height: 35,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueAccent.shade100,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/clock.png",
                                    height: 25,
                                    width: 25,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonText(
                                    "Reusable After".tr,
                                    size: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  commonText(
                                    "60 Days",
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            spacing: 5,
                            children: [
                              Container(
                                height: 35,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueAccent.shade100,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/locate.png",
                                    height: 25,
                                    width: 25,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonText(
                                    "LOCATION".tr,
                                    size: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  commonText(
                                    "Gulshan 2.",
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 236,
              left: 110.5,
              right: 110.5,
              child: Container(
                height: 39,
                width: 89,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueAccent,
                ),
                child: Center(
                  child: commonText(
                    isUsed ? "Used Deal" : "6 € Benefit",
                    size: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
