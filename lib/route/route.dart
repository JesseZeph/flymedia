import 'package:flutter/material.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/resetPassword.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/verifyEmail.dart';
import 'package:flymedia_app/src/clientdashboard/clientHomepage.dart';
import 'package:flymedia_app/src/clientdashboard/screens/applications.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/profile.dart';
import 'package:flymedia_app/src/influencerDashboard/influencerHomepage.dart';

import '../src/accountoption/view.dart';
import '../src/authentication/clientAuth/authenticationview.dart';
import '../src/authentication/forgotpassword/forgotpassword.dart';
import '../src/clientdashboard/screens/verificationScreen.dart';
import '../src/onboardingscreen/onboarding.dart';
import '../src/onboardingscreen/onboardpages/fourthpage.dart';
import '../src/onboardingscreen/onboardpages/secondpage.dart';
import '../src/onboardingscreen/onboardpages/thirdpage.dart';

Widget _getPage(String routeName) {
  switch (routeName) {
    case '/':
      return const SplashScreen();
    case '/accountOptions':
      return const AccountOption();
    case '/secondOnboard':
      return const SecondOnboard();
    case '/thirdOnboard':
      return const ThirdOnboard();
    case '/fourthOnboard':
      return const FourthOnboard();
    case '/signin':
      return const AuthenticationView();
    case '/passwordReset':
      return const ForgotPassword();
    case '/resetPassword':
      return const ResetPassword();
    case '/checkEmail':
      return const CheckEmail();
    case '/verifyEmail':
      return VerifyEmail();
    case '/clientDashboard':
      return const ClientVerificationOnboarding();
    case '/clientHomePage':
      return const ClientHomePage();
    // Uncomment the lines below if 'PreviewListing' is used.
    // case '/previewListing':
    //   return const PreviewListing();
    case '/viewCampaign':
    //   return const ViewCampaign(id: '',);
    // case '/viewCampaignListing':
    //   return const ViewCampaignListing(id: '',);
    case '/applications':
      return const Applications();
    // case '/editProfile':
    //   return const EditProfile();
    case '/influencerProfile':
      return const ProfilePage();
    case '/influencerHomepage':
      return const InfluencerHomePage();
    default:
      return const SplashScreen();
  }
}

void navigateToPage(BuildContext context, String routeName) {
  final page = _getPage(routeName);
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

void pushToAndClearStack(BuildContext context, Widget page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (route) => false);
}
