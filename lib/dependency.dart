import 'package:dine_dash/core/services/api/api_client.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/features/auth/common/email_verification/email_verification_controller.dart';
import 'package:dine_dash/features/auth/common/forget_password/forget_password_controller.dart';
import 'package:dine_dash/features/auth/common/otp_verification/otp_verification_controller.dart';
import 'package:dine_dash/features/auth/common/reset_password/reset_password_controller.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_controller.dart';
import 'package:dine_dash/features/auth/user/user_sign_up_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    // ---------- Services ----------
    LocalStorageService.init();
    final localStorageService = LocalStorageService();

    Get.put<LocalStorageService>(localStorageService, permanent: true);

    Get.put<SessionMemory>(SessionMemory(), permanent: true);

    final apiClient = ApiClient();
    Get.put<ApiClient>(apiClient, permanent: true);

    final apiService = ApiService(apiClient, localStorageService);
    Get.put<ApiService>(apiService, permanent: true);

    // ---------- Controllers ----------
    Get.put<SignInController>(SignInController(), permanent: true);
    Get.put<SignUpController>(SignUpController(), permanent: true);
    Get.put<EmailVerificationController>(
      EmailVerificationController(),
      permanent: true,
    );
    Get.put<ForgetPasswordController>(
      ForgetPasswordController(),
      permanent: true,
    );
    Get.put<OTPVerificationController>(
      OTPVerificationController(),
      permanent: true,
    );
    Get.put<ResetPasswordController>(
      ResetPasswordController(),
      permanent: true,
    );
  }
}
