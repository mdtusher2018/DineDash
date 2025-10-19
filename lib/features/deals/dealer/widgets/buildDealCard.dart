


  import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Widget buildDealCard({
    required String title,
    required String subText,
    required String duration,
    required String location,
        required String redeemed,
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
                  Flexible(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: commonText("Reusable After".tr, size: 12,maxline: 1)),
                                commonText("$duration Days", size: 12, isBold: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  Flexible(
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
                            "assets/images/user.png",
                            height: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonText("REDEENED".tr, size: 12),
                              commonText(redeemed, size: 12, isBold: true),
                            ],
                          ),
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
                  actionButton(Image.asset("assets/images/editb.png",width: 22,), "Edit".tr, onEdit),
                  actionButton(
                    status == "Active"
                        ? Image.asset("assets/images/pause.png",width: 20,)
                        : Image.asset("assets/images/play.png",width: 20,),
                    status == "Active" ? "Pause".tr : "Active".tr,
                    onToggleStatus,
                    color: AppColors.primaryColor,
                  ),
                  actionButton(
                    Image.asset("assets/images/delete.png",width: 18,),
                    "Delete".tr,
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
              "$benefitText € Benefit",
              color: Colors.white,
              size: 12,
              isBold: true,
            ),
          ),
        ),
      ],
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
                  "Why do you want to pause this deal?".tr,
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
                        hintText: "Enter your reason...".tr,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Submit button
                commonButton(
                  "Submit".tr,
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

