import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/deals/user/model_and_response/deal_details_response.dart';
import 'package:dine_dash/features/deals/user/user_deals_details_and_redeem/user_deal_redeem.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDealRedeemController extends BaseController {
  final ApiService _apiservice = Get.find();

  Future<void> dealRedeem(
    String uvmId, {
    required BuildContext context,
    required String businessId,
    required String dealId,
    required String rasturentName,
  }) async {
    safeCall(
      task: () async {
        final response = await _apiservice.put(
          ApiEndpoints.userRedeemDeal(uvmId),
          {},
        );
        if (response['statusCode'] == 200) {
          navigateToPage(
            UserDealRedeemPage(
              dealId: dealId,
              businessId: businessId,
              rasturentName: rasturentName,
            ),
            context: context,
          );
        } else {
          throw Exception(response['message'] ?? "Could not redeem");
        }
      },
    );
  }

  Future<UserDealDetailsResponse?> fetchDeal(String dealId) async {
    return await safeCall<UserDealDetailsResponse>(
      task: () async {
        final response = await _apiservice.get(
          ApiEndpoints.dealDetailsById(dealId),
        );
        final model = UserDealDetailsResponse.fromJson(response);
        if (model.status) {
          return model;
        } else {
          throw Exception(response['message'] ?? "Could not redeem");
        }
      },
    );
  }
}
