import 'dart:developer';

import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/core/validators/auth_validator.dart';
import 'package:dine_dash/features/auth/common/otp_verification/otp_verification_response.dart';
import 'package:dine_dash/features/auth/common/reset_password/reset_password_page.dart';
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/features/user_root_page.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/base/base_controller.dart';

class OTPVerificationController extends BaseController {
  final ApiService _apiService = Get.find();
  final LocalStorageService _localStorage = Get.find();

  RxBool isResendOTPTrue = false.obs;

  Future<void> verifyOTP({required String otp}) async {
    log(otp);
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
          "purpose": (isResendOTPTrue.value) ? "resend-otp" : "forget-password",
        };
        log(body.toString());
        final response = await _apiService.post(
          ApiEndpoints.emailVerification,
          body,
        );
        final otpVerificationResponse = OTPVerificationResponse.fromJson(
          response,
        );

        if (otpVerificationResponse.statusCode == 201) {
          final token = otpVerificationResponse.accessToken;

          await _localStorage.saveString(StorageKey.token, token);

          if (decodeJwtPayload(token)["currentRole"] == "user") {
            Get.offAll(() => UserRootPage());
          } else if ((decodeJwtPayload(token)["currentRole"] == "business")) {
            Get.offAll(() => DealerRootPage());
          } else {
            /*
              This is only navigate if their have any missing information with role.
              This is important to have role
            */
            Get.offAll(ResetPasswordScreen());
          }

          showSnackBar('OTP verified successfully!', isError: false);
        } else {
          throw Exception(otpVerificationResponse.message);
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
        final resendOTPResponse = OTPVerificationResponse.fromJson(response);

        if (resendOTPResponse.statusCode == 200) {
          showSnackBar(resendOTPResponse.message, isError: false);
        } else {
          throw Exception(resendOTPResponse.message);
        }
      },
    );
  }
}
