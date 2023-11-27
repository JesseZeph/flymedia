import 'package:flutter/material.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/resetPassword.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/resetSuccessful.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/verifyEmail.dart';
import 'package:flymedia_app/src/authentication/verification/useremailverification.dart';
import 'package:flymedia_app/src/authentication/verification/userverificationsuccess.dart';
import 'package:flymedia_app/src/authentication/verification/verifyemailaddress.dart';
import 'package:flymedia_app/src/clientdashboard/clientHomepage.dart';
import 'package:flymedia_app/src/clientdashboard/screens/applications.dart';
import 'package:flymedia_app/src/clientdashboard/screens/view_campaign.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/profile.dart';
import 'package:flymedia_app/src/influencerDashboard/influencerHomepage.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/campaignlisting.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/profile_edit.dart';

import '../src/accountoption/view.dart';
import '../src/authentication/clientAuth/authenticationview.dart';
import '../src/authentication/forgotpassword/forgotpassword.dart';
import '../src/clientdashboard/screens/campaignLive.dart';
import '../src/clientdashboard/screens/jobSpecification.dart';
import '../src/clientdashboard/screens/previewListing.dart';
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
    case '/resetSuccessful':
      return const ResetSuccessful();
    case '/clientDashboard':
      return const ClientVerificationOnboarding();
    case '/clientHomePage':
      return const ClientHomePage();
    case '/jobSpecification':
      return JobSpecification();

    case '/accountOption':
      return const AccountOption();

    //email verification
    case '/verification':
      return const VerifyEmailAccount();
    case '/userEmailVerification':
      return UserEmailVerification();
    case '/campaignLive':
      return const CampaignLive();
    case '/userVerificationSuccess':
      return const UserVerificationSuccessful();
    //done
    case '/previewListing':
      return const PreviewListing();
    case '/viewCampaign':
      return const ViewCampaign();
    case '/viewCampaignListing':
      return const ViewCampaignListing();
    case '/applications':
      return const Applications();

    case '/editProfile':
      return const EditProfile();
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
