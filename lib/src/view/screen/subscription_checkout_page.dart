import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapyd_collect_api/src/controller/plans_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SubscriptionCheckoutPage extends StatelessWidget {
  SubscriptionCheckoutPage({super.key, required this.planId});

  final String planId;

  final contronller = Get.put(PlansController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: contronller.rapyd.subscribeToPlan(planId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('Some error occurred!'));
            } else {
              var webViewController = WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                    onPageStarted: (String url) {
                      if (url
                          .contains(snapshot.data!["complete_checkout_url"])) {
                        Get.back(result: 'Success');

                        Get.showSnackbar(GetSnackBar(
                          title: 'Success',
                          message: 'Success',
                        ));
                      } else if (url
                          .contains(snapshot.data!["cancel_checkout_url"])) {
                        Get.back(result: 'Canceled');
                        Get.showSnackbar(GetSnackBar(
                          title: 'Failure',
                          message: 'Failure',
                        ));
                      }
                    },
                    onPageFinished: (String url) {},
                    onWebResourceError: (WebResourceError error) {},
                  ),
                )
                ..loadRequest(
                    Uri.parse(snapshot.data!["redirect_url"].toString()));
              return WebViewWidget(
                controller: webViewController,
              );
            }
        }
      },
    ));
  }
}
