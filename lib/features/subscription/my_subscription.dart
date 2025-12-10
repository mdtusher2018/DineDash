import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/subscription/user_subscription_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';

class MySubscriptionsView extends StatefulWidget {
  const MySubscriptionsView({super.key});

  @override
  State<MySubscriptionsView> createState() => _MySubscriptionsViewState();
}

class _MySubscriptionsViewState extends State<MySubscriptionsView> {
  final subscriptionController = Get.put(UserSubscriptionController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      subscriptionController.getMySubscription();
    });
  }

  Widget buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.primaryColor.withOpacity(0.7),
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(child: commonText(text, size: 14)),
        ],
      ),
    );
  }

  Widget buildPlanCard({
    required String title,
    required String subtitle,
    required String price,
    required List<String> features,
    required Widget button,
    Color backgroundColor = Colors.white,
    Color borderColor = Colors.grey,
    Widget? bottomWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              commonText(title, size: 21, isBold: true),
              const SizedBox(height: 6),
              commonText(subtitle, size: 14, isBold: true),
              const SizedBox(height: 12),

              commonText(price, size: 24, isBold: true, color: Colors.black),
              const SizedBox(height: 12),

              ...features.map(buildFeature),

              const SizedBox(height: 16),

              button,

              const SizedBox(height: 4),
              if (bottomWidget != null) ...[SizedBox(height: 8), bottomWidget],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: commonText(
          "My Subscription",
          size: 20,
          isBold: true,
          color: AppColors.primaryColor,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              commonText("Your active subscription plan details", size: 16),
              const SizedBox(height: 12),

              // Observing the mySubscription Rx variable to update UI dynamically
              Obx(() {
                final activePlan =
                    subscriptionController
                        .mySubscription
                        .value
                        ?.subscriptionPlan;

                if (activePlan == null) {
                  return Center(child: Text("No active subscription found"));
                }

                return buildPlanCard(
                  title: activePlan.planName,
                  subtitle: activePlan.description,
                  price: "€${activePlan.price}",
                  features: activePlan.feature,
                  button: commonButton(
                    "Manage Subscription",
                    onTap: () async {
                      if (activePlan.price != 0) {
                        await subscriptionController.payment(
                          activePlan.id,
                          context: context,
                        );
                      }
                    },
                  ),
                  backgroundColor:
                      activePlan.planName.toLowerCase() == "premium"
                          ? Colors.blue.shade50
                          : Colors.white,
                  borderColor:
                      activePlan.planName.toLowerCase() == "premium"
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
