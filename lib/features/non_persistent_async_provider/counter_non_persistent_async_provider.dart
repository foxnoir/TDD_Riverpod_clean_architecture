import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final _random = Random();

/// Non-persistent: when no one watches (e.g. left screen), provider is disposed.
/// Opening the screen again triggers a fresh build → loading → data/error.
final counterNonPersistentAsyncProvider =
    AsyncNotifierProvider.autoDispose<CounterNonPersistentAsyncNotifier, int>(
  CounterNonPersistentAsyncNotifier.new,
);

class CounterNonPersistentAsyncNotifier extends AsyncNotifier<int> {
  @override
  FutureOr<int> build() async {
    final value = await Future.delayed(const Duration(seconds: 3), () => 0);
    if (_random.nextInt(10) < 4) {
      throw Exception('Fake async error (demo)');
    }
    return value;
  }

  void increment() => state = AsyncValue.data(state.value! + 1);
  void decrement() => state = AsyncValue.data(state.value! - 1);
  void reset() => state = const AsyncValue.data(0);
}
