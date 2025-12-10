// ignore_for_file: must_be_immutable

import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/ratting_and_feedback/user/user_feedback_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class UserGivingStarsPage extends StatelessWidget {
  UserGivingStarsPage({
    super.key,
    required this.dealId,
    required this.businessId,
    required this.rasturentName,
  });
  final String dealId, businessId, rasturentName;

  final controller = Get.find<UserFeedbackController>();
  RxDouble ratting = 3.0.obs;

  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              commonText(
                "How was your experience at?".trParams({
                  'restaurantName': rasturentName,
                }),
                size: 22,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonText(
                      "Rating:".tr,
                      size: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    RatingBar.builder(
                      initialRating: ratting.value,
                      itemSize: 25,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder:
                          (context, _) => Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        ratting.value = rating;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(child: Divider(height: 1, color: Colors.grey)),
              SizedBox(height: 20),
              commonText("Comment:".tr, size: 18, fontWeight: FontWeight.w600),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 3,
                controller: commentController,
                decoration: InputDecoration(
                  hintText: "Let others know about your experience..".tr,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 25),

              SizedBox(height: 170),
              commonButton(
                "Continue".tr,
                onTap: () {
                  controller.addFeedback(
                    businessId: businessId,
                    dealId: dealId,
                    feedbackText: commentController.text.trim(),
                    ratting: ratting.value,
                    rasturentName: rasturentName,
                    context: context,
                  );
                },
              ),
              SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog first
                  },
                  child: commonText(
                    "Remind me later".tr,
                    size: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
