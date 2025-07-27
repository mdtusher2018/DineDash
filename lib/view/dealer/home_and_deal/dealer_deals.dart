import 'package:dine_dash/view/dealer/home_and_deal/edit_deals.dart';
import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/dealer/home_and_deal/create_deal.dart';
import 'package:flutter/material.dart';

class DealerDealsPage extends StatefulWidget {
  const DealerDealsPage({super.key});

  @override
  State<DealerDealsPage> createState() => _DealerDealsPageState();
}

class _DealerDealsPageState extends State<DealerDealsPage> {
  List<Map<String, dynamic>> deals = [
    {
      "title": "2 for 1",
      "subText":
          "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
      "duration": "60 Days",
      "location": "Chef's Table",
      "benefit": "6 € Benefit",
      "status": "Active",
    },
    {
      "title": "Free Drinks",
      "subText":
          "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
      "duration": "60 Days",
      "location": "Chef's Table",
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

  Widget buildDealCard({
    required String title,
    required String subText,
    required String duration,
    required String location,
    required String benefitText,
    required String status, // "Active" or "Paused"
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required VoidCallback onToggleStatus,
  }) {
    Color statusColor = status == "Active" ? Color(0xFF90EE90) : Color(0xFFFFDF00);
    Color textColor = status == "Active" ? Color(0xFF056608) : Color(0xFF735900);
    

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Status Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: commonText(title, size: 16, isBold: true)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: commonText(
                      status,
                      size: 12,
                      color: textColor,
                      isBold: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// Subtitle
              commonText(subText, size: 13, color: Colors.black87),
              const SizedBox(height: 12),

              /// Reusable & Location
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            "assets/images/time222.png",
                            height: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            "assets/images/location2.png",
                            height: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Location", size: 12),
                            commonText(location, size: 12, isBold: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Actions: Edit | Pause/Active | Delete
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  actionButton(Image.asset("assets/images/lucide_edit.png"), "Edit", onEdit),
                  actionButton(
                    status == "Active"
                        ? Image.asset("assets/images/pause.png")
                        : Image.asset("assets/images/play.png"),
                    status == "Active" ? "Pause" : "Active",
                    onToggleStatus,
                    color: AppColors.primaryColor,
                  ),
                  actionButton(
                    Image.asset("assets/images/delete.png"),
                    "Delete",
                    onDelete,
                    color: Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 6),
                  commonText(location, size: 14),
                ],
              ),
            ],
          ),
        ),

        /// Benefit Badge
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: commonText(
              benefitText,
              color: Colors.white,
              size: 12,
              isBold: true,
            ),
          ),
        ),
      ],
    );
  }

  void showPauseReasonDialog(BuildContext context, Function(String) onSubmit) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Title
                commonText(
                  "Why do you want to pause this deal?",
                  size: 16,
                  textAlign: TextAlign.center,
                  isBold: true,
                ),

                const SizedBox(height: 16),

                /// Reason input field (no title)
                Row(
                  children: [
                    Expanded(
                      child: commonTextField(
                        controller: reasonController,
                        hintText: "Enter your reason...",
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Submit button
                commonButton(
                  "Submit",
                  onTap: () {
                    final reason = reasonController.text.trim();
                    if (reason.isNotEmpty) {
                      Navigator.of(context).pop(); // close dialog
                      onSubmit(reason); // pass back reason
                    } else {
                      // optional: show error toast/snackbar
                    }
                  },
                  height: 48,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget actionButton(
    Widget icon,
    String label,
    VoidCallback onTap, {
    Color color = Colors.black87,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Icon(icon, size: 20, color: color),
          icon,
          const SizedBox(height: 4),
          commonText(label, size: 12, color: color),
        ],
      ),
    );
  }

}
