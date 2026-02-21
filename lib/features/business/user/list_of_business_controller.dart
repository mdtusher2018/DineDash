import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/models/business_model.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/business/user/list_of_business_model.dart';
import 'package:get/get.dart';

class ListOfBusinessController extends BaseController {
  final ApiService _apiService = Get.find();

  // Observables for UI
  RxList<BusinessModel> listOfBusiness = RxList<BusinessModel>();

  static RxInt unread = 0.obs;

  Future<void> fetchListOfBusinessData({
    String? city,
    String? searchTerm,
    bool isBusiness = true,
  }) async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(
          isBusiness
              ? ApiEndpoints.userAllBusinessList(
                city: city,
                searchTerm: searchTerm,
              )
              : ApiEndpoints.userAllActivityList(
                city: city,
                searchTerm: searchTerm,
              ),
        );
        final responseModel = ListOfBusinessResponse.fromJson(response);

        if (responseModel.statusCode == 200) {
          listOfBusiness.value =
              isBusiness
                  ? responseModel.data.attributes.restaurants
                  : responseModel.data.attributes.activity;
          listOfBusiness.refresh();
        } else {
          throw Exception(responseModel.message);
        }
      },
    );
  }
}
