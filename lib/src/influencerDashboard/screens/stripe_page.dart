import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/providers/payment_provider.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/payment_success.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebView extends StatelessWidget {
  const StripeWebView({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    late final WebViewController controller;
    return Scaffold(
      body: SafeArea(
        child: context.watch<PaymentNotifier>().state == PaymentState.loading
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation(Colors.blue)))
            : WebView(
                onPageFinished: (url) {
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
                                builder: ((context) =>
                                    const PaymentSuccess())));
                      }
                    });
                  }
                },
                onPageStarted: (url) {
                  // if (url.contains('success')) {
                  //   context.read<LoginNotifier>().confirmPayment();
                  //   Navigator.pop(context);
                  // }
                },
                zoomEnabled: true,
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controller = webViewController;
                },
              ),
      ),
    );
  }
}
