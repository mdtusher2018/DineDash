import 'package:dine_dash/core/services/api/api_exception.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  /// Common method to safely execute async operations with error handling
  Future<T?> safeCall<T>({
    required Future<T> Function() task,
    String? successMessage,
    bool showErrorSnack = true,
    bool showSuccessSnack = false,
    bool showLoading = true, // ✅ new flag
    Future<T> Function(int, String)? errorHandle,
  }) async {
    try {
      if (showLoading) isLoading.value = true;
      errorMessage.value = '';

      final result = await task();

      if (showSuccessSnack && successMessage != null) {
        showSnackBar(successMessage, isError: false);
      }

      return result;
    } catch (e, stack) {
      debugPrint('❌ Exception: $e\n$stack');

      errorMessage.value = e.toString();
      if (e is ApiException && errorHandle != null) {
        errorHandle(e.statusCode, e.message);
      } else {
        if (showErrorSnack) showSnackBar(errorMessage.value, isError: true);
      }
      return null;
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }
}
