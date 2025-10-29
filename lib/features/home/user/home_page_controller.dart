import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/home/user/home_page_response.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final ApiService _apiService = Get.find();


  // Observables for UI
  var homeData = Rxn<HomeData>();

  Future<void> fetchHomeData({String? city, String? searchTerm}) async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.userHomePage(city: city, searchTerm: searchTerm),
        );
        final homeResponse = HomeResponse.fromJson(response);

        if (homeResponse.statusCode == 200 && homeResponse.data != null) {
          homeData.value = homeResponse.data;
          homeData.refresh();
        } else {
          throw Exception(homeResponse.message);
        }
      },
    );
  }
}
