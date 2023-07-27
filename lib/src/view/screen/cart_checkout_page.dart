import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapyd_collect_api/core/utils/rapyd_client_api.dart';
import 'package:rapyd_collect_api/core/utils/rapyd_client_api_impl.dart';
import 'package:rapyd_collect_api/src/controller/office_furniture_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CartCheckoutPage extends StatelessWidget {
  CartCheckoutPage({super.key});
  final controller = Get.put(OfficeFurnitureController());
  final RapydClientApi rapyd = RapydClientApiImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: rapyd.checkout(controller.totalPrice.value.toString()),
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
                        controller.clearCart();
                        Get.showSnackbar(GetSnackBar(
                          title: 'Success',
                          message: 'Success',
                        ));
                      } else if (url
                          .contains(snapshot.data!["cancel_checkout_url"])) {
                        Get.back(result: 'Canceled');
                        controller.clearCart();
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
