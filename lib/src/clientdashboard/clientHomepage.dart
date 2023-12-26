import 'dart:async';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flymedia_app/controllers/chat_provider.dart';
import 'package:flymedia_app/controllers/login_provider.dart';
import 'package:flymedia_app/services/helpers/applications_helper.dart';
import 'package:flymedia_app/src/clientdashboard/dashboardPages/campaign.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../../controllers/campaign_provider.dart';
import '../../route/route.dart';
import '../accountoption/view.dart';
import 'dashboardPages/help.dart';
import 'dashboardPages/messages.dart';
import 'dashboardPages/payment.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({
    super.key,
  });

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Campaign(),
    const ClientMessagePage(),
    const ClientHelp(),
    const Payment(),
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchData();
    validateToken();
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      context
          .read<ChatProvider>()
          .fetchUserMessages(context.read<LoginNotifier>().userId, "Client");
    });
  }

  fetchData() async {
    await context.read<LoginNotifier>().getPref().then((_) {
      context
          .read<CampaignsNotifier>()
          .getClientCampaigns(context.read<LoginNotifier>().userId);
      context
          .read<ChatProvider>()
          .fetchUserMessages(context.read<LoginNotifier>().userId, "Client");
    });
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('selectedContainer', 1);
    });
  }

  validateToken() async {
    await context.read<ApplicationsHelper>().validateToken().then((isValid) {
      if (!isValid) {
        context.read<LoginNotifier>().logout();
        pushToAndClearStack(context, const AccountOption());
        if (mounted) context.showError('Session Expired, log in.');
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          elevation: 10,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: AppColors.lightHintTextColor,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_note_add_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_note_add_filled),
                label: 'Campaigns'),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail_outline_rounded),
                activeIcon: Icon(Icons.mail),
                label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_help_circle_regular),
                activeIcon:
                    Icon(FluentSystemIcons.ic_fluent_help_circle_filled),
                label: 'Help'),
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card),
                activeIcon: Icon(Icons.credit_score),
                label: 'Payment'),
          ]),
    );
  }
}
