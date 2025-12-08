import 'package:dine_dash/res/commonWidgets.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerAddMenuController extends BaseController {
  final ApiService _apiService = Get.find();

  /// Create menu items for a business
  Future<void> addMenuItems({
    required String businessId,
    required List<Map<String, dynamic>> items,
  }) async {
    await safeCall(
      task: () async {
        if (businessId.isEmpty) {
          throw Exception("Business ID is missing");
        }

        if (items.isEmpty) {
          throw Exception("Please add at least one menu item");
        }

        // Validate each item
        for (var item in items) {
          if ((item["itemName"] ?? "").toString().trim().isEmpty) {
            throw Exception("Item name is required");
          }
          if ((item["description"] ?? "").toString().trim().isEmpty) {
            throw Exception("Item description is required");
          }
          if (item["price"] == null ||
              double.tryParse(item["price"].toString()) == null) {
            throw Exception("Invalid price for ${item["itemName"] ?? "item"}");
          }
        }

        // Prepare payload
        final payload =
            items.map((item) {
              return {
                "business": businessId,
                "itemName": item["itemName"],
                "description": item["description"],
                "price": double.parse(item["price"].toString()),
              };
            }).toList();

        // Send POST request
        final response = await _apiService.post(ApiEndpoints.addMenu, payload);

        if (response['statusCode'] == 201 || response['status'] == true) {
          Get.close(1);
          showSnackBar("Menu added successfully", isError: false);
        } else {
          throw Exception(response['message'] ?? "Something went wrong");
        }
      },
    );
  }
}
