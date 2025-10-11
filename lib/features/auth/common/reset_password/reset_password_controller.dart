import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/validators/auth_validator.dart';
import 'package:dine_dash/features/auth/common/reset_password/reset_password_response.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_page.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/services/api/api_service.dart';

import 'package:dine_dash/core/base/base_controller.dart';

class ResetPasswordController extends BaseController {
  final ApiService _apiService = Get.find();

  Future<void> resetPassword({
    required String password,
    required String confirmPassword,
  }) async {
    final validationMessage = AuthValidator.validateResetPassword(
      password: password,
      confirmPassword: confirmPassword,
    );
    if (validationMessage != null) {
      showSnackBar(validationMessage, isError: true);
      return;
    }

    await safeCall<void>(
      task: () async {
        final body = {"password": password};
        final response = await _apiService.post(ApiEndpoints.signin, body);
        final resetPasswordResponse = ResetPasswordResponse.fromJson(response);

        if (resetPasswordResponse.statusCode == 200) {
          Get.offAll(() => SignInScreen());
          showSnackBar('Password Reset successfully!', isError: false);
        } else {
          throw Exception(resetPasswordResponse.message);
        }
      },
    );
  }
}
