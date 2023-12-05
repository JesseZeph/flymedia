import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:provider/provider.dart';

import '../../../controllers/login_provider.dart';
import '../../../utils/modal.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : Scaffold(
            body: Center(
              child: Container(
                width: 200.w,
                height: 200.h,
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppColors.mainColor, width: 2.0),
                    right: BorderSide(color: AppColors.mainColor, width: 2.0),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          );
  }
}
