import 'dart:convert';
import 'dart:developer';
import 'package:dine_dash/core/base/base_controller.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/features/auth/dealer/business_selection_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

mixin GooglePlaceApiMixin on BaseController {
  String _buildSearchQuery({
    required TextEditingController businessController,
    required TextEditingController addressController,
  }) {
    final parts = <String>[];

    if (businessController.text.isNotEmpty) {
      parts.add(businessController.text.trim());
    }
    if (addressController.text.isNotEmpty) {
      parts.add(addressController.text.trim());
    }

    return parts.join(
      ", ",
    ); // Example: "KFC, Gulshan Avenue-7, +880123456789, restaurant"
  }

  Future<void> fetchBusinessFromGoogle({
    required TextEditingController businessController,
    required TextEditingController addressController,
    required bool fromSignup,
    required double? longitude,
    required double? latitude
  }) async {
    final url = Uri.parse('https://places.googleapis.com/v1/places:searchText');

    final body = json.encode({
      "textQuery": _buildSearchQuery(
        businessController: businessController,
        addressController: addressController,
      ),
    });

    // Headers
    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': ApiEndpoints.mapKey,
      'X-Goog-FieldMask': 'places',
      // 'places.displayName,places.shortFormattedAddress,places.primaryTypeDisplayName,places.rating,places.userRatingCount,places.internationalPhoneNumber,places.websiteUri,places.businessStatus,places.photos,places.id',
    };

    safeCall(
      task: () async {
        final response = await http.post(url, headers: headers, body: body);
        log(response.body.toString());
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final places = data['places'] as List<dynamic>? ?? [];
          navigateToPage(
            BusinessSelectionPage(
              results: places,
              fromSignup:fromSignup,
              longitude: longitude,
              latitude: latitude,
            ),
          );
        } else {
          log("Error ${response.statusCode}: ${response.body}");
        }
      },
    );
  }
}
