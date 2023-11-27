import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//NOTE: provider clears on hot reload, butttttt production doesn't HOT RELOAD!

final testProviderProvider = StateProvider<String?>((ref) {
  return null;
});

class TestPage extends HookConsumerWidget {
  const TestPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final u = ref.watch(testProviderProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(testProviderProvider.notifier).state = 'Jesse';
        },
      ),
      body: Center(
        child: Text(
          u ?? 'NOTHING DEY HERE',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
