import 'package:dine_dash/core/controller/my_business_name_controller.dart';
import 'package:dine_dash/features/ratting/dealer/review_response.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class FeedbackController extends DealerMyBusinessNameListController {
  final ApiService _apiService = Get.find();

  var feedbackResponse = Rxn<DealerFeedBackResponse>();

  Future<void> fetchFeedback() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.review);
        feedbackResponse.value = DealerFeedBackResponse.fromJson(response);
      },
    );
  }

  Future<void> reloadFeedback() async {
    await fetchFeedback();
  }
}
