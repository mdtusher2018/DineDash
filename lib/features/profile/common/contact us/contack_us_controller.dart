import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/profile/common/contact%20us/contact_us_response.dart';
import 'package:get/get.dart';

class ContackUsController extends BaseController {
  final ApiService _apiService = Get.find();
  RxString email = ''.obs;
  RxString phone = ''.obs;
  Future<void> fetchContactUs() async {
    safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.contactUs);
        final contact = ContactUsResponse.fromJson(response);
        email.value = contact.email;
        phone.value = contact.phoneNumber;
        if (contact.statusCode != 200) {
          throw Exception(contact.message);
        }
      },
    );
  }
}
