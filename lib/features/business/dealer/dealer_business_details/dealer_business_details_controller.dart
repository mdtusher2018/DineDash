import 'package:dine_dash/features/business/dealer/dealer_business_details/dealer_business_details_response.dart';
import 'package:dine_dash/features/deals/dealer/delete_deal/delete_deal_controller.dart';
import 'package:get/get.dart';

import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerBusinessDetailController extends DealerDeleteDealController {
  final ApiService _apiService = Get.find();

  /// The current business details
  var businessDetail = Rxn<DealerBusinessAttributes>();

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
}
