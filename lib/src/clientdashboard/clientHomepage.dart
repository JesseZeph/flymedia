import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flymedia_app/constants/app_constants.dart';
import 'package:flymedia_app/src/clientdashboard/dashboardPages/campaign.dart';

import '../../constants/colors.dart';
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
    Campaign(
      id: userUid,
    ),
    const Messages(),
    const ClientHelp(),
    const Payment(),
  ];

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
