import 'package:dine_dash/core/models/my_business_name_response.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/ratting/dealer/review_controller.dart';

import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class DealerReview extends StatefulWidget {
  const DealerReview({super.key});

  @override
  State<DealerReview> createState() => _DealerReviewState();
}

class _DealerReviewState extends State<DealerReview> {
  final controller = Get.find<FeedbackController>();

  @override
  void initState() {
    super.initState();
    controller.fetchFeedback();
    controller.fetchAllBusinessesName();
  }

  String? sortBy;
  String? rattingBy;
  DealerBusinessItem? businessBy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.feedbackResponse.value == null &&
            controller.isLoading.value) {
          return CircularProgressIndicator();
        }

        if (controller.feedbackResponse.value == null &&
            !controller.isLoading.value) {
          return Center(child: commonText("No Data Found"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        commonText(
                          controller
                              .feedbackResponse
                              .value!
                              .feedBackAttributes
                              .totalReview
                              .toString(),
                          size: 30,
                          fontWeight: FontWeight.w600,
                        ),
                        commonText(
                          "Total Reviews".tr,
                          size: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        commonText(
                          (controller
                                  .feedbackResponse
                                  .value!
                                  .feedBackAttributes
                                  .businessRating)
                              .toStringAsFixed(1),
                          size: 30,
                          fontWeight: FontWeight.w600,
                        ),
                        commonText(
                          "Average Rating".tr,
                          size: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      commonText(
                        "Rating Distribution".tr,
                        size: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Column(
                          children: List.generate(5, (index) {
                            int star = 5 - index;

                            final group = controller
                                .feedbackResponse
                                .value!
                                .feedBackAttributes
                                .ratingGroups
                                .firstWhereOrNull(
                                  (element) => element.id == star,
                                );

                            num percent =
                                controller
                                            .feedbackResponse
                                            .value!
                                            .feedBackAttributes
                                            .userRatingsTotal >
                                        0
                                    ? (group == null)
                                        ? 0
                                        : (group.count /
                                                controller
                                                    .feedbackResponse
                                                    .value!
                                                    .feedBackAttributes
                                                    .userRatingsTotal)
                                            as num
                                    : 0.0;
                            if (percent > 1) {
                              percent = 1.0;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  commonText("$star★", size: 12),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                        FractionallySizedBox(
                                          widthFactor:
                                              percent
                                                  .toDouble(), // 👈 dynamic width
                                          child: Container(
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 340,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/filter.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(width: 5),
                            commonText(
                              "Filters".tr,
                              size: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        commonText(
                          "Business",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 10),
                        commonDropdown(
                          items: controller.businessesName,
                          color: Colors.transparent,
                          value: businessBy,
                          labelBuilder: (item) => item.businessName,
                          elevation: 0,
                          hint: "Select your business",
                          onChanged: (value) {
                            businessBy = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        commonText(
                          "Rating",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 10),
                        commonDropdown(
                          items: [
                            "All Stars",
                            "5 Stars",
                            "4 Stars",
                            "3 Stars",
                            "2 Stars",
                            "1 Stars",
                          ],
                          color: Colors.transparent,
                          value: rattingBy,
                          elevation: 0,
                          hint: "Select your ratting",
                          onChanged: (value) {
                            rattingBy = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),

                        commonText(
                          "Sort By",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 10),

                        commonDropdown(
                          items: [
                            "Newest first",
                            "Oldest first",
                            "Highest rating",
                          ],
                          color: Colors.transparent,
                          value: sortBy,
                          elevation: 0,
                          hint: "Select your sort",
                          onChanged: (value) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),
                ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount:
                      controller
                          .feedbackResponse
                          .value!
                          .feedBackAttributes
                          .data
                          .length,
                  itemBuilder: (context, index) {
                    final feedBack =
                        controller
                            .feedbackResponse
                            .value!
                            .feedBackAttributes
                            .data[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 194,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: SizedBox(
                                  height: 50,
                                  width: 50,

                                  child: Image.network(
                                    getFullImagePath(feedBack.reviewerImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              commonText(
                                feedBack.reviewerFullName,
                                size: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 10,
                            children: [
                              Image.asset(
                                "assets/images/noted.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.fill,
                              ),
                              commonText(
                                feedBack.businessName,
                                size: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff555555),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 10,
                            children: [
                              RatingBar.builder(
                                initialRating: feedBack.rating.toDouble(),
                                itemSize: 20,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                itemBuilder:
                                    (context, _) =>
                                        Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              SizedBox(
                                height: 15,
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              commonText(
                                timeAgo(feedBack.createdAt),
                                size: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff555555),
                              ),
                            ],
                          ),
                          commonText(
                            feedBack.text,
                            size: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff555555),
                          ),
                          Container(
                            height: 32,
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.sizeOf(context).width / 2,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffB7CDF5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                commonText(
                                  "Used :",
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                commonText(
                                  feedBack.dealType,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
