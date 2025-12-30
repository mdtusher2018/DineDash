import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/features/deals/dealer/dealer_all_deals/dealer_all_deals_response.dart';
import 'package:dine_dash/features/deals/dealer/dealer_deal_controller.dart';
import 'package:dine_dash/features/deals/dealer/delete_deal/delete_deal_controller.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerAllDealsController extends BaseController {
  final ApiService _apiService = Get.find<ApiService>();

  var deals = <DealAttribute>[].obs;

  final DealerDeleteDealController _deleteDealController =
      Get.find<DealerDeleteDealController>();
  final DealerDealPauseController _pauseDealController =
      Get.find<DealerDealPauseController>();

  /// Fetch all deals
  Future<void> fetchAllDeals() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.getAllDeals);

        if (response['status'] == true &&
            response['data'] != null &&
            response['data']['attributes'] != null) {
          final dealResponse = CreateDealResponse.fromJson(response);
          deals.assignAll(dealResponse.data?.attributes ?? []);
        } else {
          throw Exception(response['message'] ?? 'Failed to fetch deals');
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
  Future<bool?> pauseDeal({
    required String dealId,
    required bool ispaused,
    required String reason,
  }) async {
    return await _pauseDealController.pauseToggleDeal(
      dealId: dealId,
      ispaused: ispaused,
      reason: reason,
    );
  }
}
