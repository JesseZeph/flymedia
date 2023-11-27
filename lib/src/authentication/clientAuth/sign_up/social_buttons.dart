import 'package:flutter/cupertino.dart';

import '../../../../constants/imageStrings.dart';
import '../../../../utils/widgets/social_auth_buttons.dart';

class SocialAuth extends StatelessWidget {
  const SocialAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppleGoogleButton(
          text: 'Join with Google',
          imagePath: AppImages.google,
          onTap: () {},
        ),
        AppleGoogleButton(
          text: 'Join with Apple',
          imagePath: AppImages.apple,
          onTap: () {},
        ),
      ],
    );
  }
}
