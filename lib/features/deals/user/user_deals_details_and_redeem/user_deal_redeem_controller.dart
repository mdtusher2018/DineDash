import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/deals/user/user_deals_details_and_redeem/user_deal_redeem.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:get/get.dart';

class UserDealRedeemController extends BaseController {
  final ApiService _apiservice = Get.find();

  Future<void> dealRedeem(String dealId) async {
    safeCall(
      task: () async {
        final response = await _apiservice.put(
          ApiEndpoints.userRedeemDeal(dealId),
          {},
        );
        if (response['statusCode'] == 200) {
          navigateToPage(UserDealRedeemPage());
        } else {
          throw Exception(response['message'] ?? "Could not redeem");
        }
      },
    );
  }
}
