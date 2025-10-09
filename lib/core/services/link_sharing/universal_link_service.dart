
import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  /// Initialize deep links
  Future<void> initDeepLinks(BuildContext context,WidgetRef ref) async {
    // Cold start
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleLink(initialLink, context,ref);
    }

    // Foreground/background
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) => _handleLink(uri, context,ref),
      onError: (err) => debugPrint("DeepLink error: $err"),
    );
  }

  void _handleLink(Uri uri, BuildContext context,WidgetRef ref) {
    debugPrint("DeepLink received: $uri");

    // Detect type of link
    if (uri.path.startsWith("/running/")) {
      final runId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
      if (runId != null) {
        // Trigger the controller to fetch details
        // ref.read(runShareDetailProvider.notifier).fetchRunDetail(runId);
      }
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}

