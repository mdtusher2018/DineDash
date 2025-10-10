import 'package:dine_dash/core/services/api/api_client.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_controller.dart';
import 'package:dine_dash/features/auth/user/user_sign_up_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    // ---------- Services ----------
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
  }
}
