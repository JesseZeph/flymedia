import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/payment_provider.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/payment_success.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
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
                            context.showError('Payment not successful');
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
