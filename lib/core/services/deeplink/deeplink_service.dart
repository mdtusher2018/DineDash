import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';


class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  /// Optional callbacks to handle navigation
  void Function(String businessId)? onBusinessLink;
  void Function(String businessId, String dealId)? onDealLink;



  Future<void> initDeepLinks() async {
    // Cold start
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleLink(initialLink);
    }

    // Foreground/background
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) => _handleLink(uri),
      onError: (err) => debugPrint("DeepLink error: $err"),
    );
  }

  void _handleLink(Uri uri) {
  debugPrint("DeepLink received: $uri");

    final segments = uri.pathSegments;

    if (segments.isEmpty) return;

    if (segments.length >= 2 && segments[0] == 'business') {
      final businessId = segments[1];

      if (segments.length >= 4 && segments[2] == 'deal') {
        // Deal link
        final dealId = segments[3];
        if (onDealLink != null) {
          onDealLink!(businessId, dealId);
        }
      } else {
        // Business link
        if (onBusinessLink != null) {
          onBusinessLink!(businessId);
        }
      }
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}