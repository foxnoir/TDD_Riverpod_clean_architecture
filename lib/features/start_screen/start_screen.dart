import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tdd_riverpod_clean_architecture/core/router/app_router_names.dart';
import 'package:tdd_riverpod_clean_architecture/features/async_provider/counter_async_provider.dart';
import 'package:tdd_riverpod_clean_architecture/features/notifier_provider/counter_notifier_provider.dart';
import 'package:tdd_riverpod_clean_architecture/features/start_screen/start_screen_provider.dart';
import 'package:tdd_riverpod_clean_architecture/features/state_provider/counter_state_provider.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  Future<void> _refreshApp({required bool isResetting}) async {
    if (isResetting) return;
    setState(() => ref.read(startScreenProvider.notifier).state = true);

    ref
      ..invalidate(counterStateProvider)
      ..invalidate(counterNotifierProvider)
      ..invalidate(counterAsyncProvider)
      ..refresh(
        counterAsyncProvider,
      ).when(loading: () => null, data: (_) => null, error: (_, __) => null);

    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    context.go(AppRouteNames.startScreenPath);
    setState(() => ref.read(startScreenProvider.notifier).state = false);
  }

  @override
  Widget build(BuildContext context) {
    const buttonHeight = 48.0;
    // only use in build method
    final isResetting = ref.watch(startScreenProvider);

    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 180),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: FilledButton(
                        onPressed: isResetting
                            ? null
                            : () => context.pushNamed(
                                AppRouteNames.stateProviderScreen,
                              ),
                        child: const Text('State Provider'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: FilledButton(
                        onPressed: isResetting
                            ? null
                            : () => context.pushNamed(
                                AppRouteNames.notifierProviderScreen,
                              ),
                        child: const Text('Notifier Provider'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: FilledButton(
                        onPressed: isResetting
                            ? null
                            : () => context.pushNamed(
                                AppRouteNames.asyncProviderScreen,
                              ),
                        child: const Text('Async Provider'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: FilledButton(
                        onPressed: isResetting ? null : () {},
                        child: const Text('Placeholder 2'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: FilledButton(
                        onPressed: isResetting ? null : () {},
                        child: const Text('Placeholder 3'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: OutlinedButton.icon(
                        onPressed: isResetting
                            ? null
                            : () => _refreshApp(isResetting: isResetting),
                        icon: const Icon(Icons.refresh, size: 20),
                        label: const Text('Refresh app'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isResetting)
          const ColoredBox(
            color: Colors.black26,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
