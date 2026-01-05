import 'dart:math';

import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/core/utils/share_links.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_page.dart';
import 'package:dine_dash/features/auth/common/sign_in_sign_up_chooeser.dart';
import 'package:dine_dash/features/business/user/all_review_of_business.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/business_details_controller.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/business_details_response.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/helper_functions_for_book_deal.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/menu_response.dart';
import 'package:dine_dash/features/business/user/map_screen.dart';
import 'package:dine_dash/features/deals/user/user_deal_blocked.dart';
import 'package:dine_dash/core/models/business_model.dart';
import 'package:dine_dash/features/onboarding/UserOnboarding.dart';
import 'package:dine_dash/features/subscription/user_subscription.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class UserBusinessDetailsPage extends StatefulWidget {
  const UserBusinessDetailsPage({
    super.key,
    required this.businessId,
    this.fromDeepLink = false,
  });
  final String businessId;
  final bool fromDeepLink;

  @override
  State<UserBusinessDetailsPage> createState() =>
      _UserBusinessDetailsPageState();
}

class _UserBusinessDetailsPageState extends State<UserBusinessDetailsPage> {
  int selectedTabIndex = 0;

  final BusinessDetailController controller =
      Get.find<BusinessDetailController>();

  final localStorageController = Get.find<LocalStorageService>();
  RxString token = "".obs;

  @override
  void initState() {
    super.initState();
    controller.fetchBusinessDetail(widget.businessId);
    getToken();
  }

