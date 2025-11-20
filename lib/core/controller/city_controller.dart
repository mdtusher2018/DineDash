import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/models/city_model.dart';
import 'package:get/get.dart';

class CityController extends BaseController {
  final ApiService _apiService = Get.find();

  final RxList<CityModel> cities = <CityModel>[].obs;
  final RxString selectedCity = ''.obs;

  Future<void> fetchCities() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.cities);

        final cityResponse = CityResponse.fromJson(response);

        if (cityResponse.statusCode == 201 && cityResponse.data != null) {
          cities.assignAll(cityResponse.data!.results);
        } else {
          showSnackBar('Failed to load cities');
        }
      },
    );
  }

  List<CityModel> filterCities(String query) {
    if (query.isEmpty) return cities;
    return cities
        .where(
          (city) =>
              city.cityName.toLowerCase().contains(query.toLowerCase()) ||
              city.postalCode.contains(query),
        )
        .toList();
  }
}
