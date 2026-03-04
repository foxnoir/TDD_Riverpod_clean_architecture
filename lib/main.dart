import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_riverpod_clean_architecture/core/log/logger.dart';
import 'package:tdd_riverpod_clean_architecture/core/router/app_router.dart';

void main() {
  final container = ProviderContainer();
  final logger = container.read(appLoggerProvider);

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(
        UncontrolledProviderScope(
          container: container,
          child: const ProviderTrainingApp(),
        ),
      );
    },
    (Object error, StackTrace stack) {
      logger.info('Zone error: $error');
    },
  );
}

class ProviderTrainingApp extends ConsumerWidget {
  const ProviderTrainingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'TDD Riverpod',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
