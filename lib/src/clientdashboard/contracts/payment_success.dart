import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess(
      {Key? key, required this.price, required this.influencerName})
      : super(key: key);
  final String price, influencerName;

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
                  'assets/images/tick.png',
                ),
                headerText: 'Payment Received',
                subText:
                    'Your payment of \$$price has been received, and will be paid to $influencerName immediately the contract is completed.',
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     // Get.to(() => ChatTile(model: chatModel, isClientView: true));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 30.h),
            //     child: RoundedButtonWidget(
            //       title: 'Chat with $influencerName',
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
