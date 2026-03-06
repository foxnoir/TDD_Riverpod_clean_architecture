import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_riverpod_clean_architecture/features/non_persistent_async_provider/counter_non_persistent_async_provider.dart';

class NonPersistentAsyncProviderScreen extends ConsumerWidget {
  const NonPersistentAsyncProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterAsync = ref.watch(counterNonPersistentAsyncProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Non Persistent Async Provider Screen'),
      ),
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
                  heroTag: 'non_persistent_decrement',
                  onPressed: () => ref
                      .read(counterNonPersistentAsyncProvider.notifier)
                      .decrement(),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'non_persistent_increment',
                  onPressed: () => ref
                      .read(counterNonPersistentAsyncProvider.notifier)
                      .increment(),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'non_persistent_reset',
                  onPressed: () => ref
                      .read(counterNonPersistentAsyncProvider.notifier)
                      .reset(),
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