  void getToken() async {
    token.value =
        await localStorageController.getString(StorageKey.token) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final business = controller.businessDetail.value;
        if (controller.isLoading.value && business == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (business == null) {
          return Center(
            child: commonText("No details available", size: 16, isBold: true),
          );
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
                  if (widget.fromDeepLink) {
                    // navigateToPage(RoleSelectionPage(), clearStack: true);
                    SessionMemory.isUser = true;
                    if (LocalStorageService.isUserOnboardingCompleated) {
                      navigateToPage(SignInSignUpChooeser(), context: context);
                    } else {
                      navigateToPage(UserOnboardingView(), context: context);
                    }
                  }
                  Navigator.of(context).pop(); // Close dialog first
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
          final business = controller.businessDetail.value;

          if (controller.isLoading.value && business == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (business == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  commonText("No details available", size: 21, isBold: true),
                  if (token.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 8,
                      ),
                      child: commonButton(
                        "Go to Signin",
                        onTap: () {
                          navigateToPage(
                            SignInScreen(),
                            clearStack: true,
                            context: context,
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          }

          return Column(
            children: [
              /// Content
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
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
                              CommonImage("assets/images/medel.png", width: 16),
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
                        runSpacing: 8,
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
                              icon: CommonImage(
                                "assets/images/menu.png",
                                width: 24,
                              ),
                              label: commonText(
                                "Price",
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
                                controller
                                    .unlikeBusiness(widget.businessId)
                                    .then((value) {
                                      if (value) {
                                        final updated =
                                            controller.businessDetail.value!;
                                        updated.isFavourite = false;
                                        controller.businessDetail.refresh();
                                      }
                                    });
                              } else {
                                controller.likeBusiness(widget.businessId).then(
                                  (value) {
                                    if (value) {
                                      final updated =
                                          controller.businessDetail.value!;
                                      updated.isFavourite = true;
                                      controller.businessDetail.refresh();
                                    }
                                  },
                                );
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
                              Share.shareUri(
                                ShareLinks.business(widget.businessId),
                              );
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
                              business.isBusinessOpen
                                  ? "Currently Open".tr
                                  : "Currently Closed".tr,
                              // "Currently Closed".tr,
                              color: Colors.red,
                              isBold: true,
                            ),
                            Spacer(),
                            Icon(
                              Icons.access_time,
                              color: Colors.red,
                              size: 16,
                            ),
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
                              subscriptionRequired: false,
                              isActive: deal.isActive,
                              remainingDeal:
                                  deal.maxClaimCount - deal.redeemCount,
                              activeTime: deal.activeTime,
                              dealId: deal.id,
                              saving: deal.benefitAmount,
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
                                  return buildReviews(
                                    business.feedbacks![index],
                                  );
                                },
                              ),

                              if (business.feedbacks!.length > 5)
                                commonButton(
                                  "All reviews {number}".trParams({
                                    'number': business.totalReview.toString(),
                                  }),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                AllReviewOfBusinessPage(
                                                  feedBacks:
                                                      business.feedbacks!,
                                                ),
                                      ),
                                    );
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
    required String dealId,
    required num saving,
    required int remainingDeal,
    required List<ActiveTime> activeTime,
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
                            child: CommonImage(
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
                    subscriptionRequired: subscriptionRequired,
                    businessId: widget.businessId,
                    businessName: controller.businessDetail.value!.name,
                    dealCount: remainingDeal,
                    saving: saving,
                    dealId: dealId,
                    openingHours: activeTime,
                    onDealTap: (timeRange, day) {
                      Navigator.of(context).pop(); // Close dialog first

                      navigateToPage(
                        (subscriptionRequired)
                            ? SubscriptionView()
                            : UserDealBlockedPage(
                              resturentName:
                                  controller.businessDetail.value!.name,
                              timeRange: timeRange,
                              day: day,
                            ),
                        context: context,
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
              "$saving € Benefit",
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
              Flexible(child: commonText(timeAgo(feedback.createdAt))),
            ],
          ),
          commonText(feedback.text, fontWeight: FontWeight.w500, size: 14),
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
            CommonImage(
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
            CommonImage("assets/images/clock.png", width: 24),
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
                  }),
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
    required int dealCount,
    required Function(String, String) onDealTap,
    required String businessId,
    required String businessName,
    required String dealId,
    required List<ActiveTime> openingHours,
    required num saving,
    bool subscriptionRequired =
        false, //testing purpose remove while api integration
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String? selectedDay;
        int? selectedSlotIndex;

        DateTime? selectedBookingStart;
        DateTime? selectedBookingEnd;

        final groupedHours = groupOpeningHoursByDay(openingHours);
        final sortedDayEntries =
            groupedHours.entries.toList()..sort((a, b) {
              final aDate = nextDateForWeekday(weekdayFromString(a.key));
              final bDate = nextDateForWeekday(weekdayFromString(b.key));
              return aDate.compareTo(bDate);
            });

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.7,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITLE
                        commonText(title, size: 16, isBold: true),
                        const SizedBox(height: 8),
                        commonText(description, size: 13),
                        const SizedBox(height: 16),
                        const Divider(),

                        /// ===== DAY + TIME SLOTS =====
                        ...sortedDayEntries.map((dayEntry) {
                          final day = dayEntry.key;
                          final slots = dayEntry.value;
                          final weekday = weekdayFromString(day);
                          final dateForDay = nextDateForWeekday(weekday);
                          final dayLabel = getDayLabel(dateForDay);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),

                              commonText(dayLabel, size: 13, isBold: true),

                              const SizedBox(height: 4),

                              ...List.generate(slots.length, (index) {
                                final slot = slots[index];
                                final isSelected =
                                    selectedDay == day &&
                                    selectedSlotIndex == index;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDay = day;
                                      selectedSlotIndex = index;

                                      final weekday = weekdayFromString(day);
                                      final bookingDate = nextDateForWeekday(
                                        weekday,
                                      );

                                      final startParts = slot.startTime.split(
                                        ':',
                                      );
                                      final endParts = slot.endTime.split(':');

                                      selectedBookingStart = DateTime(
                                        bookingDate.year,
                                        bookingDate.month,
                                        bookingDate.day,
                                        int.parse(startParts[0]),
                                        int.parse(startParts[1]),
                                      );

                                      selectedBookingEnd = DateTime(
                                        bookingDate.year,
                                        bookingDate.month,
                                        bookingDate.day,
                                        int.parse(endParts[0]),
                                        int.parse(endParts[1]),
                                      );
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? AppColors.primaryColor
                                                : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          isSelected
                                              ? Icons.check_circle
                                              : Icons.radio_button_unchecked,
                                          color:
                                              isSelected
                                                  ? AppColors.primaryColor
                                                  : Colors.grey,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: commonText(
                                            "${slot.startTime} - ${slot.endTime}",
                                            size: 14,
                                            isBold: true,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          spacing: 2,
                                          children: [
                                            commonText(
                                              dealCount.toString(),
                                              color: Colors.grey,
                                            ),
                                            commonText(
                                              "Deals",
                                              size: 12,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        }).toList(),

                        const SizedBox(height: 24),

                        /// ===== CTA =====
                        commonButton(
                          "Go to deal",
                          onTap:
                              selectedBookingStart == null
                                  ? null
                                  : () async {
                                    final result = await controller.goToDeal(
                                      businessId: businessId,
                                      savings: saving.toStringAsFixed(1),
                                      dealId: dealId,
                                      startTime: selectedBookingStart,
                                      endTime: selectedBookingEnd,
                                      index: selectedSlotIndex ?? 0,
                                    );

                                    if (result == true) {
                                      Navigator.pop(context);
                                      navigateToPage(
                                        UserDealBlockedPage(
                                          resturentName: businessName,
                                          day: selectedDay ?? "N/A",
                                          timeRange:
                                              "${selectedBookingStart!.hour.toString().padLeft(2, '0')}:${selectedBookingStart!.minute.toString().padLeft(2, '0')} - "
                                              "${selectedBookingEnd!.hour.toString().padLeft(2, '0')}:${selectedBookingEnd!.minute.toString().padLeft(2, '0')}",
                                        ),
                                        context: context,
                                      );
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                          color: AppColors.primaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
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
                  commonText("Price", size: 18, isBold: true),
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
