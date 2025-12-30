import 'package:dine_dash/core/controller/my_business_name_controller.dart';
import 'package:dine_dash/core/models/dealer_deal_details.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:get/get.dart';

class DealerDealPauseController extends DealerMyBusinessNameListController {
  final ApiService _apiService = Get.find();
  var isSubmitting = false.obs;

  var dealDetails = Rx<DealerDealDetailsData?>(null);

  Future<bool?> pauseToggleDeal({
    required String dealId,
    required bool ispaused,
    required String reason,
  }) async {
    return await safeCall<bool>(
      task: () async {
        final response = await _apiService.patch(
          ApiEndpoints.pauseDeal(dealId),

          {"reason": reason, 'reasonFor': ispaused ? "paused" : "unpaused"},
        );
        if (response["statusCode"] != 200) {
          throw Exception(response['message'] ?? "Unknown Error Occoured");
        } else {
          return true;
        }
      },
      showSuccessSnack: true,
      successMessage:
          "deal ${ispaused ? "unpaused" : "paused"} request sent sucessfully",
    );
  }
}
