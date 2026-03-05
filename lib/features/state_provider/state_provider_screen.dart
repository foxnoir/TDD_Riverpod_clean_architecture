import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_riverpod_clean_architecture/features/state_provider/provider/counter_state_provider.dart';

class StateProviderScreen extends ConsumerStatefulWidget {
  const StateProviderScreen({super.key});

  @override
  ConsumerState<StateProviderScreen> createState() =>
      _StateProviderScreenState();
}

class _StateProviderScreenState extends ConsumerState<StateProviderScreen> {
  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(counterStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('State Provider Screen')),
      body: Center(
        child: Column(
          children: [
            Text('You have pushed the button this many times: $counter'),
            Text('Counter: $counter'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    ref.read(counterStateProvider.notifier).state++;
                  },
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    ref.read(counterStateProvider.notifier).state--;
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
