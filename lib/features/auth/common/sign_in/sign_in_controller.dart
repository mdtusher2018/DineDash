// ignore_for_file: use_build_context_synchronously

import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/validators/auth_validator.dart';
import 'package:dine_dash/features/auth/common/sign_in/sign_in_response.dart';
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/features/user_root_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/common_pending_dialog.dart';
import 'package:flutter/material.dart';
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
    required BuildContext context,
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
        final role = (SessionMemory.isUser) ? "user" : "business";
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

          if (SessionMemory.isUser) {
            navigateToPage(context: context, UserRootPage());
          } else {
            if (loginResponse.isApproved != null &&
                loginResponse.isApproved == true) {
              navigateToPage(context: context, DealerRootPage());
            } else {
              showPendingDialog(context);
            }
          }

          showSnackBar('Signed in successfully!', isError: false);
        } else {
          throw Exception(loginResponse.message);
        }
      },
    );
  }
}
