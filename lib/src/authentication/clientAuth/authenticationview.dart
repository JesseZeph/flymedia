import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
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
