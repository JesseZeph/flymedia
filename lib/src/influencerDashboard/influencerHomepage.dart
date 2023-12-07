import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flymedia_app/controllers/login_provider.dart';
import 'package:flymedia_app/controllers/profile_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/campaignpage.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/messagespage.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/profile.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';

class InfluencerHomePage extends StatefulWidget {
  const InfluencerHomePage({super.key});

  @override
  State<InfluencerHomePage> createState() => _InfluencerHomePage();
}

class _InfluencerHomePage extends State<InfluencerHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const CampaignPage(),
    const MessagePage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  loadInfo() async {
    await context.read<LoginNotifier>().getPref().then((_) => context
        .read<ProfileProvider>()
        .getProfile(context.read<LoginNotifier>().userId));
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
                icon: Icon(FluentSystemIcons.ic_fluent_person_accounts_regular),
                activeIcon:
                    Icon(FluentSystemIcons.ic_fluent_person_accounts_filled),
                label: 'Profile'),
          ]),
    );
  }
}
