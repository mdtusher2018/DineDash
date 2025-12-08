import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatelessWidget {
  final String url;

  const PaymentWebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Payment"),
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: WebViewWidget(
        controller:
            WebViewController(
                onPermissionRequest: (request) {
                  request.grant();
                },
              )
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onHttpError: (HttpResponseError error) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.contains('transaction/complete')) {
                      Get.close(1);
                      showSnackBar("Payment sucessfull");
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(Uri.parse(url)),
      ),
    );
  }
}
