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
    required String? postalCode,
    required String address,
    required String? password,
    required String confirlPassword,
    required String phoneNumber,
    required Function() next,
  }) async {
    final role = (SessionMemory.isUser) ? "user" : "business";

    await safeCall<void>(
      task: () async {
        final body = {
          "fullName": fullName,
          "email": email,
          "postalCode": postalCode,
          "password": password,
          "role": role,

          "businessName": businessName,
          "businessType": businessType.toLowerCase(),
          "formatted_address": address,
          // "types": ["restaurant", "store"],
          "formatted_phone_number": phoneNumber,
          // "qa": "question ans",
        };

        final response = await _apiService.post(ApiEndpoints.userSignUp, body);
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
    required String businessName,
    required String address,
  }) async {
    safeCall(
      task: () async {
        if (email.isEmpty || !email.isValidEmail) {
          throw Exception("Invalide Email");
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
            businessName: businessName,
          ),
          context: context,
        );
        //  navigateToPage(DealerAddBusinessSecondScreen(result: businessDetails,userData: emailResponseModel.data,email:email,latitude: latitude,longitude: longitude,fromSignup: true,))
      },
    );
  }
}
