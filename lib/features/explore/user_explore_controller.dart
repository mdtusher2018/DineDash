// ignore_for_file: prefer_final_fields

import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/fallback_value.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/explore/user_explore_list_response.dart';
import 'package:dine_dash/features/explore/user_explore_map_response.dart';
import 'package:dine_dash/core/models/business_model.dart' hide Location;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserExploreController extends BaseController {
  final ApiService _apiService = Get.find();

  final businessesOnMap = <BusinessOnMap>[].obs;

  var businessList = <BusinessModel>[].obs;

  SessionMemory sessionMemory = Get.find();

  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);

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

  Future<void> getCoordinatesFromPostalCode() async {
    try {
      // Attempt to get coordinates from postal code
      String postalCode =
          await Get.find<LocalStorageService>().getString(
            StorageKey.postalCode,
          ) ??
          FallbackValue.postalCode;

      List<Location> locations = await locationFromAddress(postalCode);

      if (locations.isNotEmpty) {
        // If postal code is found, use the first result
        final Location location = locations.first;
        currentPosition.value = LatLng(
          location.latitude,
          location.longitude,
        ); // Update position with postal code coordinates
      } else {
        // Fallback to current location if postal code lookup fails
        getCurrentLocation();
      }
    } catch (e) {
      print("Error occurred while getting coordinates from postal code: $e");
      // If an error occurs in postal code lookup, fallback to current location
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position currentLocation = await Geolocator.getCurrentPosition();

      currentPosition.value = LatLng(
        currentLocation.latitude,
        currentLocation.longitude,
      );
    } catch (e) {
      print("Error occurred while getting current location: $e");
      currentPosition.value = LatLng(
        FallbackValue.latitude,
        FallbackValue.longitude,
      );
    }
  }
}
