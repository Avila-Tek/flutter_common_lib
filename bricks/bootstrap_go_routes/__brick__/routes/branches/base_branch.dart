import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// {@template app_shell_branch}
/// Interface for each branch of the app.
/// {@endtemplate}
abstract class AppBaseShellBranch {
  /// {@macro app_shell_branch}
  const AppBaseShellBranch({
    required this.navigatorKey,
    required this.branch,
    required this.routes,
  });

  /// The navigator key for this branch.
  final GlobalKey<NavigatorState> navigatorKey;

  /// The [StatefulShellBranch] instance for this branch.
  final StatefulShellBranch branch;

  /// The routes of this branch.
  final List<RouteBase> routes;

  /// The root routes of this module
  List<RouteBase> rootRoutes(GlobalKey<NavigatorState> rootNavigatorKey);
}
