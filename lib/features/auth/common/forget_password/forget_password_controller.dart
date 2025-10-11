import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/validators/auth_validator.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/features/auth/common/forget_password/forget_password_response.dart';
import 'package:dine_dash/features/auth/common/otp_verification/otp_verification_page.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends BaseController {
  final ApiService _apiService = Get.find();
  final LocalStorageService _localStorage = Get.find();

  Future<void> forgetPassword({
    required String email,
  }) async {
    
    final validationMessage = AuthValidator.validateForgetPassword(
      email: email,
    );

    if (validationMessage != null) {
      showSnackBar(validationMessage, isError: true);
      return;
    }

    await safeCall<void>(
      task: () async {
        final body = {
          "email": email,
        };

        final response = await _apiService.post(ApiEndpoints.forgetPassword, body);
        final forgetPasswordResponse = ForgetPasswordResponse.fromJson(response);

        if (forgetPasswordResponse.statusCode == 200) {
          if (forgetPasswordResponse.forgetPasswordToken != null) {
            await _localStorage.saveString(
              StorageKey.token,
              forgetPasswordResponse.forgetPasswordToken!,
            );
          }

          Get.to(OTPVerificationScreen());
          showSnackBar(forgetPasswordResponse.message, isError: false);
        } else {
          throw Exception(forgetPasswordResponse.message);
        }
      },
    );
  }
}
