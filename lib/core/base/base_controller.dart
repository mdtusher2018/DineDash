import 'package:dine_dash/core/services/api/api_exception.dart';
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
    Future<T> Function(int)? errorHandle,
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
        errorHandle(e.statusCode);
      } else {
        if (showErrorSnack) showSnackBar(errorMessage.value, isError: true);
      }
      return null;
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  /// Universal snackbar method
  void showSnackBar(String message, {bool isError = false}) {
    if (message.isEmpty) return;
    if (Get.isDialogOpen == true) Get.back();
    Get.snackbar(
      isError ? 'Error' : 'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
    );
  }
}
