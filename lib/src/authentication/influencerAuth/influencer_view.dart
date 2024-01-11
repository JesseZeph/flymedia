import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/login_provider.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/sign_in/sign_in_widget.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/sign_up/signup.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../controllers/signup_provider.dart';
import '../../../utils/widgets/alert_loader.dart';
import '../components/auth_switch_button.dart';
import '../components/slidefadeswitcher.dart';

class InfluencerAuthView extends StatefulWidget {
  const InfluencerAuthView({Key? key}) : super(key: key);

  @override
  State<InfluencerAuthView> createState() => _InfluencerAuthViewState();
}

class _InfluencerAuthViewState extends State<InfluencerAuthView> {
  bool _showSignin = true;
  @override
  Widget build(BuildContext context) {
    var loading = context.watch<SignUpNotifier>().loader ||
        context.watch<LoginNotifier>().loader;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: LoadingOverlay(
        isLoading: loading,
        progressIndicator: AlertLoader(
            message: _showSignin ? "Signing you in" : "Signing you up"),
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: SlideFadeSwitcher(
                    child: _showSignin
                        ? const InfluencerSignIn()
                        : const InfluencerSignUp(),
                  ),
                ),
                AuthSwitchButton(
                  showSignIn: _showSignin,
                  onTap: () {
                    setState(() {
                      _showSignin = !_showSignin;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
