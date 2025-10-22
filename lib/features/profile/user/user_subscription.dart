// ignore_for_file: must_be_immutable

import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionView extends StatefulWidget {
  bool fromSignup;
  SubscriptionView({super.key, this.fromSignup = false});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  bool isMonthlySelected = true;
  final subscriptionController = Get.put(SubscriptionController());


  void togglePlan(bool monthly) {
    setState(() {
      isMonthlySelected = monthly;
    });
  }

  Widget buildToggleButton(
    String text,
    bool selected,
    VoidCallback onTap, {
    Widget? badge,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            decoration: BoxDecoration(
              color: selected ? Colors.blue.shade100 : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: commonText(
              text,
              size: 16,
              isBold: true,
              color: selected ? AppColors.primaryColor : Colors.grey.shade700,
            ),
          ),
          if (badge != null) ...[const SizedBox(width: 6), badge],
        ],
      ),
    );
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
    bool isMostPopular = false,
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
            children: [
              if (isMostPopular) const SizedBox(height: 12),

              commonText(title, size: 21, isBold: true),
              const SizedBox(height: 6),
              commonText(subtitle, size: 14, isBold: true),
              const SizedBox(height: 12),

              commonText(price, size: 24, isBold: true, color: Colors.black),
              const SizedBox(height: 12),

              if (isMostPopular)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: commonText(
                    "7-day free trial\nTry all premium features free for 7 days",
                    size: 14,
                    isBold: true,
                    color: AppColors.primaryColor,
                  ),
                ),

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
          "Choose Your Plan",
          size: 20,
          isBold: true,
          color: AppColors.primaryColor,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            commonText(
              "Select the plan that fits your culinary journey",
              size: 16,
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildToggleButton(
                  "Monthly",
                  isMonthlySelected,
                  () => togglePlan(true),
                ),
                const SizedBox(width: 16),
                buildToggleButton(
                  "Yearly",
                  !isMonthlySelected,
                  () => togglePlan(false),
                  badge: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: commonText(
                      "Save 17%",
                      size: 12,
                      color: AppColors.white,
                      isBold: true,
                    ),
                  ),
                ),
              ],
            ),


          Expanded(
  child: Obx(() {
    if (subscriptionController.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

    final filteredPlans = subscriptionController.subscriptions
        .where((plan) =>
            isMonthlySelected
                ? plan.planCategory == 'monthly'
                : plan.planCategory == 'yearly')
        .toList();

    return ListView.builder(
      itemCount: filteredPlans.length,
      itemBuilder: (context, index) {
        final plan = filteredPlans[index];

        return buildPlanCard(
          title: plan.planName,
          subtitle: plan.shortBio,
          price:  "€${plan.price} / ${plan.timeline} days",
          features: plan.facilities,
          isMostPopular: plan.planName.toLowerCase() == "premium",
          backgroundColor: plan.planName.toLowerCase() == "premium"
              ? Colors.blue.shade50
              : Colors.white,
          borderColor: plan.planName.toLowerCase() == "premium"
              ? AppColors.primaryColor
              : Colors.grey.shade300,
          button: commonButton(
            plan.price == 0 ? "Start Free" : "Subscribe Now",
            onTap: () async{
       
              
            },
          ),
          bottomWidget: plan.price == 0
              ? null
              : Center(
                  child: commonText(
                    "No commitment. Cancel anytime.",
                    size: 12,
                    color: Colors.black54,
                    textAlign: TextAlign.center,
                  ),
                ),
        );
      },
    );
  }),
),

          
          ],
        ),
      ),
    );
  }
}







class SubscriptionPlan {
  final String id;
  final String planName;
  final String shortBio;
  final double price;
  final String planCategory; // 'monthly' or 'yearly'
  final int timeline;
  final List<String> facilities;

  SubscriptionPlan({
    required this.id,
    required this.planName,
    required this.shortBio,
    required this.price,
    required this.planCategory,
    required this.timeline,
    required this.facilities,
  });
}



class SubscriptionController extends GetxController {
  var subscriptions = <SubscriptionPlan>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDemoData(); // For demo purposes
  }

  void loadDemoData() {
    isLoading.value = true;
    subscriptions.value = [
      SubscriptionPlan(
        id: '1',
        planName: 'Free',
        shortBio: 'Basic access to try things out',
        price: 0.0,
        planCategory: 'monthly',
        timeline: 30,
        facilities: [
          'Access to basic recipes',
          'Limited meal plans',
        ],
      ),
      SubscriptionPlan(
        id: '2',
        planName: 'Premium',
        shortBio: 'Full access to all features',
        price: 4.99,
        planCategory: 'monthly',
        timeline: 30,
        facilities: [
          'Unlimited recipes',
          'Personalized meal plans',
          'Offline access',
        ],
      ),
      SubscriptionPlan(
        id: '3',
        planName: 'Premium',
        shortBio: 'Full access with yearly savings',
        price: 49.99,
        planCategory: 'yearly',
        timeline: 365,
        facilities: [
          'Unlimited recipes',
          'Personalized meal plans',
          'Offline access',
          'Priority support',
        ],
      ),
    ];
    isLoading.value = false;
  }
}
