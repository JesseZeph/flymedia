import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/payment_provider.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/payment_success.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebView extends StatelessWidget {
  const StripeWebView(
      {Key? key,
      required this.url,
      this.paymentType = '',
      required this.influencerName,
      required this.price})
      : super(key: key);
  final String url;
  final String? paymentType, influencerName, price;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late final WebViewController controller;
    final readPaymentprovider = context.read<PaymentNotifier>();
    return Scaffold(
      body: SafeArea(
        child: context.watch<PaymentNotifier>().state == PaymentState.loading
            ? const Center(child: AlertLoader(message: 'Please wait'))
            : WebView(
                // onPageStarted: (String url) {},
                onPageFinished: (String url) {
                  log(url.toString());
                  if (url.contains('success')) {
                    // initiate confirmpayment for influencerPayment
                    if (paymentType == 'influencerPayment') {
                      readPaymentprovider.confirmCampaignPayment().then(
                        (state) {
                          if (state == PaymentState.loaded) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentSuccess(
                                        influencerName: influencerName ?? '',
                                        price: price ?? '',
                                      )),
                            );
                          }
                        },
                      );
                    } else {
                      // initiate confirmpayment for subscription
                      readPaymentprovider.confirmPayment().then((state) {
                        if (state == PaymentState.loaded) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentSuccess(
                                      influencerName: influencerName ?? '',
                                      price: price ?? '',
                                    )),
                          );
                        }
                      });
                    }
                  } else if (url.contains('cancel')) {
                    if (paymentType == 'influencerPayment') {
                      readPaymentprovider.confirmCampaignPayment().then(
                        (state) {
                          if (state == PaymentState.error) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CancelPage(),
                              ),
                            );
                          }
                        },
                      );
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

class CancelPage extends StatelessWidget {
  const CancelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 120.w),
              child: ImageWithTextWidget(
                assetImage: Image.asset(
                  'assets/images/error.png',
                ),
                headerText: 'Payment Received',
                subText:
                    'Your transaction wasn\'nt successful, please try again later',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
