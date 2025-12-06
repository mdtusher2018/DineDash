import 'package:dine_dash/features/home/dealer/dealer_homepage_all_business_response.dart';
import 'package:dine_dash/core/models/dealer_business_model.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerHomepageController extends BaseController {
  final ApiService _apiService = Get.find();

  // Observable list of businesses
  var businesses = <DealerBusinessModel>[].obs;
  var businessSummary = Rxn<BusinessSummary>();
  // Pagination
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var loadingMore = false.obs;

  final performance = RxnNum();

  /// Fetch business list
  Future<void> fetchDealerHomepageData({int page = 1}) async {
    safeCall(
      showLoading: true,
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.dealerHomepageAllBusiness(page),
        );

        final businessResponse = DealerHomepageAllBusinessResponse.fromJson(
          response,
        );

        if (businessResponse.statusCode == 200) {
          if (page == 1) {
            businesses.value = [];
            businessSummary.value = businessResponse.summary;
            businesses.value = businessResponse.results;
            performance.value = businessResponse.performance;
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
}
