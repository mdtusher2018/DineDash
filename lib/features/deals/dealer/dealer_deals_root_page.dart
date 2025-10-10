import 'package:dine_dash/features/deals/dealer/edit_deals.dart';
import 'package:dine_dash/features/deals/dealer/widgets/buildDealCard.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/deals/dealer/create_deal.dart';
import 'package:flutter/material.dart';

class DealerDealsRootPage extends StatefulWidget {
  const DealerDealsRootPage({super.key});

  @override
  State<DealerDealsRootPage> createState() => _DealerDealsRootPageState();
}

class _DealerDealsRootPageState extends State<DealerDealsRootPage> {
  List<Map<String, dynamic>> deals = [
    {
      "title": "2 for 1",
      "subText":
          "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
      "duration": "60 Days",
      "location": "Chef's Table",
      'redeemed':"36",
      "benefit": "6 € Benefit",
      "status": "Active",
    },
    {
      "title": "Free Drinks",
      "subText":
          "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
      "duration": "60 Days",
      "location": "Chef's Table",
      'redeemed':"36",
      "benefit": "6 € Benefit",
      "status": "Paused",
    },
  ];

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
            Expanded(child: SingleChildScrollView(child: _buildDealsTab())),
          ],
        ),
      ),
    );
  }

  Widget _buildDealsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// + Add Deal button
          commonBorderButton("+ Add Deal", onTap: () {
            navigateToPage(AddDealScreen());
          }),

          const SizedBox(height: 20),

          /// Deal Cards
          ...deals.map(
            (deal) => buildDealCard(
              title: deal["title"],
              subText: deal["subText"],
              duration: deal["duration"],
              redeemed: deal['redeemed'],
              location: deal["location"],
              benefitText: deal["benefit"],
              status: deal["status"],
              onEdit: () {
                navigateToPage(EditDealScreen());
              },
              onDelete: () {
                  showDeleteConfirmationDialog(
                    context: context,
                    title: "Delete Item",
                    message: "Are you sure you want to delete this item? This action cannot be undone.",
                    onDelete: () {
                      // Perform deletion logic here
                      print("Item deleted");
                    },
                  );
              },
              onToggleStatus: () {
                showPauseReasonDialog(context, (reason) {
                  print("User wants to pause because: $reason");
                
                  // Perform pause logic with reason
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  

}
