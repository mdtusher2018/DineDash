
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/business_details_response.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';

class BusinessDetailController extends BaseController {
  final Rx<BusinessAttributes?> businessDetail = Rx<BusinessAttributes?>(null);
  final ApiService _apiService = Get.find();

  Future<void> fetchBusinessDetail(String businessId) async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.businessDetails(businessId),
        );
        final businessResponse = BusinessDetailResponse.fromJson(response);

        if (businessResponse.statusCode == 200) {
          final parsed = BusinessDetailResponse.fromJson(response);
          businessDetail.value = parsed.data.attributes;
        } else {
          throw Exception(businessResponse.message);
        }
      },
    );
  }
}
