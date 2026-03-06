import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final _random = Random();

final counterAsyncProvider = AsyncNotifierProvider<CounterAsyncNotifier, int>(
  CounterAsyncNotifier.new,
);

class CounterAsyncNotifier extends AsyncNotifier<int> {
  @override
  FutureOr<int> build() async {
    final value = await Future.delayed(const Duration(seconds: 3), () => 0);

    // Fake error roughly every 2–3 times (ca. 40% chance) for demo/testing
    if (_random.nextInt(10) < 4) {
      throw Exception('Fake async error (demo)');
    }

    return value;
  }

  void increment() => state = AsyncValue.data(state.value! + 1);

  void decrement() => state = AsyncValue.data(state.value! - 1);

  void reset() => state = const AsyncValue.data(0);
}
