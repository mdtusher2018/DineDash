import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/deals/user/user_deals_details_and_redeem/user_deal_redeem.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:get/get.dart';

class UserFeedbackController extends BaseController {
  final ApiService _apiservice = Get.find();

  Future<void> addFeedback({
    required String businessId,
    required String dealId,
    required String feedbackText,
    required num ratting,
    required String rasturentName
  }) async {
    safeCall(
      task: () async {
        final response = await _apiservice.post(
          ApiEndpoints.userAddFeedback(businessId),
          {
            "text": feedbackText,
            "deal": dealId,
            "type": "business",
            "rating": ratting,
          },
        );
        if (response['statusCode'] == 200) {
          navigateToPage(
            UserDealRedeemPage(businessId: businessId, dealId: dealId,rasturentName: rasturentName,),
          );
        } else {
          throw Exception(response['message'] ?? "Could not add feedback");
        }
      },
    );
  }
}
