import 'package:dine_dash/core/controller/my_business_name_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:get/get.dart';

class DealerDeleteDealController extends DealerMyBusinessNameListController {
  final ApiService _apiService = Get.find();

  Future<void> deleteDeal({
    required String reason,
    required String dealId,
    required Function() deleteManually,
  }) async {
    safeCall(
      showLoading: false,
      task: () async {
        final response = await _apiService.put(
          ApiEndpoints.deleteDeal(dealId),
          {"reason": reason},
        );
        if (response['statusCode'] == 200) {
          deleteManually();
          showSnackBar(response['message'] ?? "Deal deleted successfully");
        } else {
          throw Exception(response['message'] ?? "Failed to delete deal");
        }
      },
    );
  }
}
