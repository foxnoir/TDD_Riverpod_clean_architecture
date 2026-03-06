import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tdd_riverpod_clean_architecture/core/router/app_router_names.dart';
import 'package:tdd_riverpod_clean_architecture/features/persistent_async_provider/async_provider_screen.dart';
import 'package:tdd_riverpod_clean_architecture/features/notifier_provider/notifier_provider_screen.dart';
import 'package:tdd_riverpod_clean_architecture/features/start_screen/start_screen.dart';
import 'package:tdd_riverpod_clean_architecture/features/state_provider/state_provider_screen.dart';

/// GoRouter as Riverpod provider – one instance per app.
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: AppRouteNames.startScreenPath,
    routes: [
      GoRoute(
        path: AppRouteNames.startScreenPath,
        name: AppRouteNames.startScreen,
        builder: (context, state) => const StartScreen(),
        routes: [
          GoRoute(
            path: AppRouteNames.stateProviderScreenPath,
            name: AppRouteNames.stateProviderScreen,
            builder: (context, state) => const StateProviderScreen(),
          ),
          GoRoute(
            path: AppRouteNames.notifierProviderScreenPath,
            name: AppRouteNames.notifierProviderScreen,
            builder: (context, state) => const NotifierProviderScreen(),
          ),
          GoRoute(
            path: AppRouteNames.asyncProviderScreenPath,
            name: AppRouteNames.asyncProviderScreen,
            builder: (context, state) => const AsyncProviderScreen(),
          ),
        ],
      ),
    ],
  );
});

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
