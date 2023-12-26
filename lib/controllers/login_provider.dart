import 'package:flutter/material.dart';
import 'package:flymedia_app/services/helpers/auth_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

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

  Future<List<dynamic>> login(String model) async {
    _loader = !_loader;
    notifyListeners();
    List<dynamic> wasSuccessful = [false];
    await AuthHelper.login(model).then(
      (response) {
        wasSuccessful = response;
      },
    );
    _loader = !_loader;
    notifyListeners();
    return wasSuccessful;
  }

  Future<List<dynamic>> influencerSignin(String model) async {
    _loader = !_loader;
    notifyListeners();
    List<dynamic> wasSuccessful = [false];
    await AuthHelper.influencersLogin(model).then(
      (response) {
        wasSuccessful = response;
      },
    );
    _loader = !_loader;
    notifyListeners();
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

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.setBool('loggedIn', false);
    await prefs.setInt('selectedContainer', 3);
  }
}
