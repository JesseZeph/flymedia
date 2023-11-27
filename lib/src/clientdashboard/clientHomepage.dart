import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flymedia_app/providers/nav_notifier.dart';
import 'package:flymedia_app/src/clientdashboard/dashboardPages/campaign.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/colors.dart';
import 'dashboardPages/help.dart';
import 'dashboardPages/messages.dart';
import 'dashboardPages/payment.dart';

class ClientHomePage extends ConsumerStatefulWidget {
  const ClientHomePage({super.key});

  @override
  ConsumerState<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends ConsumerState<ClientHomePage> {
  static final List<Widget> _widgetOptions = <Widget>[
    const Campaign(),
    const Messages(),
    const ClientHelp(),
    const Payment(),
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
