import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/deals/dealer/dealer_all_deals/dealer_all_deals_controller.dart';
import 'package:dine_dash/features/deals/dealer/edit_deal/edit_deals.dart';
import 'package:dine_dash/res/buildDealCard.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/deals/dealer/create_deal/create_deal.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchAllDeals();
    });
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
                "Manage deals across all your businesses",
                size: 14,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: commonBorderButton(
                "+ Add Deal",
                onTap: () {
                  navigateToPage(AddDealScreen(), context: context);
                },
              ),
            ),
            Obx(() {
              final visibleDeals =
                  controller.deals.where((deal) => !deal.isDeleted).toList();

              if (controller.isLoading.value && controller.deals.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else if (visibleDeals.isEmpty) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.fetchAllDeals();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommonImage(
                                "assets/images/no_deals_white_background.png",
                              ),
                              const SizedBox(height: 16),

                              Text(
                                "Pull down to refresh",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),

                              Center(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    controller.fetchAllDeals();
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
                        ),
                      ),
                    ),
                  ),
                );
              } else {
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
                        if (deal.isDeleted) {
                          return SizedBox.shrink();
                        }
                        return buildDealCard(
                          title: deal.dealType,
                          subText: deal.description,
                          isActive: deal.isActive,
                          duration: deal.reuseableAfter.toString(),
                          redeemed: deal.redeemCount.toString(),
                          location: deal.businessName,
                          benefitText: deal.benefitAmmount.toString(),
                          status: deal.status,
                          onEdit: () {
                            navigateToPage(
                              EditDealScreen(
                                dealId: deal.dealId,
                                businessId: deal.businessId,
                              ),
                              context: context,
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
                                      deleteManually: () {},
                                    );
                                  },
                                  title: "Why do you want to delete this deal?",
                                );
                              },
                            );
                          },
                          onToggleStatus: () {
                            showReasonDialog(context, (p0) {
                              controller.pauseDeal(
                                dealId: deal.dealId,
                                ispaused: deal.isActive,
                                reason: p0,
                              );
                            });
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
