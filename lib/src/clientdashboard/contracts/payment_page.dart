import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/providers/payment_provider.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/stripe_page.dart';
import 'package:flymedia_app/src/tier_listings/components/payment_methods.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/global_variables.dart';
import 'package:flymedia_app/utils/mixins/pin_mixin.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:flymedia_app/utils/widgets/custom_back_button.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CampaignPayment extends StatefulWidget {
  const CampaignPayment({
    super.key,
    required this.imageUrl,
    required this.influencerName,
    required this.amount,
    required this.title,
    required this.campaignId,
  });
  final String imageUrl, campaignId, influencerName, amount, title;

  @override
  State<CampaignPayment> createState() => _CampaignPaymentState();
}

class _CampaignPaymentState extends State<CampaignPayment> with PinMixin {
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
              color: Colors.black),
          leading: const CustomBackButton()),
      body: AbsorbPointer(
        absorbing:
            context.watch<PaymentNotifier>().state == PaymentState.loading,
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(16).r,
                child: SafeArea(
                    child: Column(children: [
                  SizedBox(
                    width: Get.width.w,
                    height: 20.h,
                  ),
                  SizedBox(
                      child: CircleAvatar(
                          radius: 35.sp,
                          backgroundColor: AppColors.mainColor,
                          backgroundImage: NetworkImage(widget.imageUrl)
                          // / Your image asset
                          )),
                  SizedBox(height: 10.h),
                  CustomKarlaText(
                      text: widget.title,
                      color: const Color(0xff5f5d5d),
                      size: 16,
                      weight: FontWeight.w500),
                  SizedBox(height: 10.h),
                  Text('\$${widget.amount.formatComma()}',
                      style: GoogleFonts.karla(
                          color: const Color(0xff0f1521),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800)),
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
                  AnimatedButton(
                    onTap: () async {
                      if (selectedMethod == 0) {
                        payWithPaypal();
                      } else {
                        payWithStripe();
                      }
                    },
                    child: const RoundedButtonWidget(
                      title: 'Make Payment',
                    ),
                  ),
                  SizedBox(height: 20.h),
                ]))),
            context.watch<PaymentNotifier>().state == PaymentState.loading
                ? const AlertLoader(message: 'Please Wait')
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  payWithStripe() async {
    if (await repository.isPinSet() && context.mounted) {
      var pinIsVerified = await verifyPin(context);

      if (pinIsVerified && context.mounted) {
        context
            .read<PaymentNotifier>()
            .influencerPayment(
                campaignFee: widget.amount, campaignId: widget.campaignId)
            .then((value) async {
          if (value.isNotEmpty) {
            var successful = await Navigator.push<bool?>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StripeWebView(
                      url: value,
                      paymentType: 'influencerPayment',
                      influencerName: widget.influencerName,
                      price: widget.amount,
                    ),
                  ),
                ) ??
                false;
            if (context.mounted) {
              Navigator.pop(context, successful);
            }
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        context.showError('Incorrect pin entered.');
      }
    } else {
      setupPin(context);
    }
  }

  payWithPaypal() {
    context.showSuccess('Not available, coming soon.');
  }
}
