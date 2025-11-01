import 'package:dine_dash/features/deals/dealer/dealer_deal_root_page/dealer_all_deals_controller.dart';
import 'package:dine_dash/features/deals/dealer/edit_deals.dart';
import 'package:dine_dash/res/buildDealCard.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/deals/dealer/create_deal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealerDealsRootPage extends StatefulWidget {
  const DealerDealsRootPage({super.key});

  @override
  State<DealerDealsRootPage> createState() => _DealerDealsRootPageState();
}

class _DealerDealsRootPageState extends State<DealerDealsRootPage> {
  final controller = Get.find<DealerAllDealsController>();

  @override
  void initState() {
    super.initState();
    controller.fetchAllDeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: commonText("All Deals", size: 18, isBold: true),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: commonText(
                "Manage deals across all your resturant",
                size: 14,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: commonBorderButton(
                "+ Add Deal",
                onTap: () {
                  navigateToPage(AddDealScreen());
                },
              ),
            ),
            Obx(() {
              if (controller.isLoading.value && controller.deals.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchAllDeals();
                  },
                  child: ListView.builder(
                    itemCount: controller.deals.length,
                    padding: const EdgeInsets.all(16),

                    itemBuilder: (context, index) {
                      final deal = controller.deals[index];
                      if (deal.reasonFor == "deleted") {
                        return SizedBox.shrink();
                      }
                      return buildDealCard(
                        title: deal.dealType,
                        subText: deal.description,
                        duration: deal.reuseableAfter.toString(),
                        redeemed: deal.redeemCount.toString(),
                        location: deal.businessName,
                        benefitText: deal.benefitAmmount.toString(),
                        status: deal.isActive ? "Active" : "Paused",
                        onEdit: () {
                          navigateToPage(
                            EditDealScreen(
                              dealId: deal.dealId,
                              businessId: deal.businessId,
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
                              showReasonDialog(
                                context,
                                (p0) {
                                  controller.deleteDeal(
                                    reason: p0,
                                    dealId: deal.dealId,
                                    deleteManually: () {
                                      controller.deals.removeWhere((element) {
                                        return element.id == deal.id;
                                      });
                                      setState(() {});
                                    },
                                  );
                                },
                                title: "Why do you want to delete this deal?",
                              );
                            },
                          );
                        },
                        onToggleStatus: () {
                          if (deal.isActive) {
                            showReasonDialog(context, (reason) {
                              print("User wants to pause because: $reason");
                              // Perform pause logic with reason
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
