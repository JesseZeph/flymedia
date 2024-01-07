import 'package:flutter/cupertino.dart';
import 'package:flymedia_app/controllers/login_provider.dart';
import 'package:flymedia_app/controllers/signup_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/imageStrings.dart';
import '../../../../utils/widgets/social_auth_buttons.dart';

class SocialAuth extends StatefulWidget {
  const SocialAuth(
      {super.key, required this.isSignUp, required this.userIsClient});
  final bool isSignUp, userIsClient;

  @override
  State<SocialAuth> createState() => _SocialAuthState();
}

class _SocialAuthState extends State<SocialAuth> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppleGoogleButton(
          text: 'Join with Google',
          imagePath: AppImages.google,
          onTap: () {
            if (widget.isSignUp) {
              context
                  .read<SignUpNotifier>()
                  .signUpWithGoogle(context, widget.userIsClient);
            } else {
              context
                  .read<LoginNotifier>()
                  .signInWithGoogle(context, widget.userIsClient);
            }
          },
        ),
        AppleGoogleButton(
          text: 'Join with Apple',
          imagePath: AppImages.apple,
          onTap: () {
            if (widget.isSignUp) {
              context
                  .read<SignUpNotifier>()
                  .signUpWithApple(context, widget.userIsClient);
            } else {
              context
                  .read<LoginNotifier>()
                  .signInWithApple(context, widget.userIsClient);
            }
          },
        ),
      ],
    );
  }
}
