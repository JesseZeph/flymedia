import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flymedia_app/controllers/login_provider.dart';
import 'package:flymedia_app/controllers/profile_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/campaignpage.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/messagespage.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/profile.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../route/route.dart';
import '../../services/helpers/applications_helper.dart';
import '../accountoption/view.dart';

class InfluencerHomePage extends StatefulWidget {
  const InfluencerHomePage({super.key});

  @override
  State<InfluencerHomePage> createState() => _InfluencerHomePage();
}

class _InfluencerHomePage extends State<InfluencerHomePage> {
  int _selectedIndex = 0;

  var pages = <Widget>[
    const CampaignPage(),
    const MessagePage(),
    // const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    loadInfo();
    validateToken();
  }

  loadInfo() async {
    await context.read<LoginNotifier>().getPref().then((_) => context
        .read<ProfileProvider>()
        .getProfile(context.read<LoginNotifier>().userId));
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
  Widget build(BuildContext context) {
    var profile = context.watch<ProfileProvider>().userProfile;
    pages.add(ProfilePage(
      userProfile: profile,
    ));
    return Scaffold(
      body: Center(
        child: pages[_selectedIndex],
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
