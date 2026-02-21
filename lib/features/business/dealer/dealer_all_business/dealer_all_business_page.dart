import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/business/dealer/add_business/add_business_frist_page.dart';
import 'package:dine_dash/features/business/dealer/dealer_all_business/dealer_all_business_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/business/dealer/edit_business/edit_bussiness_page.dart';
import 'package:dine_dash/features/business/dealer/dealer_business_details/dealer_business_details_page.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class DealerBusinessPage extends StatefulWidget {
  const DealerBusinessPage({super.key});

  @override
  State<DealerBusinessPage> createState() => _DealerBusinessPageState();
}

class _DealerBusinessPageState extends State<DealerBusinessPage> {
  final controller = Get.find<DealerAllBusinessController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchAllBusinessData(page: 1);

      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          controller.fetchmore();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 64),
            GestureDetector(
              onTap: () {
                navigateToPage(AddBusinessScreenFrist(), context: context);
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
                    Flexible(
                      child: commonText(
                        "Add New Business",
                        size: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.businesses.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.businesses.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.fetchAllBusinessData(page: 1);
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Icon(
                          Icons.business_outlined,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: commonText(
                            "No Businesses Found",
                            size: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            "Pull down to refresh or try again.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              controller.fetchAllBusinessData(page: 1);
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text("Refresh"),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchAllBusinessData(page: 1);
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
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
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10,
                              children: [
                                SizedBox(),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 98,
                                    width: 98,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      getFullImagePath(
                                        controller.businesses[index].image ??
                                            "",
                                      ),
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              commonImageErrorWidget(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: commonText(
                                              controller
                                                  .businesses[index]
                                                  .businessName,
                                              maxline: 1,
                                              size: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            spacing: 10,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  navigateToPage(
                                                    EditBusinessScreenFrist(
                                                      businessId:
                                                          controller
                                                              .businesses[index]
                                                              .id,
                                                      business:
                                                          controller
                                                              .businesses[index],
                                                    ),
                                                    context: context,
                                                  );
                                                },
                                                child: CommonImage(
                                                  "assets/images/editb.png",
                                                  height: 20,
                                                ),
                                              ),

                                              InkWell(
                                                onTap: () {
                                                  showDeleteConfirmationDialog(
                                                    context: context,
                                                    title: "Delete Item",
                                                    message:
                                                        "Are you sure you want to delete this item? This action cannot be undone.",
                                                    onDelete: () {
                                                      controller.deleteBusiness(
                                                        controller
                                                            .businesses[index]
                                                            .id,
                                                      );
                                                    },
                                                  );
                                                },
                                                child: CommonImage(
                                                  "assets/images/delete.png",
                                                  width: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            size: 25,
                                            color: Colors.blueAccent,
                                          ),
                                          Flexible(
                                            child: commonText(
                                              controller
                                                      .businesses[index]
                                                      .businessAddress ??
                                                  "N/A",
                                              size: 14,
                                              fontWeight: FontWeight.w400,
                                              maxline: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        spacing: 10,
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 55,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Color(0xffB7CDF5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                commonText(
                                                  "${controller.businesses[index].activeDeals} deals",
                                                  size: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 25,
                                            width: 98,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Color(0xffFFF9C2),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                commonText(
                                                  controller
                                                      .businesses[index]
                                                      .rating
                                                      .toStringAsFixed(1),
                                                  size: 12,
                                                  color: AppColors.black
                                                      .withOpacity(0.8),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                RatingBar.builder(
                                                  initialRating: 3,
                                                  itemSize: 12,
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
                                                        color:
                                                            Colors
                                                                .amber
                                                                .shade800,
                                                      ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                commonText(
                                                  "(${controller.businesses[index].totalReviews})",
                                                  size: 12,
                                                  color: AppColors.black
                                                      .withOpacity(0.8),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      commonText(
                                        "${controller.businesses[index].redeemCount} deals redeemed this month",
                                        size: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
