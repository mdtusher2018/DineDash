import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/deals/user/model_and_response/user_all_available_deals_response.dart';
import 'package:dine_dash/features/deals/user/model_and_response/deal_model.dart';
import 'package:get/get.dart';

class UserAvailableDealsController extends BaseController {
  final ApiService _apiService = Get.find();

  final availableDeals = <UserDealItem>[].obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  int currentPage = 1;
  int totalPages = 1;

  Future<void> fetchDealsList({bool loadMore = false}) async {
    if (isLoadingMore.value) return;

    if (!loadMore) {
      // reset list
      currentPage = 1;
      availableDeals.clear();
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
          ApiEndpoints.userAvailableDeals(page: currentPage),
        );

        final userAllDealsResponse = UserAllDealsResponse.fromJson(response);

        if (userAllDealsResponse.statusCode == 201) {
          final newDeals = userAllDealsResponse.results;

          totalPages = userAllDealsResponse.pagination.totalPages;
          currentPage = userAllDealsResponse.pagination.currentPage;

          if (loadMore) {
            availableDeals.addAll(newDeals);
          } else {
            availableDeals.assignAll(newDeals);
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

  Future<void> loadMoreAvailableDeals() async {
    if (hasMore.value && !isLoadingMore.value) {
      currentPage++;
      await fetchDealsList(loadMore: true);
    }
  }

}
