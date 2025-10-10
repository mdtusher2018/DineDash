import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/validators/auth_validator.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_model.dart';
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/features/user_root_page.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/base/base_controller.dart';

class SignInController extends BaseController {
  final ApiService _apiService = Get.find();
  final LocalStorageService _localStorage = Get.find();
  final SessionMemory _sessionMemory = Get.find();

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {

    final validationMessage = AuthValidator.validateSignIn(
      email: email,
      password: password,
    );
    if (validationMessage != null) {
      showSnackBar(validationMessage, isError: true);
      return;
    }

    await safeCall<void>(
      task: () async {
        final role = (_sessionMemory.roleIsUser ?? true) ? "user" : "business";

        final body = {"email": email, "password": password, "role": role};
        final response = await _apiService.post(ApiEndpoints.signin, body);
        final loginResponse = SignInResponse.fromJson(response);

        if (loginResponse.statusCode == 200) {
          final token = loginResponse.accessToken;

          if (rememberMe) {
            await _localStorage.saveString(StorageKey.token, token);
          } else {
            _sessionMemory.setToken(token);
          }

          if (_sessionMemory.roleIsUser ?? true) {
            Get.offAll(() => UserRootPage());
          } else {
            Get.offAll(() => DealerRootPage());
          }

          showSnackBar('Signed in successfully!', isError: false);
        } else {
          throw Exception(loginResponse.message);
        }
      },
    );
  }
}
