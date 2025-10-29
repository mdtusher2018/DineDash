import 'dart:math';

import 'package:dine_dash/features/deals/user/available%20deals/user_allavailable_deals_controller.dart';
import 'package:dine_dash/features/deals/user/used%20deal/user_all_used_deals.dart';
import 'package:dine_dash/features/deals/user/used%20deal/user_used_deals_controller.dart';
import 'package:dine_dash/features/deals/user/widget/deal_card.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/deals/user/available%20deals/user_all_available_deals.dart';
import 'package:dine_dash/features/ratting/user/user_after_giving_star_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_deals_details.dart';

class UserDealsPage extends StatefulWidget {
  const UserDealsPage({super.key});

  @override
  State<UserDealsPage> createState() => _UserDealsPageState();
}

class _UserDealsPageState extends State<UserDealsPage> {
  final usedDealController = Get.find<UserAllUseddDealsController>();
  final abailableDealsController = Get.find<UserAvailableDealsController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      abailableDealsController.fetchDealsList();
      usedDealController.fetchUsedDealsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 64),
        child: Obx(() {
          if (usedDealController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Available Deals Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonText(
                      "Available Deals".tr,
                      size: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToPage(UserAllAvailableDeals());
                      },
                      child: commonText(
                        "See all".tr,
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff555555),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: min(abailableDealsController.availableDeals.length, 2),
                  itemBuilder: (context, index) {
                    final deal = abailableDealsController.availableDeals[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => UserDealsDetails(dealData:abailableDealsController.availableDeals[index]));
                      },
                      child: dealCard(deal: deal, isUsed: false),
                    );
                  },
                ),
                SizedBox(height: 10),
                // Used Deals Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonText(
                      "Used Deals".tr,
                      size: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    InkWell(
                      onTap: () {
                        navigateToPage(UserAllUsedDeals());
                      },
                      child: commonText("See All", size: 14),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: min(usedDealController.usedDeals.length, 2),
                  itemBuilder: (context, index) {
                    final deal = usedDealController.usedDeals[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => UserAfterGivingStarPage());
                      },
                      child: dealCard(deal: deal, isUsed: true),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
