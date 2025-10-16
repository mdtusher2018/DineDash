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

  Future<void> fetchBusinessesList() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.businessNearestList);
        final favoriteResponse = UserExploreBusinessListResponse.fromJson(
          response,
        );

        if (favoriteResponse.statusCode == 200) {
          businessList.assignAll(favoriteResponse.businesses);
        } else {
          throw Exception(favoriteResponse.message);
        }
      },
    );
  }
}
