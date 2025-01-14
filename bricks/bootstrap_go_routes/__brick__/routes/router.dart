// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'index.dart';
import 'shell_branches.dart';

/// {@template app_router}
/// The root router for the app. Call [AppRouter.router] to get the router.
/// {@endtemplate}
class AppRouter {
  /// The root navigator key for the app. Use this to navigate from the root
  /// of the router (i.e. out of the bottom navigation bar).
  static final rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root_navigator');

  static final rootScaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'root_scaffold');

  /// The root router for the app. Set [debug] to true to enable debug logging
  /// diagnostics.
  static GoRouter router({bool debug = false}) => GoRouter(
        navigatorKey: rootNavigatorKey,
        debugLogDiagnostics: debug,
        initialLocation: AppShellBranch.values.first.path,
        routes: [
          /// StatefulShellRoute.indexedStack handles the stack of routes of
          /// the bottom navigation bar.
          StatefulShellRoute.indexedStack(
            parentNavigatorKey: rootNavigatorKey,
            branches: AppStatefulShellBranches.branches,
            builder: (_, routerState, child) {
              // TODO: Handle routing to the correct page based on the current state.
              // NOTE: Here, you might want to check if the user is authenticated and route to the correct page. By default, we're routing to the index page that handles the bottom navigation bar routing.
              return IndexNavigationPage(
                routerState: routerState,
                child: child,
              );
            },
          ),

          // TODO: Add root routes here. Root routes are the routes or pages that are outside of the bottom navigation bar shell. Typically authentication (sign up and sign in), splash, and onboarding pages.
          // GoRoute(
          //   parentNavigatorKey: rootNavigatorKey,
          //   path: SplashPage.path,
          //   builder: (context, state) => const SplashPage(),
          // ),
        ],
      );
}
