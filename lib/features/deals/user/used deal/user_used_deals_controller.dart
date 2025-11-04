import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/deals/user/model_and_response/user_all_available_deals_response.dart';
import 'package:dine_dash/features/deals/user/model_and_response/deal_model.dart';
import 'package:get/get.dart';

class UserAllUseddDealsController extends BaseController {
  final ApiService _apiService = Get.find();

  final usedDeals = <UserDealItem>[].obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  int currentPage = 1;
  int totalPages = 1;

  /// Fetch all used deals (used on init and pagination)
  Future<void> fetchUsedDealsList({bool loadMore = false}) async {
    if (isLoadingMore.value) return;

    if (!loadMore) {
      // reset list
      currentPage = 1;
      usedDeals.clear();
      hasMore.value = true;
    } else {
      if (currentPage > totalPages) {
        hasMore.value = false;
        return;
      }
    }

    isLoadingMore.value = true;

    await safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.userUsedDeals(page: currentPage),
        );

        final userAllDealsResponse = UserAllDealsResponse.fromJson(response);

        if (userAllDealsResponse.statusCode == 201) {
          final newDeals = userAllDealsResponse.results;

          totalPages = userAllDealsResponse.pagination.totalPages;
          currentPage = userAllDealsResponse.pagination.currentPage;

          if (loadMore) {
            usedDeals.addAll(newDeals);
          } else {
            usedDeals.assignAll(newDeals);
          }

          // Check if more pages are available
          hasMore.value = currentPage < totalPages;
          isLoadingMore.value = false;
        } else {
          isLoadingMore.value = false;
          throw Exception(userAllDealsResponse.message);
        }
      },
      showLoading: !(currentPage > 1),
    );
  }

  /// Load the next page of used deals
  Future<void> loadMoreUsedDeals() async {
    if (hasMore.value && !isLoadingMore.value) {
      currentPage++;
      await fetchUsedDealsList(loadMore: true);
    }
  }

}
