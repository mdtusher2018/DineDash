import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/business_details_response.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/menu_response.dart';
import 'package:dine_dash/core/models/business_model.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';

class BusinessDetailController extends BaseController {
  final Rx<BusinessModel?> businessDetail = Rx<BusinessModel?>(null);

  Rxn<List<MenuItem>> menuData = Rxn<List<MenuItem>>();

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

  Future<void> fetchMenu({required String businessId}) async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.menu(businessId));
        final menuResponse = MenuResponse.fromJson(response);

        if (menuResponse.statusCode == 201 &&
            menuResponse.data.menu.isNotEmpty) {
          menuData.value = menuResponse.data.menu;
        } else {
          menuData.value = [];
        }
      },
    );
  }

  Future<bool> likeBusiness(String businessId) async {
    return await safeCall(
          showLoading: false,
          task: () async {
            final response = await _apiService.post(ApiEndpoints.addFavorite, {
              "business": businessId,
            });
            return response['statusCode'] == 201;
          },
        ) ??
        false;
  }

  Future<bool> unlikeBusiness(String favoriteId) async {
    return await safeCall(
          showLoading: false,
          task: () async {
            final response = await _apiService.get(
              ApiEndpoints.removeFavorite(favoriteId),
            );

            // Success if statusCode 200
            return response['statusCode'] == 200;
          },
        ) ??
        false;
  }

  Future<bool?> goToDeal({
    required String businessId,
    required String dealId,
    required String savings,
    required DateTime? startTime,
    required DateTime? endTime,
    required int index,
  }) async {
    return await safeCall<bool>(
      task: () async {
        if (startTime == null || endTime == null) {
          throw Exception("please select time");
        }
        startTime = startTime!.add(Duration(days: index));
        endTime = endTime!.add(Duration(days: index));
        final response = await _apiService.post(ApiEndpoints.bookDeal(dealId), {
          "business": businessId,
          "savings": savings,
          "bookinfor": startTime.toString(),
          "bookinEnd": endTime.toString(),
        });
        return response['statusCode'] == 200;
      },
    );
  }
}
