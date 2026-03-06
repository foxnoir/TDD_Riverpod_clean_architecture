import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final _random = Random();

final counterPersistentAsyncProvide =
    AsyncNotifierProvider<CounterAsyncNotifier, int>(CounterAsyncNotifier.new);

/// Set to true when "Refresh app" was triggered; async screen shows loading until reload is done.
final persistentAsyncProvideRefreshRequestedProvider = StateProvider<bool>(
  (ref) => false,
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
