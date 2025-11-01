import 'package:dine_dash/core/services/api/api_client.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/features/auth/common/email_verification/email_verification_controller.dart';
import 'package:dine_dash/features/auth/common/forget_password/forget_password_controller.dart';
import 'package:dine_dash/features/auth/common/otp_verification/otp_verification_controller.dart';
import 'package:dine_dash/features/auth/common/reset_password/reset_password_controller.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_controller.dart';
import 'package:dine_dash/features/auth/dealer/create_dealer_account_controller.dart';
import 'package:dine_dash/features/auth/user/user_sign_up_controller.dart';
import 'package:dine_dash/features/business/dealer/add_business/dealer_business_controller.dart';
import 'package:dine_dash/features/business/dealer/add_menu/add_menu_controller.dart';
import 'package:dine_dash/features/business/dealer/dealer_business_details/dealer_business_details_controller.dart';
import 'package:dine_dash/features/business/dealer/dealer_business_root_page/dealer_all_business_controller.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/business_details_controller.dart';
import 'package:dine_dash/core/controller/city_controller.dart';
import 'package:dine_dash/features/deals/dealer/dealer_deal_controller.dart';
import 'package:dine_dash/features/deals/dealer/dealer_deal_root_page/dealer_all_deals_controller.dart';
import 'package:dine_dash/features/deals/user/available%20deals/user_allavailable_deals_controller.dart';
import 'package:dine_dash/features/deals/user/used%20deal/user_used_deals_controller.dart';
import 'package:dine_dash/features/explore/user_explore_controller.dart';
import 'package:dine_dash/features/favorite/favorite_controller.dart';
import 'package:dine_dash/features/home/dealer/dealer_homepage_controller.dart';
import 'package:dine_dash/features/home/user/home_page_controller.dart';
import 'package:dine_dash/features/notification/user%20notification/user_notification_controller.dart';
import 'package:dine_dash/features/profile/common/change%20password/change_password_controller.dart';
import 'package:dine_dash/features/profile/common/static_content/static_content_controller.dart';
import 'package:dine_dash/features/profile/user/profile/profile_controller.dart';
import 'package:dine_dash/features/ratting/dealer/review_controller.dart';
import 'package:dine_dash/features/subscription/user_subscription_controller.dart';
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
    Get.put<DealerHomepageController>(
      DealerHomepageController(),
      permanent: true,
    );
    Get.put<DealerBusinessDetailController>(
      DealerBusinessDetailController(),
      permanent: true,
    );
    Get.put<DealerAllBusinessController>(
      DealerAllBusinessController(),
      permanent: true,
    );
    Get.put<DealerAddBusinessController>(
      DealerAddBusinessController(),
      permanent: true,
    );

    Get.put<DealerMenuController>(
      DealerMenuController(),
      permanent: true,
    );
    Get.put<FeedbackController>(FeedbackController(), permanent: true);
    Get.put<DealerDealController>(DealerDealController(), permanent: true);
    Get.put<DealerAllDealsController>(
      DealerAllDealsController(),
      permanent: true,
    );

    Get.put<DealerCreateAccountController>(
      DealerCreateAccountController(),
      permanent: true,
    );
    Get.put<UserAvailableDealsController>(
      UserAvailableDealsController(),
      permanent: true,
    );
    Get.put<UserAllUseddDealsController>(
      UserAllUseddDealsController(),
      permanent: true,
    );
    Get.put<UserSubscriptionController>(
      UserSubscriptionController(),
      permanent: true,
    );
  }
}
