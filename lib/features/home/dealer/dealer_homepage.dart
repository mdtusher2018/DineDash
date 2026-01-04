import 'dart:developer';

import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/home/dealer/dealer_homepage_controller.dart';
import 'package:dine_dash/features/notification/user%20notification/user_notification.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/business/dealer/dealer_business_details/dealer_business_details_page.dart';
import 'package:dine_dash/features/deals/dealer/create_deal/create_deal.dart';
// import 'package:dine_dash/features/notification/dealer_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class DealerHomepage extends StatefulWidget {
  const DealerHomepage({super.key});

  @override
  State<DealerHomepage> createState() => _DealerHomepageState();
}

class _DealerHomepageState extends State<DealerHomepage> {
  final controller = Get.find<DealerHomepageController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log("===========>>>>>>> Home page api called");
      controller.fetchDealerHomepageData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchDealerHomepageData();
          },
          child: SingleChildScrollView(
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 29),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonText(
                      "Hi Dealer!".tr,
                      size: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    IconButton(
                      onPressed: () {
                        navigateToPage(
                          UserNotificationsPage(),
                          context: context,
                        );
                      },
                      icon: Icon(
                        Icons.notifications_active,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    navigateToPage(AddDealScreen(), context: context);
                  },
                  child: Container(
                    height: 46,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Icon(Icons.add, size: 28),
                        commonText(
                          "Quick Add Deal".tr,
                          size: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (controller.businessSummary.value == null &&
                        !controller.isLoading.value) {
                      return commonText("No data Found");
                    }
                    if (controller.businessSummary.value == null) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Row(
                      children: [
                        _BuildStack(
                          image: 'assets/images/banner1.png',
                          icon: 'assets/images/starreview.png',
                          text:
                              controller.businessSummary.value!.totalReviews
                                  .toString(),
                          title: 'Total Reviews',
                        ),
                        SizedBox(width: 16),
                        _BuildStack(
                          image: 'assets/images/banner2.png',
                          icon: 'assets/images/rattingicon.png',
                          text:
                              controller.businessSummary.value!.avgRating
                                  .toString(),
                          title: 'Avg. Rating',
                        ),
                        SizedBox(width: 16),
                        _BuildStack(
                          image: 'assets/images/banner3.png',
                          icon: 'assets/images/businesses.png',
                          text:
                              controller.businessSummary.value!.totalBusiness
                                  .toString(),
                          title: 'Businesses',
                        ),
                        SizedBox(width: 16),
                        _BuildStack(
                          image: 'assets/images/banner4.png',
                          icon: 'assets/images/activedeals.png',
                          text:
                              controller.businessSummary.value!.activeDeals
                                  .toString(),
                          title: 'Active Deals',
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          CommonImage(
                            "assets/images/Vector.png",
                            height: 20,
                            width: 30,
                            fit: BoxFit.fill,
                          ),
                          commonText(
                            "Monthly Performance".tr,
                            size: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Obx(() {
                        return commonText(
                          controller.performance.value.toString(),
                          size: 36,
                          fontWeight: FontWeight.w600,
                        );
                      }),
                      commonText(
                        "Total monthly deals redeems across all restaurants."
                            .tr,
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: commonText(
                    "Your Businesses".tr,
                    size: 18,
                    isBold: true,
                  ),
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (controller.businesses.isEmpty) {
                    return Center(
                      child: commonText(
                        "No restaurants found.".tr,
                        size: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    physics: ScrollPhysics(),
                    itemCount: controller.businesses.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateToPage(
                            DealerBusinessDetailsPage(
                              businessId: controller.businesses[index].id,
                            ),
                            context: context,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          height: 117,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 92,
                                  width: 92,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    getFullImagePath(
                                      controller.businesses[index].image ?? "",
                                    ),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            commonImageErrorWidget(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  spacing: 2,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText(
                                      controller.businesses[index].businessName,
                                      maxline: 1,
                                      size: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_rounded,
                                          size: 20,
                                          color: Colors.blueAccent,
                                        ),
                                        Expanded(
                                          child: commonText(
                                            controller
                                                    .businesses[index]
                                                    .businessAddress ??
                                                "N/A",
                                            maxline: 1,
                                            size: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          height: 22,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                            color: Color(0xffB7CDF5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              commonText(
                                                "${controller.businesses[index].activeDeals} deals",
                                                size: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 22,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                            color: Color(0xffFFF9C2),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              commonText(
                                                "${controller.businesses[index].rating}",
                                                size: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              RatingBar.builder(
                                                initialRating: 3,
                                                itemSize: 15,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 1,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 4.0,
                                                    ),
                                                itemBuilder:
                                                    (context, _) => Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              commonText(
                                                "(${controller.businesses[index].totalReviews})",
                                                size: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: commonText(
                                        "_ deals redeemed this month".trParams({
                                          'number':
                                              "${controller.businesses[index].redeemCount}",
                                        }),
                                        size: 14,
                                        fontWeight: FontWeight.w400,
                                        maxline: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildStack extends StatelessWidget {
  const _BuildStack({
    required this.image,
    required this.icon,
    required this.text,
    required this.title,
  });
  final String image;
  final String icon;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 155,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: CommonImage(image, fit: BoxFit.cover),
        ),
        Positioned(
          top: 20,
          left: 25,
          right: 25,
          child: Column(
            spacing: 5,
            children: [
              CommonImage(
                icon,
                height: 30,
                width: 30,
                fit: BoxFit.fill,
                color: AppColors.black,
                colorBlendMode: BlendMode.srcIn,
              ),
              commonText(text.tr, size: 26, fontWeight: FontWeight.w700),
              commonText(title.tr, size: 16, fontWeight: FontWeight.w700),
            ],
          ),
        ),
      ],
    );
  }
}
