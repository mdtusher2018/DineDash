import 'package:dine_dash/core/controller/my_business_name_controller.dart';
import 'package:dine_dash/features/ratting_and_feedback/dealer/review_response.dart';
import 'package:get/get.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';

class DealerReviewbackController extends DealerMyBusinessNameListController {
  final ApiService _apiService = Get.find();

  var feedbackResponse = Rxn<DealerFeedBackResponse>();

  Future<void> fetchFeedback({
    required int page,
    String? businessId,
    int? ratting,
    String? sortBy,
  }) async {
    await safeCall(
      task: () async {
        
        final response = await _apiService.get(
          ApiEndpoints.review(
            page: page,
            businessId: businessId,
            ratting: ratting,
            sortBy: sortBy?.split(' ').first.toLowerCase(),
          ),
        );
        final model=DealerFeedBackResponse.fromJson(response);
        if(page==1){
        feedbackResponse.value = model;}
        else{
          feedbackResponse.value!.feedBackAttributes.data.addAll(model.feedBackAttributes.data);
        }
      },
    );
  }
}
