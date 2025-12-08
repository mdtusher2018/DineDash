import 'dart:developer';
import 'dart:io';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerEditBusinessController extends BaseController {
  final ApiService _apiService = Get.find();

  Future<void> editBusiness({
    required String businessId,
    required String name,
    required List<String> types,
    required String? businessType,
    required String address,
    required String phoneNumber,
    required String postalCode,
    required List<Map<String, dynamic>> openingHours,
    required List<double?> coordinates,
    File? imageFile,
  }) async {
    log(coordinates.toString());
    safeCall(
      task: () async {
        if (name.trim().isEmpty) {
          throw Exception("Business name is required");
        }

        if (types.isEmpty) {
          throw Exception("Please select at least one category/type");
        }

        if (businessType == null || businessType.trim().isEmpty) {
          throw Exception("Please select a business type");
        }

        if (address.trim().isEmpty) {
          throw Exception("Address is required");
        }

        if (phoneNumber.trim().isEmpty) {
          throw Exception("Phone number is required");
        }

        if (postalCode.trim().isEmpty) {
          throw Exception("Postal code is required");
        }

        if (openingHours.isEmpty) {
          throw Exception("Please provide opening hours");
        }

        final formData = {
          "name": name,
          "types": types,
          "businessType": businessType.toLowerCase(),
          "formatted_address": address,
          "formatted_phone_number": phoneNumber,
          "postalCode": postalCode,
          "openingHours": openingHours,
          if (coordinates.isNotEmpty)
            "location": {"type": "Point", "coordinates": coordinates},
        };

        // Send the POST request
        final response = await _apiService.multipart(
          ApiEndpoints.editBusiness(businessId),
          body: formData,
          method: 'PUT',
          files: {if (imageFile != null) 'image': imageFile},
        );

        if (response['statusCode'] == 200 || response['status'] == true) {
          Get.close(1);

          showSnackBar("Business updated successfully");
        } else {
          throw Exception(response['message'] ?? "Something went wrong");
        }
      },
    );
  }
}
