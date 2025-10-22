import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/services/localstorage/local_storage_service.dart';
import 'package:dine_dash/core/services/localstorage/storage_key.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/profile/common/static_content/static_content_response.dart';
import 'package:get/get.dart';

class StaticContentController extends BaseController {
  final ApiService _apiService = Get.find();
  final LocalStorageService _localStorage = Get.find();

  var staticContent = Rxn<StaticContentData>();
  @override
  var isLoading = false.obs;

  Future<void> fetchStaticContent(String type) async {
    await safeCall(
      task: () async {
        isLoading.value = true;

        final response =
            await _apiService.get(ApiEndpoints.staticContent(type));

        final parsed = StaticContentResponse.fromJson(response);

        if (parsed.statusCode == 200) {
          staticContent.value = parsed.data;
        } else {
          staticContent.value = null;
          throw Exception(parsed.message);
        }
      },

    );
  }

  /// Helper to get localized content based on saved language
  Future<String> getLocalizedContent() async {
    final langCode =
        await _localStorage.getString(StorageKey.languageCode) ?? 'en';

    final content = staticContent.value?.attributes?.content;
    if (content == null) return '';

    switch (langCode) {
      case 'de':
        return content.de;
      case 'en':
      default:
        return content.en;
    }
  }
}
