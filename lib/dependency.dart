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
import 'package:dine_dash/features/business/user/bussiness%20details/business_details_controller.dart';
import 'package:dine_dash/features/city_location_helper/city_controller.dart';
import 'package:dine_dash/features/explore/user_explore_controller.dart';
import 'package:dine_dash/features/favorite/favorite_controller.dart';
import 'package:dine_dash/features/home/user/home_page_controller.dart';
import 'package:dine_dash/features/notification/user%20notification/user_notification_controller.dart';
import 'package:dine_dash/features/profile/common/change%20password/change_password_controller.dart';
import 'package:dine_dash/features/profile/common/static_content/static_content_controller.dart';
import 'package:dine_dash/features/profile/user/profile/profile_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    // ---------- Services ----------
    LocalStorageService.init();
    final localStorageService = LocalStorageService();

    Get.put<LocalStorageService>(localStorageService, permanent: true);
    final sessionMemoryService = SessionMemory();

    Get.put<SessionMemory>(sessionMemoryService, permanent: true);

    final apiClient = ApiClient();
    Get.put<ApiClient>(apiClient, permanent: true);

    final apiService = ApiService(
      apiClient,
      localStorageService,
      sessionMemoryService,
    );
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

    Get.put<HomeController>(HomeController(), permanent: true);
    Get.put<BusinessDetailController>(
      BusinessDetailController(),
      permanent: true,
    );

    Get.put<FavoriteController>(FavoriteController(), permanent: true);

    Get.put<CityController>(CityController(), permanent: true);

    Get.put<UserExploreController>(UserExploreController(), permanent: true);
    Get.put<UserNotificationController>(
      UserNotificationController(),
      permanent: true,
    );
    Get.put<ProfileController>(ProfileController(), permanent: true);
    Get.put<StaticContentController>(
      StaticContentController(),
      permanent: true,
    );
    Get.put<ChangePasswordController>(
      ChangePasswordController(),
      permanent: true,
    );
  }
}
