import 'package:dine_dash/core/models/my_business_name_response.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/business/dealer/add_menu/add_menu_page.dart';
import 'package:dine_dash/features/business/dealer/dealer_business_details/dealer_business_details_controller.dart';
import 'package:dine_dash/features/business/dealer/dealer_business_details/dealer_business_details_response.dart';
import 'package:dine_dash/features/business/dealer/edit_menu/edit_menu_page.dart';
import 'package:dine_dash/features/deals/dealer/edit_deal/edit_deals.dart';
import 'package:dine_dash/res/buildDealCard.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/deals/dealer/create_deal/create_deal.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:get/get.dart';

import '../../user/all_review_of_business.dart';

class DealerBusinessDetailsPage extends StatefulWidget {
  const DealerBusinessDetailsPage({super.key, required this.businessId});
  final String businessId;

  @override
  State<DealerBusinessDetailsPage> createState() =>
      _DealerBusinessDetailsPageState();
}

class _DealerBusinessDetailsPageState extends State<DealerBusinessDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final controller = Get.find<DealerBusinessDetailController>();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    controller.fetchBusinessDetail(widget.businessId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value ||
          controller.businessDetail.value == null) {
        return Scaffold(
          appBar: commonAppBar(title: "Business Details"),
          body:
              (controller.isLoading.value)
                  ? const Center(child: CircularProgressIndicator())
                  : Center(child: commonText("No Data Found")),
        );
      }
      return Scaffold(
        appBar: commonAppBar(title: controller.businessDetail.value!.name),
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildHeaderCard(),
            ),
            const SizedBox(height: 10),
            _buildStatsRow(),
            const SizedBox(height: 16),
            Divider(height: 1),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.fetchBusinessDetail(widget.businessId);
                    },
                    child: _buildDealsTab(),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.fetchBusinessDetail(widget.businessId);
                    },
                    child: MenuTab(),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.fetchBusinessDetail(widget.businessId);
                    },
                    child: buildReviewsTab(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeaderCard() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                getFullImagePath(controller.businessDetail.value!.image ?? ""),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(
                    controller.businessDetail.value!.name,
                    size: 16,
                    isBold: true,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: commonText(
                          controller.businessDetail.value!.formattedAddress ??
                              "N/A",

                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFFCCF3D9),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: commonText(
                      "${controller.businessDetail.value!.activeDealCount} active deals",
                      size: 12,
                      color: Color(0xFF168368),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildStatBox(
            controller.businessDetail.value!.activeDealCount.toString(),
            "Active Deals",
          ),
          _buildStatBox(
            controller.businessDetail.value!.totalReview.toString(),
            "Total Reviews",
          ),
          _buildStatBox(
            controller.businessDetail.value!.redeemCount.toString(),
            "Redeemed Deals",
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String count, String label) {
    return Expanded(
      child: Column(
        children: [
          commonText(count, size: 18, isBold: true),
          commonText(label, size: 12, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.primaryColor,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: Colors.grey,
      tabs: [
        Tab(
          child: commonText(
            "Deals (${controller.businessDetail.value!.activeDealCount})",
            size: 14,
            isBold: true,
          ),
        ),
        Tab(child: commonText("Menu", size: 14, isBold: true)),
        Tab(
          child: commonText(
            "Reviews (${controller.businessDetail.value!.totalReview})",
            size: 14,
            isBold: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDealsTab() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// + Add Deal button
          commonBorderButton(
            "+ Add Deal",
            onTap: () {
              navigateToPage(
                AddDealScreen(
                  selectedBusiness: DealerBusinessItem(
                    id: controller.businessDetail.value!.id,
                    businessName: controller.businessDetail.value!.name,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          /// Deal Cards
          ...controller.businessDetail.value!.dealsData.map((deal) {
            if (deal.reasonFor == "deleted") {
              return SizedBox.shrink();
            }
            return buildDealCard(
              title: deal.dealType,
              subText: deal.description,
              duration: deal.reuseableAfter.toString(),
              redeemed: deal.redeemCount.toString(),
              location: controller.businessDetail.value!.name,
              benefitText: deal.benefitAmount.toString(),
              status: deal.isActive ? "Active" : "Paused",
              onEdit: () {
                navigateToPage(
                  EditDealScreen(
                    dealId: deal.id,
                    businessId: controller.businessDetail.value!.id,
                  ),
                );
              },
              onDelete: () {
                showDeleteConfirmationDialog(
                  context: context,
                  title: "Delete Item",
                  message:
                      "Are you sure you want to delete this item? This action cannot be undone.",
                  onDelete: () {
                    showReasonDialog(context, (p0) {
                      controller.deleteDeal(
                        reason: p0,
                        dealId: deal.id,
                        deleteManually: () {
                          controller.businessDetail.value!.dealsData
                              .removeWhere((element) {
                                return element.id == deal.id;
                              });
                          setState(() {});
                        },
                      );
                    }, title: "Why do you want to delete this deal?");
                  },
                );
              },
              onToggleStatus: () {
                showReasonDialog(context, (reason) {
                  print("User wants to pause because: $reason");
                  // Perform pause logic with reason
                });
              },
            );
          }),
        ],
      ),
    );
  }

  Widget buildReviewsTab() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Ratings Summary Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: commonText("Overall Feedback", size: 16, isBold: true),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            commonText(
                              controller.businessDetail.value!.rating
                                  .toString(),
                              size: 28,
                              isBold: true,
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.star, size: 24),
                          ],
                        ),
                        const SizedBox(height: 4),
                        commonText(
                          "${controller.businessDetail.value!.userRatingsTotal} Ratings \n&\n${controller.businessDetail.value!.totalReview} Reviews",
                          size: 12,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        children: List.generate(5, (index) {
                          int star = 5 - index;

                          double percent =
                              controller
                                  .businessDetail
                                  .value
                                  ?.ratingCounts
                                  ?.ratingPercentages[star] ??
                              0.0;

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
                                            percent, // 👈 dynamic width
                                        child: Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
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
              ],
            ),
          ),
          const SizedBox(height: 20),

          /// Reviews List
          ...controller.businessDetail.value!.feedbacksData
              .take(
                controller.businessDetail.value!.feedbacksData.length < 3
                    ? controller.businessDetail.value!.feedbacksData.length
                    : 3,
              )
              .map(
                (feedBack) => _buildReviewItem(
                  name: feedBack.reviewer.fullName,
                  image: feedBack.reviewer.image,
                  stars: feedBack.rating,
                  timeAgo: timeAgo(feedBack.createdAt.toString()),
                  comment: feedBack.text,
                ),
              ),

          const SizedBox(height: 20),

          /// All Reviews Button
          if (controller.businessDetail.value!.totalReview > 3)
            commonButton(
              "All reviews (${controller.businessDetail.value!.totalReview})",
              height: 48,
              onTap:
                  () => Get.to(
                    AllReviewOfBusinessPage(
                      feedBacks: controller.businessDetail.value!.feedbacksData,
                    ),
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildReviewItem({
    required String name,
    required String image,
    required num stars,
    required String timeAgo,
    required String comment,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Avatar + Name
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(getFullImagePath(image)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              commonText(name, isBold: true, size: 16),
            ],
          ),
          const SizedBox(height: 6),

          /// Rating and Time
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < stars ? Colors.amber : Colors.grey.shade400,
                    size: 18,
                  );
                }),
              ),
              const SizedBox(width: 8),
              Container(width: 1, height: 14, color: Colors.grey),
              const SizedBox(width: 8),
              commonText(timeAgo, size: 12, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 6),

          /// Comment
          commonText(comment, fontWeight: FontWeight.w500, size: 14),
        ],
      ),
    );
  }
}


class MenuTab extends StatefulWidget {
  @override
  _MenuTabState createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  bool showActions = false; // global toggle

  final controller = Get.find<DealerBusinessDetailController>();
  @override
  Widget build(BuildContext context) {
    final menuData = controller.businessDetail.value!.menuData; // your data list

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonBorderButton(
              "+ Add Items",
              onTap: () {
                navigateToPage(
                  AddMenuScreen(
                    businessId: controller.businessDetail.value!.id,
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("Example from the", size: 14),
                      commonText("Menu", size: 18, isBold: true),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showActions = !showActions; // toggle slide animation
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/images/editb.png", width: 16),
                        commonText(" Edit", size: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(),

            ListView.builder(
              itemCount: menuData.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = menuData[index];

                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.only(right: showActions ? 100 : 0),
                      child: ListTile(
                        minVerticalPadding: 8,
                        contentPadding: EdgeInsets.all(0),
                        title: commonText(
                          item.itemName,
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        subtitle: commonText(item.description),
                        trailing: commonText(
                          item.price.toStringAsFixed(2),
                        ),
                      ),
                    ),

                    // Animated action buttons entering from the right
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 400),
                      right: showActions ? 16 : -120, // slide from off-screen
                      curve: Curves.easeInOut,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              navigateToPage(EditMenuScreen(menu: item,));
                            },
                            child: Image.asset("assets/images/editb.png", width: 21)),
                   SizedBox(width: 16,),
                         Image.asset("assets/images/delete.png",width: 20,)
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
