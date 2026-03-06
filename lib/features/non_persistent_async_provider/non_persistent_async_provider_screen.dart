import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_riverpod_clean_architecture/features/non_persistent_async_provider/counter_non_persistent_async_provider.dart';

class NonPersistentAsyncProvideScreen extends ConsumerStatefulWidget {
  const NonPersistentAsyncProvideScreen({super.key});

  @override
  ConsumerState<NonPersistentAsyncProvideScreen> createState() =>
      _NonPersistentAsyncProvideScreenState();
}

class _NonPersistentAsyncProvideScreenState
    extends ConsumerState<NonPersistentAsyncProvideScreen> {
  bool _waitForFreshLoad = true;
  bool _hasSeenReloading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .refresh(counterNonPersistentAsyncProvidr)
          .when(loading: () => null, data: (_) => null, error: (_, __) => null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final counterAsync = ref.watch(counterNonPersistentAsyncProvidr);

    if (counterAsync.isReloading || counterAsync.isLoading) {
      _hasSeenReloading = true;
    }
    if (_waitForFreshLoad &&
        _hasSeenReloading &&
        counterAsync.hasValue &&
        !counterAsync.isReloading &&
        !counterAsync.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _waitForFreshLoad = false);
      });
    }

    final showContent = !_waitForFreshLoad;

    return Scaffold(
      appBar: AppBar(title: const Text('Non Persistent Async Provider Screen')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            if (!showContent)
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
                  heroTag: 'counter_decrement',
                  onPressed: () {
                    ref
                        .read(counterNonPersistentAsyncProvidr.notifier)
                        .decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),

                FloatingActionButton(
                  heroTag: 'counter_increment',
                  onPressed: () {
                    ref
                        .read(counterNonPersistentAsyncProvidr.notifier)
                        .increment();
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'counter_reset',
                  onPressed: () {
                    ref.read(counterNonPersistentAsyncProvidr.notifier).reset();
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
