import 'package:flutter/material.dart';
import 'package:flymedia_app/providers/payment_provider.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/payment_success.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebView extends StatelessWidget {
  const StripeWebView({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    late final WebViewController controller;

    return Scaffold(
      body: SafeArea(
        child: context.watch<PaymentNotifier>().state == PaymentState.loading
            ? const Center(child: AlertLoader(message: 'Please wait'))
            : WebView(
                onPageStarted: (String url) {},
                onPageFinished: (String url) {
                  if (url.contains('success')) {
                    context
                        .read<PaymentNotifier>()
                        .confirmPayment()
                        .then((state) {
                      if (state == PaymentState.loaded) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentSuccess()),
                        );
                      }
                    });

                    // Check if the URL contains 'success' and initiate
                    // confirmInfluencerPayment
                    if (url.contains('success')) {
                      context
                          .read<PaymentNotifier>()
                          .confirmCampaignPayment()
                          .then((state) {
                        // Handle the state accordingly
                        if (state == PaymentState.loaded) {
                          // You can navigate or perform other actions
                        } else {
                          // Handle the failure state
                        }
                      });
                    }
                  }
                },
                zoomEnabled: true,
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controller = webViewController;
                },
                onWebResourceError: (WebResourceError error) {},
              ),
      ),
    );
  }
}
