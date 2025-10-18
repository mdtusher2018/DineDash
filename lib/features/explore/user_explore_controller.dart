
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/explore/user_explore_list_response.dart';
import 'package:dine_dash/features/explore/user_explore_map_response.dart';
import 'package:dine_dash/model/business_model.dart';
import 'package:get/get.dart';

class UserExploreController extends BaseController {
  final ApiService _apiService = Get.find();

  final businessesOnMap = <BusinessOnMap>[].obs;

  var businessList = <BusinessModel>[].obs;

  SessionMemory sessionMemory = Get.find();

  int currentPage = 1;
  int totalPages = 1;
  bool isLoadingMore = false;

  Future<void> fetchBusinessesOnMap({
    double? latitude,
    double? longitude,
  }) async {
    await safeCall(
      task: () async {
        double? lat = latitude;
        double? lng = longitude;

        final sessionLocation = sessionMemory.userLocation;

        if (lat == null || lng == null) {
          lat = sessionLocation.$1;
          lng = sessionLocation.$2;
        }

        if (lat == null || lng == null) {
          final position = await getCurrentPosition(controller: this);
          lat = position.latitude;
          lng = position.longitude;
        }

        final response = await _apiService.get(
          ApiEndpoints.nearbyBusinesses(lat: lat, lng: lng),
        );


        final parsed = UserExploreMapResponse.fromJson(response);

        if (parsed.statusCode == 200) {
          businessesOnMap.assignAll(parsed.businesses);
        } else {
          businessesOnMap.clear();
          throw Exception(parsed.message);
        }
      },
    );
  }

  Future<void> fetchBusinessesList({
    String? city,
    String? searchTerm,
    String? sortBy,
    bool loadMore = false,
  }) async {
    if (isLoadingMore) return;

    if (!loadMore) {
      currentPage = 1;
      totalPages = 1;
      businessList.clear();
    }
    if (loadMore && currentPage >= totalPages) {
      return;
    }
    isLoadingMore = loadMore;

    await safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.businessNearestList(
            city: city,
            searchTerm: searchTerm,
            sortBy: sortBy,
            page: currentPage,
          ),
        );

        final userExploreBusinessListResponse =
            UserExploreBusinessListResponse.fromJson(response);

        if (userExploreBusinessListResponse.statusCode == 200) {
          businessList.assignAll(userExploreBusinessListResponse.businesses);

          totalPages = userExploreBusinessListResponse.pagination.totalPages;
          currentPage = userExploreBusinessListResponse.pagination.currentPage;

          if (loadMore) {
            businessList.addAll(userExploreBusinessListResponse.businesses);
          } else {
            businessList.assignAll(userExploreBusinessListResponse.businesses);
          }

          businessList.refresh();
        } else {
          throw Exception(userExploreBusinessListResponse.message);
        }
      },
    );
  }

  /// Call this to load next page
  Future<void> loadMoreBusinesses() async {
    if (currentPage < totalPages && !isLoadingMore) {
      currentPage++;
      await fetchBusinessesList(loadMore: true);
    }
  }
}
