import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/features/business/dealer/dealer_business_details/dealer_business_details_response.dart';
import 'package:dine_dash/features/deals/dealer/dealer_deal_controller.dart';
import 'package:dine_dash/features/deals/dealer/delete_deal/delete_deal_controller.dart';
import 'package:get/get.dart';

import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerBusinessDetailController extends BaseController {
  final ApiService _apiService = Get.find();

  /// The current business details
  var businessDetail = Rxn<DealerBusinessAttributes>();

  final _deleteDealController = Get.find<DealerDeleteDealController>();
  final _pauseDealController = Get.find<DealerDealPauseController>();

  Future<void> fetchBusinessDetail(String businessId) async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.dealerBusinessDetail(businessId),
        );

        final businessResponse = DealerBusinessDetailResponse.fromJson(
          response,
        );

        if (businessResponse.statusCode == 200 &&
            businessResponse.data?.attributes != null) {
          businessDetail.value = businessResponse.data!.attributes;
        } else {
          throw Exception(businessResponse.message);
        }
      },
    );
  }

  /// Delegate delete deal action to DeleteDealController
  Future<void> deleteDeal({
    required String reason,
    required String dealId,
    required Function() deleteManually,
  }) async {
    await _deleteDealController.deleteDeal(
      dealId: dealId,
      deleteManually: deleteManually,
      reason: reason,
    );
  }

  /// Delegate pause deal action to PauseDealController
  Future<bool?> pauseDeal({required String dealId}) async {
    return await _pauseDealController.pauseToggleDeal(dealId: dealId);
  }
}
