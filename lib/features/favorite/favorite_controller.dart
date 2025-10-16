import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/favorite/favorite_response.dart';
import 'package:dine_dash/model/business_model.dart';
import 'package:get/get.dart';

class FavoriteController extends BaseController {
  final ApiService _apiService = Get.find();

  /// All favorites from API
  var favoriteData = Rxn<FavoriteData>();

  /// Filtered list (shown in UI)
  var filteredFavorites = <BusinessModel>[].obs;

  /// Search text
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ever(searchQuery, (_) => applyFilter());
  }

  /// Fetch favorites from API
  Future<void> fetchFavoriteList() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.favoriteList());
        final favoriteResponse = FavoriteResponse.fromJson(response);

        if (favoriteResponse.statusCode == 200 &&
            favoriteResponse.data.attributes.isNotEmpty) {
          favoriteData.value = favoriteResponse.data;

          /// Initialize filtered list
          filteredFavorites.assignAll(favoriteResponse.data.attributes);
        } else {
          favoriteData.value = null;
          filteredFavorites.clear();
          throw Exception(favoriteResponse.message);
        }
      },
    );
  }

  /// Apply search filter
  void applyFilter() {
    final query = searchQuery.value.trim().toLowerCase();

    if (query.isEmpty) {
      filteredFavorites.assignAll(favoriteData.value?.attributes ?? []);
    } else {
      final all = favoriteData.value?.attributes ?? [];
      final filtered = all
          .where((biz) => biz.name.toLowerCase().contains(query))
          .toList();
      filteredFavorites.assignAll(filtered);
    }
  }
}
