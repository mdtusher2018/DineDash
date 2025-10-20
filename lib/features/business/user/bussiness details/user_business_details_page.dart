import 'dart:math';

import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/business/user/all_review_of_business.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/business_details_controller.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/business_details_response.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/menu_response.dart';
import 'package:dine_dash/features/business/user/map_screen.dart';
import 'package:dine_dash/features/deals/user/user_deal_blocked.dart';
import 'package:dine_dash/features/profile/user/user_subscription.dart';
import 'package:dine_dash/core/models/business_model.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class UserBusinessDetailsPage extends StatefulWidget {
  const UserBusinessDetailsPage({super.key, required this.businessId});
  final String businessId;

  @override
  State<UserBusinessDetailsPage> createState() =>
      _UserBusinessDetailsPageState();
}

class _UserBusinessDetailsPageState extends State<UserBusinessDetailsPage> {
  int selectedTabIndex = 0;

  final BusinessDetailController controller =
      Get.find<BusinessDetailController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchBusinessDetail(widget.businessId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final business = controller.businessDetail.value;
        if (business == null) {
          return const Center(child: Text("No details available"));
        }

        return Stack(
          children: [
            Image.network(
              getFullImagePath(business.image ?? ""),
              height: MediaQuery.sizeOf(context).height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              ),
            ),
          ],
        );
      }),

      bottomSheet: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final business = controller.businessDetail.value;
          if (business == null) {
            return const Center(child: Text("No details available"));
          }

          return Column(
            children: [
              /// Content
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async{
                    controller.fetchBusinessDetail(widget.businessId);
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      /// Handle Indicator
                      Center(
                        child: Container(
                          height: 5,
                          width: 40,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                  
                      /// Title, Tags, Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: commonText(
                              business.name,
                              size: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/medel.png", width: 16),
                              SizedBox(width: 4),
                              commonText(
                                business.rating.toStringAsFixed(1),
                                size: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              commonText(
                                "(${business.totalReview})",
                                size: 12,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                  
                      Wrap(
                        spacing: 8,
                        children:
                            business.deals
                                .map(
                                  (tag) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                  
                                    decoration: BoxDecoration(
                                      color: AppColors.lightBlue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: commonText(tag.dealType),
                                  ),
                                )
                                .toList(),
                      ),
                      const SizedBox(height: 8),
                  
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 4),
                          Flexible(
                            child: commonText(
                              business.formattedAddress.toString(),
                              size: 12,
                              maxline: 1,
                            ),
                          ),
                          SizedBox(width: 4),
                          FutureBuilder<String>(
                            future:
                                business
                                    .distanceFromCurrentUser, // the async getter
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return commonText(
                                  "(calculating...)",
                                  size: 12,
                                  color: Colors.grey,
                                );
                              } else if (snapshot.hasError) {
                                return commonText(
                                  "",
                                  size: 12,
                                  color: Colors.grey,
                                );
                              } else {
                                final distance = snapshot.data;
                                return commonText(
                                  ((distance != null) && distance.isNotEmpty)
                                      ? "($distance)"
                                      : "",
                                  size: 12,
                                );
                              }
                            },
                          ),
                  
                          SizedBox(width: 16),
                          commonText(
                            "€€€€",
                            color: Colors.green,
                            isBold: true,
                            size: 14,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                  
                      const SizedBox(height: 12),
                  
                      /// Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: Image.asset(
                                "assets/images/menu.png",
                                width: 24,
                              ),
                              label: commonText(
                                "Menu".tr,
                                isBold: true,
                                size: 14,
                              ),
                              onPressed: () {
                                showMenuBottomSheet(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              if (business.isFavourite) {
                                controller.unlikeBusiness(widget.businessId).then(
                                  (value) {
                                    if (value) {
                                      final updated =
                                          controller.businessDetail.value!;
                                      updated.isFavourite = false;
                                      controller.businessDetail.refresh();
                                    }
                                  },
                                );
                              } else {
                                controller.likeBusiness(widget.businessId).then((
                                  value,
                                ) {
                                  if (value) {
                                    final updated =
                                        controller.businessDetail.value!;
                                    updated.isFavourite = true;
                                    controller.businessDetail.refresh();
                                  }
                                });
                              }
                            },
                            icon: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.black,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                business.isFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final String shareText =
                                  "Check out this awesome business on DineDesh!";
                              final String shareLink = "Share this Resturent";
                              Share.share('$shareText\n$shareLink');
                            },
                            icon: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.black,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.share_outlined),
                            ),
                          ),
                        ],
                      ),
                  
                      Divider(),
                      SizedBox(height: 6),
                  
                      /// Closed banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Spacer(),
                            Icon(Icons.circle, size: 4, color: Colors.red),
                            const SizedBox(width: 8),
                            commonText(
                              "Currently Closed".tr,
                              color: Colors.red,
                              isBold: true,
                            ),
                            Spacer(),
                            Icon(Icons.access_time, color: Colors.red, size: 16),
                            SizedBox(width: 4),
                            commonText(
                              'Opens at {time}'.trParams({
                                'time': business.openTimeText.split('-').first,
                              }),
                              color: Colors.red,
                              size: 12,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                  
                      const SizedBox(height: 16),
                  
                      /// Tab bar (static for now)
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            tabButton(
                              "Deals".tr,
                              0,
                              selectedIndex: selectedTabIndex,
                              onTap: (i) {
                                setState(() => selectedTabIndex = i);
                              },
                            ),
                            tabButton(
                              "Reviews".tr,
                              1,
                              selectedIndex: selectedTabIndex,
                              onTap: (i) {
                                setState(() => selectedTabIndex = i);
                              },
                            ),
                            tabButton(
                              "Information".tr,
                              2,
                              selectedIndex: selectedTabIndex,
                              onTap: (i) {
                                setState(() => selectedTabIndex = i);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Divider(),
                  
                      const SizedBox(height: 8),
                  
                      /// Deal Cards
                      if (selectedTabIndex == 0)
                        ListView.builder(
                          itemCount: business.deals.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final deal = business.deals[index];
                            return buildDealCard(
                              title: deal.dealType,
                              subText: deal.description,
                              duration: "${deal.reuseableAfter} Days",
                              subscriptionRequired: true,
                              isActive: deal.isActive,
                            );
                          },
                        ),
                  
                      if (selectedTabIndex == 1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText(
                              "Ratings & Reviews".tr,
                              size: 16,
                              isBold: true,
                              color: AppColors.primaryColor,
                            ),
                  
                            Row(
                              children: [
                                commonText(
                                  business.rating.toStringAsFixed(1),
                                  size: 18,
                                  isBold: true,
                                ),
                                SizedBox(width: 8),
                                Row(
                                  children: List.generate(5, (index) {
                                    double rating = business.rating;
                                    if (rating >= index + 1) {
                                      // Full star
                                      return Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      );
                                    } else if (rating > index &&
                                        rating < index + 1) {
                                      // Half star (optional)
                                      return Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                        size: 20,
                                      );
                                    } else {
                                      // Empty star
                                      return Icon(
                                        Icons.star_border,
                                        color: Colors.grey.shade400,
                                        size: 20,
                                      );
                                    }
                                  }),
                                ),
                              ],
                            ),
                  
                            commonText(
                              "${business.userRatingsTotal} ratings | ${business.totalReview} reviews",
                              color: Colors.blueGrey,
                              isBold: true,
                            ),
                            if (business.feedbacks != null) ...[
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: min(business.feedbacks!.length, 3),
                                itemBuilder: (context, index) {
                                  return buildReviews(business.feedbacks![index]);
                                },
                              ),
                  
                              if (business.feedbacks!.length > 5)
                                commonButton(
                                  "All reviews {number}".trParams({
                                    'number': business.totalReview.toString(),
                                  }),
                                  onTap: () {
                                    Get.to(AllReviewOfBusinessPage(feedBacks: business.feedbacks!,));
                                  },
                                ),
                            ],
                          ],
                        ),
                      if (selectedTabIndex == 2) restaurantInfoTab(business),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget tabButton(
    String text,
    int index, {
    required int selectedIndex,
    required Function(int) onTap,
  }) {
    final bool isActive = index == selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: commonText(
              text,
              color: isActive ? Colors.white : Colors.black,
              isBold: true,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDealCard({
    required String title,
    required String subText,
    required String duration,
    bool subscriptionRequired =
        false, //testing purpose remove while api intregration
    required bool isActive,
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16, top: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Badge
              const SizedBox(height: 8),

              commonText(title, size: 16, isBold: true),
              const SizedBox(height: 8),
              commonText(subText, size: 13, color: Colors.black87),
              const SizedBox(height: 12),

              /// Info Row
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              "assets/images/time222.png",
                              width: 24,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonText("Reusable After", size: 12),
                              commonText(duration, size: 12, isBold: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// Book button
              commonButton(
                (subscriptionRequired)
                    ? "Subscribe to book a deal"
                    : (isActive)
                    ? "Book deal"
                    : "Booked",
                color: AppColors.primaryColor,
                height: 40,
                onTap: () {
                  showDealBottomSheet(
                    context,
                    title: title,
                    description: subText,
                    days: ["Today", "Tomorrow", "Monday", "Tuesday"],
                    selectedDay: "Today",
                    timeRange: "12:00 - 20:00",
                    dealCount: 15,
                    subscriptionRequired: subscriptionRequired,
                    onDealTap: () {
                      Get.back();

                      navigateToPage(
                        (subscriptionRequired)
                            ? SubscriptionView()
                            : UserDealBlockedPage(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: commonText(
              "6 € Benefit",
              color: Colors.white,
              size: 12,
              isBold: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReviews(FeedbackData feedback) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      getFullImagePath(feedback.reviewer.image),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8),
              commonText(feedback.reviewer.fullName, isBold: true, size: 16),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  num rating = feedback.rating;
                  if (rating >= index + 1) {
                    // Full star
                    return Icon(Icons.star, color: Colors.amber, size: 20);
                  } else if (rating > index && rating < index + 1) {
                    // Half star (optional)
                    return Icon(Icons.star_half, color: Colors.amber, size: 20);
                  } else {
                    // Empty star
                    return Icon(
                      Icons.star_border,
                      color: Colors.grey.shade400,
                      size: 20,
                    );
                  }
                }),
              ),
              SizedBox(width: 4),
              Container(width: 1, height: 16, color: Colors.grey),
              SizedBox(width: 4),
              Flexible(child: commonText("1 month ago")),
            ],
          ),
          commonText(
            "This is a comment",
            fontWeight: FontWeight.w500,
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget restaurantInfoTab(BusinessModel business) {
    final today = DateFormat('EEEE').format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Location
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/location2.png",
              width: 24,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(
                    "Location",
                    isBold: true,
                    color: AppColors.primaryColor,
                    size: 16,
                  ),
                  commonText(business.formattedAddress.toString()),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// Map preview (circular)
        Center(
          child: ClipOval(
            child: MapScreen(
              longitude: business.location?.coordinates[0],
              latitude: business.location?.coordinates[1],
            ),
          ),
        ),

        const SizedBox(height: 24),

        /// Contact
        Row(
          children: [
            Icon(Icons.phone_outlined, color: AppColors.primaryColor),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText(
                  "Contact",
                  isBold: true,
                  color: AppColors.primaryColor,
                  size: 16,
                ),
                commonText(business.phoneText),
              ],
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/clock.png", width: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      commonText(
                        "Opening hours",
                        isBold: true,
                        color: AppColors.primaryColor,
                        size: 16,
                      ),
                    ],
                  ),

                  ...business.formattedOpeningHours.entries.map((entry) {
                    final isToday = entry.key == today;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: commonText(
                              entry.key,
                              color:
                                  isToday
                                      ? AppColors.primaryColor
                                      : Colors.black,
                              isBold: isToday,
                            ),
                          ),
                          commonText(
                            entry.value,
                            color:
                                isToday ? AppColors.primaryColor : Colors.black,
                            isBold: isToday,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      const Text("• "),
                      Flexible(
                        child: commonText(
                          "Opening hours might differ due to public holidays.",
                          size: 12,
                          color: Colors.black87,
                          isBold: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  void showDealBottomSheet(
    BuildContext context, {
    required String title,
    required String description,
    required List<String> days,
    required String selectedDay,
    required String timeRange,
    required int dealCount,
    required VoidCallback onDealTap,
    bool subscriptionRequired =
        false, //testing purpose remove while api intregration
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String selectedDayState = selectedDay;
        String selectedTimeRange = timeRange;

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child:
                      (subscriptionRequired)
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 16),
                              Icon(
                                Icons.lock_outline_rounded,
                                size: 48,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(height: 16),
                              commonText(
                                "Subscription Required",
                                size: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 8),
                              commonText(
                                "You need an active subscription to access this deal.\nPlease subscribe to continue.",
                                size: 14,
                                color: Colors.grey.shade700,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              commonButton(
                                "View Subscription Plans",
                                onTap: () {
                                  onDealTap(); // Replace with actual navigation to plans
                                },
                                color: AppColors.primaryColor,
                                textColor: Colors.white,
                              ),
                            ],
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              commonText(title, size: 16, isBold: true),
                              const SizedBox(height: 8),

                              // Description
                              commonText(description, size: 13),
                              const SizedBox(height: 12),

                              const Divider(height: 1),
                              const SizedBox(height: 12),

                              // Day Section
                              commonText("Day", isBold: true, size: 14),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children:
                                    days.map((day) {
                                      final isSelected =
                                          day == selectedDayState;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedDayState = day;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                isSelected
                                                    ? AppColors.primaryColor
                                                    : Colors.grey.shade100,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            border: Border.all(
                                              color:
                                                  isSelected
                                                      ? Colors.transparent
                                                      : Colors.black,
                                            ),
                                          ),
                                          child: commonText(
                                            day,
                                            color:
                                                isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),

                              const SizedBox(height: 16),

                              // Time Section
                              commonText("Time", isBold: true, size: 14),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () async {
                                  TimeOfDay? start = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (start != null) {
                                    TimeOfDay? end = await showTimePicker(
                                      context: context,
                                      initialTime: start,
                                    );
                                    if (end != null) {
                                      setState(() {
                                        selectedTimeRange =
                                            "${start.format(context)} - ${end.format(context)}";
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      commonText(
                                        selectedTimeRange,
                                        size: 13,
                                        isBold: true,
                                      ),
                                      const Spacer(),
                                      commonText(
                                        "$dealCount Deals",
                                        size: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // CTA Button
                              commonButton(
                                "Go to deal",
                                onTap: () {
                                  // Use selectedDayState and selectedTimeRange here
                                  print("Selected Day: $selectedDayState");
                                  print("Selected Time: $selectedTimeRange");

                                  onDealTap();
                                },
                                color: AppColors.primaryColor,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showMenuBottomSheet(BuildContext context) {
    controller.fetchMenu(businessId: widget.businessId);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.6,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Example from the"),
                  commonText("Menu", size: 18, isBold: true),
                  Divider(color: AppColors.black),
                  Obx(() {
                    if (controller.menuData.value == null) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.menuData.value!.isEmpty) {
                      return Center(child: commonText("No menu available"));
                    } else {
                      return ListView.builder(
                        itemCount: controller.menuData.value!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final MenuItem item =
                              controller.menuData.value![index];
                          return ListTile(
                            minVerticalPadding: 8,
                            minLeadingWidth: 0,
                            contentPadding: EdgeInsets.all(0),
                            title: commonText(
                              item.itemName,
                              size: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            subtitle: commonText(item.description),
                            trailing: commonText("${item.price} €"),
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
