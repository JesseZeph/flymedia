import 'package:flymedia_app/providers/bottom_appbar_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavNotifier extends StateNotifier<NavStates> {
  NavNotifier() : super(const NavStates());

  void onIndexChange(int index) {
    state = state.copyWith(index: index);
  }
}

final navProvider =
    StateNotifierProvider<NavNotifier, NavStates>((ref) => NavNotifier());
