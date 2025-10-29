import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/subscription/user_subscription_model.dart';
import 'package:get/get.dart';

class UserSubscriptionController extends BaseController {
  final ApiService _apiService = Get.find();

  RxList<PlanModel> plans = <PlanModel>[].obs;

  // Fetch all subscriptions
  Future<void> getAllSubscription() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.getAllSubscription);

        final subscriptionResponse = SubscriptionPlansResponse.fromJson(
          response,
        );

        plans.value = subscriptionResponse.data.attributes;
      },
    );
  }
}
