import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerEditMenuController extends BaseController {
  final ApiService _apiService = Get.find();

  Future<void> editMenu({
    required BuildContext context,
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
          Navigator.of(context).pop(); // Close dialog first
          showSnackBar("Menu Updated successfully", isError: false);
        } else {
          throw Exception(response['message'] ?? "Something went wrong");
        }
      },
    );
  }
}
