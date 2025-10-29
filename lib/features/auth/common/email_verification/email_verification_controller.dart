import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/core/validators/auth_validator.dart';
import 'package:dine_dash/features/auth/common/email_verification/email_verification_response.dart';
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/features/user_root_page.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/base/base_controller.dart';

class EmailVerificationController extends BaseController {
  final ApiService _apiService = Get.find();
  final LocalStorageService _localStorage = Get.find();

  RxBool isResendOTPTrue = false.obs;

  Future<void> verifyEmail({required String otp}) async {
    final validationMessage = AuthValidator.validateEmailAndOTPVerification(
      otp: otp,
    );
    if (validationMessage != null) {
      showSnackBar(validationMessage, isError: true);
      return;
    }

    await safeCall<void>(
      task: () async {
        final body = {
          "otp": otp,
          "purpose":
              (isResendOTPTrue.value) ? "resend-otp" : "email-verification",
        };
        final response = await _apiService.post(
          ApiEndpoints.emailVerification,
          body,
        );
        final emailVerificationResponse = EmailVerificationResponse.fromJson(
          response,
        );

        if (emailVerificationResponse.statusCode == 201) {
          final token = emailVerificationResponse.accessToken;

          await _localStorage.saveString(StorageKey.token, token);

          if (decodeJwtPayload(token)["currentRole"] == "user") {
            Get.offAll(() => UserRootPage());
          } else {
            Get.offAll(() => DealerRootPage());
          }

          showSnackBar('Signed Up successfully!', isError: false);
        } else {
          throw Exception(emailVerificationResponse.message);
        }
      },
    );
  }

  Future<void> resendOTP() async {
    await safeCall<void>(
      task: () async {
        String token = await _localStorage.getString(StorageKey.token) ?? "";

        String email = decodeJwtPayload(token)["email"] ?? "";
        final body = {"email": email};
        final response = await _apiService.post(ApiEndpoints.resendOTP, body);
        final resendOTPResponse = EmailVerificationResponse.fromJson(response);

        if (resendOTPResponse.statusCode == 200) {
          showSnackBar(resendOTPResponse.message, isError: false);
        } else {
          throw Exception(resendOTPResponse.message);
        }
      },
    );
  }
}
