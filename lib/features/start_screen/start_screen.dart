import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tdd_riverpod_clean_architecture/core/router/app_router_names.dart';
import 'package:tdd_riverpod_clean_architecture/features/persistent_async_provider/counter_persistent_async_provider.dart';
import 'package:tdd_riverpod_clean_architecture/features/notifier_provider/counter_notifier_provider.dart';
import 'package:tdd_riverpod_clean_architecture/features/start_screen/start_screen_provider.dart';
import 'package:tdd_riverpod_clean_architecture/features/state_provider/counter_state_provider.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  Future<void> _refreshApp() async {
    final notifier = ref.read(startScreenProvider.notifier);
    if (notifier.state) return;

    notifier.state = true;

    ref
      ..invalidate(counterStateProvider)
      ..invalidate(counterNotifierProvider)
      ..invalidate(counterPersistentAsyncProvider);
    _useAsyncValue<int>(ref.refresh(counterPersistentAsyncProvider));
    ref.read(persistentAsyncProvideRefreshRequestedProvider.notifier).state =
        true;

    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    context.go(AppRouteNames.startScreenPath);
    notifier.state = false;
  }

  static void _useAsyncValue<T>(Object value) {
    if (value is AsyncValue<T>) {
      value.when(
        loading: () => null,
        data: (_) => null,
        error: (_, __) => null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const buttonHeight = 48.0;
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
                    _menuButton(
                      height: buttonHeight,
                      label: 'State Provider',
                      onPressed: isResetting
                          ? null
                          : () => context.pushNamed(
                              AppRouteNames.stateProviderScreen,
                            ),
                    ),
                    const SizedBox(height: 16),
                    _menuButton(
                      height: buttonHeight,
                      label: 'Notifier Provider',
                      onPressed: isResetting
                          ? null
                          : () => context.pushNamed(
                              AppRouteNames.notifierProviderScreen,
                            ),
                    ),
                    const SizedBox(height: 16),
                    _menuButton(
                      height: buttonHeight,
                      label: 'Persistent Async Provider',
                      onPressed: isResetting
                          ? null
                          : () => context.pushNamed(
                              AppRouteNames.persistentAsyncProvideScreen,
                            ),
                    ),
                    const SizedBox(height: 16),
                    _menuButton(
                      height: buttonHeight,
                      label: 'Placeholder 2',
                      onPressed: isResetting ? null : () {},
                    ),
                    const SizedBox(height: 16),
                    _menuButton(
                      height: buttonHeight,
                      label: 'Placeholder 3',
                      onPressed: isResetting ? null : () {},
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: OutlinedButton.icon(
                        onPressed: isResetting ? null : _refreshApp,
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

  Widget _menuButton({
    required double height,
    required String label,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: FilledButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
