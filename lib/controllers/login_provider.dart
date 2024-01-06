import 'package:flutter/material.dart';
import 'package:flymedia_app/services/helpers/auth_helper.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../models/requests/auth/influencer_login_model.dart';
import '../models/requests/auth/login_model.dart';
import '../src/authentication/clientAuth/clientverification/useremailverification.dart';
import '../src/authentication/influencerAuth/influencerverification/useremailverification.dart';
import '../src/clientdashboard/clientHomepage.dart';
import '../src/clientdashboard/screens/verificationScreen.dart';
import '../src/influencerDashboard/influencerHomepage.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool _loader = false;
  bool _entrypoint = false;
  bool? _loggedIn = false;

  bool get obscureText => _obscureText;
  bool get loader => _loader;
  String _fullName = '';
  String get fullName => _fullName;
  String _userId = '';
  String get userId => _userId;
  bool get entrypoint => _entrypoint;
  bool get loggedIn => _loggedIn ?? false;
  String get email => _email;
  String _email = '';

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  set loader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  // set selectedContainer(int newSelectedContainer) {
  //   _selectedContainer = newSelectedContainer;
  //   notifyListeners();
  // }

  Future<List<dynamic>> login(String model, {bool notSocialAuth = true}) async {
    if (notSocialAuth) {
      _loader = !_loader;
      notifyListeners();
    }
    List<dynamic> wasSuccessful = [false];
    await AuthHelper.login(model).then(
      (response) {
        wasSuccessful = response;
      },
    );
    if (notSocialAuth) {
      _loader = !_loader;
      notifyListeners();
    }
    return wasSuccessful;
  }

  Future<List<dynamic>> influencerSignin(String model,
      {bool notSocialAuth = true}) async {
    if (notSocialAuth) {
      _loader = !_loader;
      notifyListeners();
    }
    List<dynamic> wasSuccessful = [false];
    await AuthHelper.influencersLogin(model).then(
      (response) {
        wasSuccessful = response;
      },
    );
    if (notSocialAuth) {
      _loader = !_loader;
      notifyListeners();
    }
    return wasSuccessful;
  }

  Future<void> getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _loggedIn = prefs.getBool('loggedIn') ?? false;
    _fullName = prefs.getString('fullname') ?? '';
    _userId = prefs.getString('userId') ?? '';
    _email = prefs.getString('email') ?? '';
    notifyListeners();
    fullname = prefs.getString('fullname') ?? '';
    userUid = prefs.getString('uid') ?? '';
  }

  signInWithGoogle(BuildContext context, bool isClient) async {
    _loader = !_loader;
    notifyListeners();
    const List<String> scopes = <String>[
      'email',
    ];

    var googleSignIn = GoogleSignIn(
      scopes: scopes,
    );

    try {
      var userData = await googleSignIn.signIn();
      if (userData != null) {
        if (isClient) {
          LoginModel model = LoginModel(
              email: userData.email, password: userData.id, userType: 'Client');
          String newModel = loginModelToJson(model);
          await login(newModel, notSocialAuth: false).then((success) async {
            if (success.first) {
              var prefs = await SharedPreferences.getInstance();
              prefs.setString('email', model.email);
              if (!success[1]) {
                Get.offAll(() => const UserEmailVerification());
              } else {
                Get.offAll(() => success.last
                    ? const ClientHomePage()
                    : const ClientVerificationOnboarding());
              }
            } else {
              context.showError(success.last);
            }
          });
        } else {
          InfluencerLoginModel model = InfluencerLoginModel(
              email: userData.email,
              password: userData.id,
              userType: "Influencer");
          String newModel = influencerLoginModelToJson(model);
          await influencerSignin(newModel, notSocialAuth: false)
              .then((success) async {
            if (success.first) {
              var prefs = await SharedPreferences.getInstance();
              prefs.setString('email', model.email);
              Get.offAll(() => success.last
                  ? const InfluencerHomePage()
                  : const InfluencerEmailVerification());
            } else {
              context.showError(success.last);
            }
          });
        }
      }
    } catch (e, s) {
      debugPrint("=======> error with google sign in: $e");
      debugPrintStack(stackTrace: s);
      context.showError('Could not authenticate');
    }

    _loader = !_loader;
    notifyListeners();
  }

  signInWIthApple(BuildContext context, bool isClient) async {
    _loader = !_loader;
    notifyListeners();
    const List<String> scopes = <String>[
      'email',
    ];

    var googleSignIn = GoogleSignIn(
      scopes: scopes,
    );

    try {
      var userData = await googleSignIn.signIn();
      if (userData != null) {
        if (isClient) {
          LoginModel model = LoginModel(
              email: userData.email, password: userData.id, userType: 'Client');
          String newModel = loginModelToJson(model);
          await login(newModel, notSocialAuth: false).then((success) async {
            if (success.first) {
              var prefs = await SharedPreferences.getInstance();
              prefs.setString('email', model.email);
              if (!success[1]) {
                Get.offAll(() => const UserEmailVerification());
              } else {
                Get.offAll(() => success.last
                    ? const ClientHomePage()
                    : const ClientVerificationOnboarding());
              }
            } else {
              context.showError(success.last);
            }
          });
        } else {
          InfluencerLoginModel model = InfluencerLoginModel(
              email: userData.email,
              password: userData.id,
              userType: "Influencer");
          String newModel = influencerLoginModelToJson(model);
          await influencerSignin(newModel, notSocialAuth: false)
              .then((success) async {
            if (success.first) {
              var prefs = await SharedPreferences.getInstance();
              prefs.setString('email', model.email);
              Get.offAll(() => success.last
                  ? const InfluencerHomePage()
                  : const InfluencerEmailVerification());
            } else {
              context.showError(success.last);
            }
          });
        }
      }
    } catch (e, s) {
      debugPrint("=======> error with google sign in: $e");
      debugPrintStack(stackTrace: s);
      context.showError('Could not authenticate');
    }

    _loader = !_loader;
    notifyListeners();
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var googleSignIn = GoogleSignIn();
    await prefs.clear();
    await prefs.setBool('loggedIn', false);
    await prefs.setInt('selectedContainer', 3);
    googleSignIn.signOut();
  }
}
