import 'dart:developer';
import 'dart:io';

import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/extentions.dart';
import 'package:dine_dash/features/auth/dealer/create_dealer_2nd_page.dart';
import 'package:dine_dash/features/auth/dealer/dealer_sign_up_response.dart';
import 'package:dine_dash/features/auth/dealer/email_check_response.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

import 'package:get/get.dart';

class DealerCreateAccountController extends BaseController {
  final ApiService _apiService = Get.find();
  final LocalStorageService _localStorage = Get.find();

  Future<void> signUp({
    required String fullName,
    required String businessName,
    required String businessType,
    required String email,
    required String postalCode,
    required String address,
    required String? password,

    required String phoneNumber,
    required Function() next,
    String? hearFrom,

    required List<String> types,

    required List<Map<String, dynamic>> openingHours,
    required List<double> coordinates,
    required File imageFile,
  }) async {
    final role = (SessionMemory.isUser) ? "user" : "business";

    await safeCall<void>(
      task: () async {
        // final body = {
        //   "fullName": fullName,
        //   "email": email,
        //   "postalCode": postalCode,
        //   "password": password,
        //   "role": role,
        //   "businessName": businessName,
        //   "businessType": businessType.toLowerCase(),
        //   "formatted_address": address,
        //   "types": types,
        //   "formatted_phone_number": phoneNumber,
        //   "qa": hearFrom,
        // };

        final formData = {
          "fullName": fullName,
          "email": email,
          "postalCode": postalCode,
          "password": password,
          "role": role,
          "businessName": businessName,
          "businessType": businessType.toLowerCase(),
          "formatted_address": address,
          "types": types,
          "formatted_phone_number": phoneNumber,
          "qa": hearFrom,
          "openingHours": openingHours,
          "location": {"type": "Point", "coordinates": coordinates},
        };

        log(imageFile.path);

        final response = await _apiService.multipart(
          ApiEndpoints.userSignUp,
          body: formData,
          method: 'POST',
          files: {'image': imageFile},
        );

        // final response = await _apiService.post(ApiEndpoints.userSignUp, body);
        final signUpResponse = DealerSignUpResponse.fromJson(response);

        if (signUpResponse.statusCode == 201) {
          if (signUpResponse.signUpToken != null) {
            await _localStorage.saveString(
              StorageKey.token,
              signUpResponse.signUpToken!,
            );
          }
          next();

          showSnackBar(signUpResponse.message, isError: false);
        } else {
          throw Exception(signUpResponse.message);
        }
      },
    );
  }

  Future<void> checkEmail(
    String email, {
    required BuildContext context,
    required Place? businessDetails,
    required double lat,
    required double long,
    required String address,
    required String name,

    required List<String> types,
    required String? businessType,
    required String phoneNumber,
    required String postalCode,
    required List<Map<String, dynamic>> openingHours,
    required List<double> coordinates,
    File? imageFile,
  }) async {
    safeCall(
      task: () async {
        if (email.isEmpty || !email.isValidEmail) {
          throw Exception("Invalide Email");
        }

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

        if (coordinates.length != 2) {
          throw Exception("Invalid coordinates");
        }

        if (imageFile == null) {
          throw Exception("Please upload your business image");
        }

        final response = await _apiService.post(ApiEndpoints.checkEmail, {
          "email": email,
          "role": "business",
        });
        final emailResponseModel = EmailCheckResponse.fromJson(response);
        navigateToPage(
          CreateDealerAccount2ndPage(
            businessDetails: businessDetails,
            userData: emailResponseModel.data,
            email: email,
            latitude: lat,
            longitude: long,
            address: address,
            businessName: name,
            businessType: businessType,

            openingHours: openingHours,
            phoneNumber: phoneNumber,
            postalCode: postalCode,
            types: types,
            imageFile: imageFile,
          ),
          context: context,
        );
      },
    );
  }
}
