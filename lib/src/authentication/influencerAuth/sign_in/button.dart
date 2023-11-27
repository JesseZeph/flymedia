import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/textstring.dart';
import '../../components/animated_button.dart';
import '../../components/roundedbutton.dart';

class InfluencerLoginButton extends ConsumerWidget {
  final VoidCallback onTap;
  const InfluencerLoginButton({
    super.key,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedButton(
      onTap: onTap,
      child: const RoundedButtonWidget(
        title: AppTexts.login,
      ),
    );
  }
}
