import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/models/chats/chat_model.dart';
import 'package:flymedia_app/route/route.dart';
import 'package:flymedia_app/src/authentication/clientAuth/authenticationview.dart';
import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/influencer_view.dart';
import 'package:flymedia_app/utils/widgets/chat_tile.dart';
import 'package:get/get.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

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
                    'Your payment of \$10,000 has been received, and will be paid to Lexy Chang immediately the contract is completed.',
              ),
            ),
            GestureDetector(
              onTap: () {
                // Get.to(() => ChatTile(model: chatModel, isClientView: true));
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: const RoundedButtonWidget(
                  title: 'Chat with Lexy Chang',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
