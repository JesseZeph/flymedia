import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flymedia_app/providers/payment_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/stripe_page.dart';
import 'package:flymedia_app/src/tier_listings/components/payment_methods.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/custom_back_button.dart';
import '../../utils/widgets/custom_text.dart';
import '../authentication/components/roundedbutton.dart';

class TierPaymentPage extends StatefulWidget {
  const TierPaymentPage(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.planId});
  final String image, name, price, planId;

  @override
  State<TierPaymentPage> createState() => _TierPaymentPageState();
}

class _TierPaymentPageState extends State<TierPaymentPage> {
  int? selectedMethod;
  List<String> names = ["Pay with Paypal", "Pay with Stripe"];
  List<String> iconPaths = [
    "assets/images/paypal.svg",
    "assets/images/stripe.svg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const CustomKarlaText(
          text: 'Choose payment method',
          weight: FontWeight.w700,
          size: 16,
          color: Colors.black,
        ),
        leading: const CustomBackButton(),
      ),
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing:
                context.watch<PaymentNotifier>().state == PaymentState.loading,
            child: Padding(
              padding: const EdgeInsets.all(16).r,
              child: SafeArea(
                  child: Column(
                children: [
                  SizedBox(width: Get.width.w, height: 20.h),
                  SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: SvgPicture.asset(widget.image))),
                  SizedBox(height: 10.h),
                  CustomKarlaText(
                    text: widget.name,
                    color: const Color(0xff5f5d5d),
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h),
                  RichText(
                      text: TextSpan(
                          text: '\$${widget.price}',
                          style: GoogleFonts.karla(
                              color: const Color(0xff0f1521),
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800),
                          children: [
                        TextSpan(
                            text: '/month',
                            style: GoogleFonts.karla(
                                color: const Color(0xff0f1521),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400))
                      ])),
                  SizedBox(height: 70.h),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => PaymentMethod(
                              isSelected: selectedMethod == index,
                              onTap: (_) {
                                setState(() {
                                  selectedMethod = index;
                                });
                              },
                              image: iconPaths[index],
                              name: names[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 50.h,
                              ),
                          itemCount: names.length)),
                  SizedBox(height: 20.h),
                  RoundedButtonWidget(
                      onTap: selectedMethod == 1
                          ? () {
                              context
                                  .read<PaymentNotifier>()
                                  .makepayment(plan: widget.planId)
                                  .then((value) {
                                if (value.isNotEmpty) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StripeWebView(url: value)));
                                }
                              });
                            }
                          : () {
                              Fluttertoast.showToast(
                                  msg: 'Select Stripe To Make payment');
                            },
                      title: 'Make Payment'),
                  SizedBox(height: 20.h),
                ],
              )),
            ),
          ),
          context.watch<PaymentNotifier>().state == PaymentState.loading
              ? const Center(child: AlertLoader(message: 'Please wait'))
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
