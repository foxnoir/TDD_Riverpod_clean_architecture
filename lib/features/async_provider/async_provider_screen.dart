import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_riverpod_clean_architecture/features/async_provider/counter_async_provider.dart';

class AsyncProviderScreen extends ConsumerStatefulWidget {
  const AsyncProviderScreen({super.key});

  @override
  ConsumerState<AsyncProviderScreen> createState() =>
      _AsyncProviderScreenState();
}

class _AsyncProviderScreenState extends ConsumerState<AsyncProviderScreen> {
  @override
  Widget build(BuildContext context) {
    // only use in build method
    final counterAsync = ref.watch(counterAsyncProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Async Provider Screen')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            counterAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (data) => counterAsync.isReloading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      'You have pushed the button this many times: $data',
                    ),
              error: (error, stack) => counterAsync.isReloading
                  ? const Center(child: CircularProgressIndicator())
                  : Text('Error: $error'),
            ),

            const SizedBox(height: 8),
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'counter_decrement',
                  onPressed: () {
                    ref.read(counterAsyncProvider.notifier).decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),

                FloatingActionButton(
                  heroTag: 'counter_increment',
                  onPressed: () {
                    ref.read(counterAsyncProvider.notifier).increment();
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'counter_reset',
                  onPressed: () {
                    ref.read(counterAsyncProvider.notifier).reset();
                  },
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
