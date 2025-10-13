import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/home/user/home_page_response.dart';
import 'package:get/get.dart';


class HomeController extends BaseController {
  final ApiService _apiService = Get.find();
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchHomeData();
  }


  // Observables for UI
  var homeData = Rxn<HomeData>();

  Future<void> fetchHomeData() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.userHomePage);
        final homeResponse = HomeResponse.fromJson(response);

        if (homeResponse.statusCode == 200 && homeResponse.data != null) {
          homeData.value = homeResponse.data;
        } else {
          throw Exception(homeResponse.message);
        }
      },

    );
  }
}
