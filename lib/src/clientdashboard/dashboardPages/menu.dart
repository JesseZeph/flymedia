import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/utils/widgets/subscription_info.dart';
import 'package:provider/provider.dart';

import '../../../providers/login_provider.dart';
import '../../../utils/modal.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : Scaffold(
            body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
            child: const SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubscriptionInfo(),
              ],
            )),
          ));
  }
}
