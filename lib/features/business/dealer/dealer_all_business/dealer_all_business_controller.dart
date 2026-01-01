import 'package:dine_dash/features/business/dealer/dealer_all_business/dealer_all_business_response.dart';
import 'package:dine_dash/core/models/dealer_business_model.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerAllBusinessController extends BaseController {
  final ApiService _apiService = Get.find();

  var businesses = <DealerBusinessModel>[].obs;

  var currentPage = 1.obs;
  var totalPages = 1.obs;

  void fetchmore() {
    if (currentPage.value < totalPages.value) {
      fetchAllBusinessData(page: (currentPage.value + 1));
    }
  }

  Future<void> fetchAllBusinessData({required int page}) async {
    if (isLoading.value) return;
    await safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.dealerAllBusiness(page),
        );

        final businessResponse = DealerAllBusinessResponse.fromJson(response);

        if (businessResponse.statusCode == 200) {
          if (page == 1) {
            businesses.value = [];
            businesses.value = businessResponse.results;
          } else {
            businesses.addAll(businessResponse.results);
          }
          currentPage.value = businessResponse.pagination.currentPage;
          totalPages.value = businessResponse.pagination.totalPages;
        } else {
          errorMessage.value = businessResponse.message;
        }
      },
    );
  }

  Future<bool> deleteBusiness(String businessId) async {
    safeCall(
      task: () async {
        final response = await _apiService.put(
          ApiEndpoints.deleteBusiness(businessId),
          {},
        );
        if (response['statusCode'] == 200) {
          businesses.removeWhere((element) => element.id == businessId);

          showSnackBar(response['message'] ?? "Sucessfully deleted");
          return true;
        } else {
          throw Exception(response['message'] ?? "Failed to delete");
        }
      },
    );
    return false;
  }
}
