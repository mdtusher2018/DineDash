import 'dart:developer';
import 'dart:io';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart'; // Add your profile endpoint here
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/features/auth/dealer/create_dealer_1st_page.dart';
import 'package:dine_dash/features/auth/user/user_create_account_1st_page.dart';
import 'package:dine_dash/features/dealer_root_page.dart';
import 'package:dine_dash/features/onboarding/DealerOnboarding.dart';
import 'package:dine_dash/features/onboarding/UserOnboarding.dart';
import 'package:dine_dash/features/profile/common/edit_profile/edit_profile_response.dart';
import 'package:dine_dash/features/profile/common/profile/profile_response.dart';
import 'package:dine_dash/features/profile/common/profile/switch_account_response.dart';
import 'package:dine_dash/features/user_root_page.dart';
import 'package:dine_dash/core/models/user_model.dart'; // The model that holds user attributes
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/role_selection_page.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  final ApiService _apiService = Get.find();
  final SessionMemory _sessionMemory = Get.find();
  final LocalStorageService _localStorageService = Get.find();

  var userModel = Rxn<UserModel>();
  RxString currentRole = ''.obs;

  Future<void> fetchProfile() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.userProfile);

        final profileResponse = ProfileResponse.fromJson(response);

        if (profileResponse.statusCode == 200 && profileResponse.user != null) {
          userModel.value = profileResponse.user;
          await updateCurrentRoleFromToken();
        } else {
          throw Exception(profileResponse.message);
        }
      },
    );
  }

  Future<void> updateProfile({
    String? fullName,
    String? postalCode,
    File? image,
  }) async {
    await safeCall(
      task: () async {
        final Map<String, dynamic> body = {};

        if (fullName != null) body['fullName'] = fullName;
        if (postalCode != null) body['postalCode'] = postalCode;

        Map<String, File>? files;
        if (image != null) {
          files = {'image': image}; // the field name expected by your API
        }

        final response = await _apiService.multipart(
          ApiEndpoints.updateProfile,
          method: 'PUT',
          body: body,
          files: files,
        );

        final profileResponse = UpdateProfileResponse.fromJson(response);

        if (profileResponse.statusCode == 200 && profileResponse.user != null) {
          userModel.value = profileResponse.user;
          Get.back();
          showSnackBar(
            'Your profile has been updated successfully!',
            isError: false,
          );
        } else {
          throw Exception(profileResponse.message);
        }
      },
    );
  }

  Future<void> switchAccount() async {
    log(currentRole.value);
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.switchAccount);

        final switchResponse = SwitchAccountResponse.fromJson(response);

        if (switchResponse.statusCode == 200 &&
            switchResponse.data?.attributes?.user != null) {
          userModel.value = switchResponse.data!.attributes!.user!;

          if (switchResponse.data!.attributes!.accessToken != null) {
            _sessionMemory.setToken(
              switchResponse.data!.attributes!.accessToken!,
            );

            String localStorageToken =
                await _localStorageService.getString(StorageKey.token) ?? "";
            if (localStorageToken.isNotEmpty) {
              await _localStorageService.saveString(
                StorageKey.token,
                switchResponse.data!.attributes!.accessToken!,
              );
            }
          }

          await updateCurrentRoleFromToken();

          if (currentRole.value == 'user') {
            navigateToPage(UserRootPage(), clearStack: true);
          } else {
            navigateToPage(DealerRootPage(), clearStack: true);
          }

          showSnackBar(
            'Account switched to ${currentRole.value} successfully!',
            isError: false,
          );
        } else {
          throw Exception(switchResponse.message);
        }
      },
      errorHandle: (statusCode) async {
        if (statusCode == 403) {
          if (currentRole.value == 'user') {
            _localStorageService.clearAllExceptOnboarding();
            _sessionMemory.clear();
            SessionMemory.isUser = false;
            if (LocalStorageService.isDealerOnBoardingCompleated) {
              navigateToPage(CreateDealerAccount1stPage(), clearStack: true);
            } else {
              navigateToPage(DealerOnboardingView(), clearStack: true);
            }
          } else {
            _localStorageService.clearAllExceptOnboarding();
            _sessionMemory.clear();
            SessionMemory.isUser = true;
            if (LocalStorageService.isUserOnboardingCompleated) {
              navigateToPage(CreateUserAccountFristPage(), clearStack: true);
            } else {
              navigateToPage(UserOnboardingView(), clearStack: true);
            }
          }
        }
      },
    );
  }

  Future<void> updateCurrentRoleFromToken() async {
    String? token = await _localStorageService.getString(StorageKey.token);
    token ??= _sessionMemory.token;

    final payload = decodeJwtPayload(token ?? '');
    final role = payload['currentRole'] as String?;
    if (role == 'user') {
      SessionMemory.isUser = true;
    } else {
      SessionMemory.isUser = false;
    }

    if (role != null) currentRole.value = role;
  }

  Future<void> deleteAccount(String password) async {
    safeCall(
      task: () async {
        final response = await _apiService.delete(
          ApiEndpoints.deleteAccount,
          body: {"password": password},
        );
        if (response['statusCode'] == 200) {
          navigateToPage(RoleSelectionPage(), clearStack: true);
        }
      },
    );
  }

  Future<void> logOut() async {
    await _localStorageService.clearAllExceptOnboarding();
    _sessionMemory.clear();

    navigateToPage(RoleSelectionPage(), clearStack: true);
  }
}
