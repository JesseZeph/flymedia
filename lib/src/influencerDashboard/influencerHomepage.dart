import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flymedia_app/providers/nav_notifier.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/campaignpage.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/messagespage.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/colors.dart';

class InfluencerHomePage extends ConsumerStatefulWidget {
  const InfluencerHomePage({super.key});

  @override
  ConsumerState<InfluencerHomePage> createState() => _InfluencerHomePage();
}

class _InfluencerHomePage extends ConsumerState<InfluencerHomePage> {
  static final List<Widget> _widgetOptions = <Widget>[
    const CampaignPage(),
    const MessagePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    var navIndex = ref.watch(navProvider);
    return Scaffold(
      body: Center(
        child: _widgetOptions[navIndex.index],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: navIndex.index,
          onTap: (value) {
            ref.read(navProvider.notifier).onIndexChange(value);
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
