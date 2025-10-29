import 'package:dine_dash/features/deals/user/available%20deals/user_allavailable_deals_controller.dart';
import 'package:dine_dash/features/deals/user/widget/deal_card.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../user_deals_details.dart';

class UserAllAvailableDeals extends StatefulWidget {
  const UserAllAvailableDeals({super.key});

  @override
  State<UserAllAvailableDeals> createState() => _UserAllAvailableDealsState();
}

class _UserAllAvailableDealsState extends State<UserAllAvailableDeals> {
  final controller = Get.find<UserAvailableDealsController>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.fetchDealsList();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !controller.isLoadingMore.value &&
          controller.hasMore.value) {
        controller.loadMoreAvailableDeals();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Available Deals"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            shrinkWrap: true,
            controller: scrollController,

            itemCount: controller.availableDeals.length + 1,
            itemBuilder: (context, index) {
              if (index < controller.availableDeals.length) {
                final deal = controller.availableDeals[index];
                return GestureDetector(
                  onTap: () => Get.to(() => UserDealsDetails(dealData: deal,)),
                  child: dealCard(deal: deal,isUsed: false),
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
