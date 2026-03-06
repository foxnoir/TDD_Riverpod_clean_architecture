import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tdd_riverpod_clean_architecture/core/router/app_router_names.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () =>
                  context.pushNamed(AppRouteNames.stateProviderScreen),
              child: const Text('State Provider'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () =>
                  context.pushNamed(AppRouteNames.notifierProviderScreen),
              child: const Text('Notifier Provider'),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: () {}, child: const Text('Placeholder 2')),
            const SizedBox(height: 16),
            FilledButton(onPressed: () {}, child: const Text('Placeholder 3')),
          ],
        ),
      ),
    );
  }
}
