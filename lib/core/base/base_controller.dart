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
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await task();

      if (showSuccessSnack && successMessage != null) {
        showSnackBar(successMessage, isError: false);
      }

      return result;
    } catch (e, stack) {
      debugPrint('❌ Exception: $e\n$stack');

      errorMessage.value = e.toString();

      if (showErrorSnack) showSnackBar(errorMessage.value, isError: true);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Universal snackbar method
  void showSnackBar(String message, {bool isError = false}) {
    if (message.isEmpty) return;
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
