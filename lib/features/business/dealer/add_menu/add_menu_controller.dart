import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerMenuController extends BaseController {
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
          Get.back();
          showSnackBar("Menu added successfully", isError: false);
        } else {
          throw Exception(response['message'] ?? "Something went wrong");
        }
      },
    );
  }

  Future<void> editMenu({
    required String menuId,
    required String itemName,
    required String itemDescription,
    required String price,
  }) async {
    await safeCall(
      task: () async {
        if (itemName.trim().isEmpty) {
          throw Exception("Menu name is required");
        }
        if (itemDescription.trim().isEmpty) {
          throw Exception("Menu description is required");
        }
        if (price.trim().isEmpty) {
          throw Exception("Menu price is required");
        }

        final parsedPrice = double.tryParse(price);
        if (parsedPrice == null || parsedPrice <= 0) {
          throw Exception("Invalid price value");
        }

        final payload = {
          "itemName": itemName,
          "description": itemDescription,
          "price": parsedPrice,
        };

        // Send POST request
        final response = await _apiService.put(
          ApiEndpoints.editMenu(menuId),
          payload,
        );

        if (response['statusCode'] == 201 || response['status'] == true) {
          Get.back();
          showSnackBar("Menu Updated successfully", isError: false);
        } else {
          throw Exception(response['message'] ?? "Something went wrong");
        }
      },
    );
  }
}
