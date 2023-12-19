import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/login_provider.dart';
import 'package:flymedia_app/controllers/signup_provider.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/auth_switch_button.dart';
import '../components/slidefadeswitcher.dart';
import 'sign_in/sign_in_widget.dart';
import 'sign_up/signup.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  bool _showSignin = true;

  @override
  void initState() {
    super.initState();
    savePage();
  }

  savePage() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('selectedContainer', 3);
    });
  }

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
                    child: _showSignin ? const SignInWidget() : const SignUp(),
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
