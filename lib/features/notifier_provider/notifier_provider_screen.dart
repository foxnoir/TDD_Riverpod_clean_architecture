import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_riverpod_clean_architecture/features/notifier_provider/counter_notifier_provider.dart';
import 'package:tdd_riverpod_clean_architecture/features/state_provider/counter_state_provider.dart';

class NotifierProviderScreen extends ConsumerStatefulWidget {
  const NotifierProviderScreen({super.key});

  @override
  ConsumerState<NotifierProviderScreen> createState() =>
      _NotifierProviderScreenState();
}

class _NotifierProviderScreenState
    extends ConsumerState<NotifierProviderScreen> {
  @override
  Widget build(BuildContext context) {
    // only use in build method
    final counter = ref.watch(counterNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifier Provider Screen')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text('You have pushed the button this many times: $counter'),
            const SizedBox(height: 8),
            Text(
              'Counter: $counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'counter_increment',
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).increment();
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'counter_decrement',
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).decrement();
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
