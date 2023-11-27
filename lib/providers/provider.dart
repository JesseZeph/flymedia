import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckBoxStateNotifier extends StateNotifier<bool> {
  CheckBoxStateNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final checkBoxStateProvider =
    StateNotifierProvider<CheckBoxStateNotifier, bool>(
  (ref) => CheckBoxStateNotifier(),
);
