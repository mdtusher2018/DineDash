
import 'package:dine_dash/features/deals/dealer/dealer_all_deals/dealer_all_deals_response.dart';
import 'package:dine_dash/features/deals/dealer/delete_deal/delete_deal_controller.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';


class DealerAllDealsController extends DealerDeleteDealController {
  final ApiService _apiService = Get.find<ApiService>();

  /// Observables
  var isLoading = false.obs;
  var deals = <DealAttribute>[].obs;

  /// Fetch all deals
  Future<void> fetchAllDeals() async {
    isLoading.value = true;

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

    isLoading.value = false;
  }
}
