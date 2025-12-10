import 'dart:developer';

import 'package:dine_dash/core/controller/my_business_name_controller.dart';
import 'package:dine_dash/core/models/dealer_deal_details.dart';
import 'package:dine_dash/core/models/my_business_name_response.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealerCreateDealController extends DealerMyBusinessNameListController {
  final ApiService _apiService = Get.find();
  var isSubmitting = false.obs;

  var dealDetails = Rx<DealerDealDetailsData?>(null);

  Future<void> createDeal({
    required BuildContext context,
    required DealerBusinessItem? business,
    required String description,
    required double benefitAmount,
    required String dealType,
    required int reusableAfter,
    required int maxClaimCount,
    required List<Map<String, dynamic>> activeTime,
  }) async {
    log(reusableAfter.toString());
    await safeCall(
      task: () async {
        if (business == null) {
          throw Exception("Business is required");
        }

        if (description.isEmpty) {
          throw Exception("Description cannot be empty");
        }
        if (dealType.isEmpty) {
          throw Exception("Deal type cannot be empty");
        }
        if (benefitAmount <= 0) {
          throw Exception("Benefit amount must be greater than zero");
        }
        if (maxClaimCount <= 0) {
          throw Exception("Maximum claim count must be greater than zero");
        }
        if (activeTime.isEmpty) {
          throw Exception("Please add at least one active time slot");
        }
        if (reusableAfter != 60 && reusableAfter != 90) {
          throw Exception("Please select a resuableAfter");
        }

        final payload = {
          "business": business.id,
          "description": description,
          "benefitAmmount": benefitAmount,
          "dealType": dealType,
          "reuseableAfter": reusableAfter,
          "maxClaimCount": maxClaimCount,
          "activeTime": activeTime,
        };

        isSubmitting.value = true;

        final response = await _apiService.post(
          ApiEndpoints.createDeal,
          payload,
        );

        if (response['statusCode'] == 201) {
     Navigator.of(context).pop(); // Close dialog first
          showSnackBar(response['message'] ?? "Deal created successfully");
        } else {
          throw Exception(response['message'] ?? "Failed to create deal");
        }
      },
    );

    isSubmitting.value = false;
  }
}
