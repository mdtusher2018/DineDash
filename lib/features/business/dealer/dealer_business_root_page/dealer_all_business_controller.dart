import 'package:dine_dash/features/business/dealer/dealer_business_root_page/dealer_all_business_response.dart';
import 'package:dine_dash/model/dealer_business_model.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
class DealerAllBusinessController extends BaseController {
  final ApiService _apiService = Get.find();

  var businesses = <DealerBusinessModel>[].obs;

  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isLoadingMore = false.obs;

  /// Fetch business list (initial + pagination)
  Future<void> fetchAllBusinessData({int page = 1, bool isLoadMore = false}) async {
    if (isLoadMore && isLoadingMore.value) return;

    if (isLoadMore) isLoadingMore.value = true;
  

    await safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.dealerAllBusiness(page),
        );

        final businessResponse = DealerAllBusinessResponse.fromJson(response);

        if (businessResponse.statusCode == 200) {
          if (page == 1) {
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

    if (isLoadMore) isLoadingMore.value = false;
    
  }

  /// Check if we can load next page
  bool get canLoadMore => currentPage.value < totalPages.value;
}