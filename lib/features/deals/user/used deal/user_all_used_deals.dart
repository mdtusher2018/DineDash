import 'package:dine_dash/features/deals/user/used%20deal/user_used_deals_controller.dart';
import 'package:dine_dash/features/deals/user/widget/deal_card.dart';
import 'package:dine_dash/features/ratting_and_feedback/user/feedback_of_a_business.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAllUsedDeals extends StatefulWidget {
  const UserAllUsedDeals({super.key});

  @override
  State<UserAllUsedDeals> createState() => _UserAllUsedDealsState();
}

class _UserAllUsedDealsState extends State<UserAllUsedDeals> {
  final controller = Get.find<UserAllUseddDealsController>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchUsedDealsList();

      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 300 &&
            !controller.isLoadingMore.value &&
            controller.hasMore.value) {
          controller.loadMoreUsedDeals();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Used Deals"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            shrinkWrap: true,
            controller: scrollController,

            itemCount: controller.usedDeals.length + 1,
            itemBuilder: (context, index) {
              if (index < controller.usedDeals.length) {
                final deal = controller.usedDeals[index];
                return GestureDetector(
                  onTap:
                      () => Get.to(
                        () => UserAfterGivingStarPage(dealId: deal.dealId),
                      ),
                  child: dealCard(deal: deal, isUsed: true),
                );
              } else {
                // Show loader at bottom
                return Obx(
                  () =>
                      controller.isLoadingMore.value
                          ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                          : SizedBox(),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
