import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/mixin/google_place_api_mixin.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/extentions.dart';
import 'package:dine_dash/features/auth/common/email_verification/verify_email.dart';
import 'package:dine_dash/features/auth/dealer/create_dealer_3rd_page.dart';

import 'package:dine_dash/features/auth/dealer/dealer_sign_up_response.dart';
import 'package:dine_dash/features/auth/dealer/email_check_response.dart';
import 'package:dine_dash/features/business/dealer/add_business/add_business_frist_page.dart';
import 'package:dine_dash/features/business/dealer/add_business/add_business_second_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';

import 'package:get/get.dart';

class DealerCreateAccountController extends BaseController
    with GooglePlaceApiMixin {
  final ApiService _apiService = Get.find();
  final LocalStorageService _localStorage = Get.find();
  final SessionMemory _sessionMemory = Get.find();

  Future<void> signUp({
    required String fullName,
    required String businessName,
    required String email,
    required String postalCode,
    required String address,
    required String password,
    required String confirlPassword,
    required String phoneNumber,
    required String placeId,
  }) async {
    final role = (_sessionMemory.roleIsUser ?? false) ? "user" : "business";

    await safeCall<void>(
      task: () async {
        final body = {
          "fullName": fullName,
          "email": email,
          "postalCode": postalCode,
          "password": password,
          "role": role,

          "businessName": businessName,
          // "businessType": "activity",
          "formatted_address": address,
          // "types": ["restaurant", "store"],
          "formatted_phone_number": phoneNumber,
          // "qa": "question ans",
          "placeId": placeId,
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

          _sessionMemory.setRole(false);

          Get.to(EmailVerificationScreen());
          showSnackBar(signUpResponse.message, isError: false);
        } else {
          throw Exception(signUpResponse.message);
        }
      },
    );
  }

  Future<void> checkEmail(String email,dynamic businessDetails, {required double? longitude,required double? latitude}) async {
    safeCall(
      task: () async {
        if (email.isEmpty || !email.isValidEmail) {
          throw Exception("Invalide Email");
        }
       final response=await _apiService.post(ApiEndpoints.checkEmail, {"email": email});
       final emailResponseModel=EmailCheckResponse.fromJson(response);
       navigateToPage(DealerAddBusinessSecondScreen(result: businessDetails,userData: emailResponseModel.data,email:email,latitude: latitude,longitude: longitude,fromSignup: true,))
       ;
      },
    );
   
  }
}
