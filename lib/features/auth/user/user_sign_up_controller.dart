import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/validators/auth_validator.dart';

import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/features/auth/common/email_verification/verify_email.dart';
import 'package:dine_dash/features/auth/user/user_sign_up_response.dart';
import 'package:get/get.dart';

class SignUpController extends BaseController {
  final ApiService _apiService = Get.find();
  final LocalStorageService _localStorage = Get.find();

  Future<void> signUp({
    required String fullName,
    required String email,
    required String postalCode,
    required String password,
    required String confirlPassword,
    required bool tremsAndCondition
  }) async {
    // ✅ Validate inputs first
    final validationMessage = AuthValidator.validateSignUp(
      fullName: fullName,
      email: email,
      postalCode: postalCode,
      password: password,
      confirmPassword: confirlPassword,
      tremsAndCondition:tremsAndCondition
    );

    if (validationMessage != null) {
      showSnackBar(validationMessage, isError: true);
      return;
    }

    final role = (SessionMemory.isUser) ? "user" : "business";

    // ✅ Proceed safely
    await safeCall<void>(
      task: () async {
        final body = {
          "fullName": fullName,
          "email": email,
          "postalCode": postalCode,
          "password": password,
          "role": role,
        };

        final response = await _apiService.post(ApiEndpoints.userSignUp, body);
        final signUpResponse = UserSignUpResponse.fromJson(response);

        if (signUpResponse.statusCode == 201) {
          if (signUpResponse.signUpToken != null) {
            await _localStorage.saveString(
              StorageKey.token,
              signUpResponse.signUpToken!,
            );
          }

          Get.to(EmailVerificationScreen());
          showSnackBar(signUpResponse.message, isError: false);
        } else {
          throw Exception(signUpResponse.message);
        }
      },
    );
  }
}
