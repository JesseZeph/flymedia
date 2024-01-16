import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/utils/widgets/custom_back_button.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';

class TierListingsPage extends StatefulWidget {
  const TierListingsPage({super.key});

  @override
  State<TierListingsPage> createState() => _TierListingsPageState();
}

class _TierListingsPageState extends State<TierListingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomKarlaText(
          text: 'Choose a plan',
          weight: FontWeight.w700,
          size: 16,
          color: Colors.black,
        ),
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
        child: SafeArea(
            child: ListView(
          children: const [],
        )),
      ),
    );
  }
}
