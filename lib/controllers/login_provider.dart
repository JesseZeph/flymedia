import 'package:flutter/material.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/services/helpers/auth_helper.dart';
import 'package:flymedia_app/src/influencerDashboard/influencerHomepage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../src/clientdashboard/clientHomepage.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool _loader = false;
  bool _entrypoint = false;
  bool? _loggedIn = false;
  // int? _selectedContainer = 0;

  bool get obscureText => _obscureText;
  bool get loader => _loader;
  String _fullName = '';
  String get fullName => _fullName;
  String _userId = '';
  String get userId => _userId;
  bool get entrypoint => _entrypoint;
  bool get loggedIn => _loggedIn ?? false;
  // int get selectedContainer => _selectedContainer ?? 0;

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

  login(String model) {
    AuthHelper.login(model).then(
      (response) {
        if (response == true) {
          loader = false;
          Get.to(() => const ClientHomePage());
        } else {
          Get.snackbar(
            'Sign in failed',
            'Please check your details',
            colorText: Colors.white,
            backgroundColor: AppColors.errorColor,
            icon: const Icon(
              Icons.add_alert,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  influencerSignin(String model) {
    AuthHelper.influencersLogin(model).then(
      (response) {
        if (response == true) {
          loader = false;
          loggedIn = true;
          Get.to(() => const InfluencerHomePage());
        } else {
          Get.snackbar(
            'Sign in failed',
            'Please check your details',
            colorText: Colors.white,
            backgroundColor: AppColors.errorColor,
            icon: const Icon(
              Icons.add_alert,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Future<void> getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // selectedContainer = prefs.getInt('selectedContainer') ?? 0;
    // entrypoint = prefs.getBool('entrypoint') ?? false;
    _loggedIn = prefs.getBool('loggedIn') ?? false;
    _fullName = prefs.getString('fullname') ?? '';
    _userId = prefs.getString('userId') ?? '';
    notifyListeners();
    fullname = prefs.getString('fullname') ?? '';
    userUid = prefs.getString('uid') ?? '';
    profile = prefs.getString('profile') ?? '';
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.setBool('loggedIn', false);
    // await prefs.remove('token');
  }
}
