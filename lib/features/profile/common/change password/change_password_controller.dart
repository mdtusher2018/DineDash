import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/profile/common/change%20password/change_password_response.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:get/get.dart';

class ChangePasswordController extends BaseController {
  final ApiService _apiService = Get.find();

  /// Change password function
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    // Basic validation
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      showSnackBar("All fields are required".tr, isError: true);
      return;
    }
    if (newPassword.length < 6) {
      showSnackBar(
        "New password must be at least 6 characters long".tr,
        isError: true,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      showSnackBar("Passwords do not match".tr, isError: true);
      return;
    }

    if (oldPassword == newPassword) {
      showSnackBar("Old and New password can't be same".tr, isError: true);
      return;
    }

    await safeCall(
      task: () async {
        final body = {"oldPassword": oldPassword, "newPassword": newPassword};

        final response = await _apiService.patch(
          ApiEndpoints.changePassword,
          body,
        );

        final changePasswordResponse = ChangePasswordResponse.fromJson(
          response,
        );

        if (changePasswordResponse.statusCode == 200) {
          showSnackBar(changePasswordResponse.message.tr);
        } else {
          throw Exception(changePasswordResponse.message);
        }
      },
      showSuccessSnack: true,
      successMessage: "Password changed sucessfully!",
      showErrorSnack: true,
    );
  }
}
