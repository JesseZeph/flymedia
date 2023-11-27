import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../clientdashboard/dashboardPages/campaign.dart';
import '../clientdashboard/dashboardPages/help.dart';
import '../clientdashboard/dashboardPages/messages.dart';
import '../clientdashboard/dashboardPages/payment.dart';

final selectedContainerProvider = StateProvider<int?>((ref) => null);
final buttonTextProvider = Provider<String>((ref) {
  final selectedContainer = ref.watch(selectedContainerProvider);
  if (selectedContainer == null) {
    return '';
  } else if (selectedContainer == 1) {
    return 'Join as a Client';
  } else {
    return 'Join as an Influencer';
  }
});

// Provider to manage the visibility of the button
final buttonVisibleProvider = Provider<bool>((ref) {
  final buttonVisibility = ref.watch(selectedContainerProvider);
  return buttonVisibility != null;
});

//tabbar

final selectedTabProvider = StateProvider<int>((ref) => 1);
final mainWrapperPagesProvider = Provider<List<Widget>>((ref) {
  return [
    const Campaign(),
    const Messages(),
    const ClientHelp(),
    const Payment(),
  ];
});
