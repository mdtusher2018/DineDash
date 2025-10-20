import 'package:dine_dash/core/models/my_business_name_response.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerMyBusinessNameListController extends BaseController {
  final ApiService _apiService = Get.find<ApiService>();

  var businessesName = <DealerBusinessItem>[].obs;

  Future<void> fetchAllBusinessesName() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.dealerMyBusinessNameList,
        );

        final businessResponse = DealerMyBusinessNameResponse.fromJson(
          response,
        );

        if (businessResponse.statusCode == 200 &&
            businessResponse.businessNameList != null) {
          businessesName.value = businessResponse.businessNameList!;
        } else {
          throw Exception(
            businessResponse.message ?? "Failed to fetch businesses",
          );
        }
      },
    );
  }

  Future<void> reload() async {
    await fetchAllBusinessesName();
  }
}
