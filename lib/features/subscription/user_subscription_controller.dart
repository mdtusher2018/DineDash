import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/services/api/api_service.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/subscription/my_subscription_response.dart';
import 'package:dine_dash/features/subscription/payment_webview.dart';
import 'package:dine_dash/features/subscription/subscription_model.dart';
import 'package:dine_dash/features/subscription/user_subscription_model.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSubscriptionController extends BaseController {
  final ApiService _apiService = Get.find();

  RxList<PlanModel> plans = <PlanModel>[].obs;
  Rx<SubscriptionData?> mySubscription = Rx<SubscriptionData?>(null);

  RxBool haveSubscription = false.obs;

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

  Future<void> freepayment(
    String subscriptionId, {
    required BuildContext context,
  }) async {
    await safeCall(
      task: () async {
        final response = await _apiService.post(ApiEndpoints.freePayment, {
          "planId": subscriptionId,
        });

        if (response["statusCode"] == 200) {
          showSnackBar("Payment sucessfull");
        } else {
          throw Exception("An error occurred while processing payment.");
        }
      },
    );
  }

  Future<void> payment(
    String subscriptionId, {
    required BuildContext context,
  }) async {
    await safeCall(
      task: () async {
        final response = await _apiService.post(ApiEndpoints.payment, {
          "subscription": subscriptionId,
        });

        if (response["url"] != null) {
          Get.to(() => PaymentWebViewScreen(url: response["url"]));
        } else {
          throw Exception("An error occurred while processing payment.");
        }
      },
    );
  }

  Future<void> getMySubscription() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.mySubscription);

        final subscriptionResponse = MySubscriptionPlanResponse.fromJson(
          response,
        );

        mySubscription.value = subscriptionResponse.data;
      },
    );
  }

  Future<void> getActiveSubscription() async {
    await safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.myActiveSubscription,
        );

        haveSubscription.value = response['data']?['attributes'] ?? false;
      },
    );
  }
}
