import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_riverpod_clean_architecture/features/persistent_async_provider/counter_persistent_async_provider.dart';

class PersistentAsyncProvideScreen extends ConsumerStatefulWidget {
  const PersistentAsyncProvideScreen({super.key});

  @override
  ConsumerState<PersistentAsyncProvideScreen> createState() =>
      _PersistentAsyncProvideScreenState();
}

class _PersistentAsyncProvideScreenState
    extends ConsumerState<PersistentAsyncProvideScreen> {
  @override
  Widget build(BuildContext context) {
    final counterAsync = ref.watch(counterPersistentAsyncProvider);
    final refreshRequested = ref.watch(
      persistentAsyncProvideRefreshRequestedProvider,
    );

    final stable =
        (counterAsync.hasValue || counterAsync.hasError) &&
        !counterAsync.isReloading &&
        !counterAsync.isLoading;
    final showLoadingFromRefresh = refreshRequested && !stable;

    if (refreshRequested && stable) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref
                  .read(persistentAsyncProvideRefreshRequestedProvider.notifier)
                  .state =
              false;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Persistent Async Provider Screen')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            if (showLoadingFromRefresh)
              const Center(child: CircularProgressIndicator())
            else
              counterAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                data: (data) => counterAsync.isReloading
                    ? const Center(child: CircularProgressIndicator())
                    : Text('You have pushed the button this many times: $data'),
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
                  heroTag: 'async_decrement',
                  onPressed: () => ref
                      .read(counterPersistentAsyncProvider.notifier)
                      .decrement(),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'async_increment',
                  onPressed: () => ref
                      .read(counterPersistentAsyncProvider.notifier)
                      .increment(),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'async_reset',
                  onPressed: () =>
                      ref.read(counterPersistentAsyncProvider.notifier).reset(),
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
