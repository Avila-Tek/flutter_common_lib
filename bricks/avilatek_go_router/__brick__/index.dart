// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:{{{packageName}}}/routes/shell_branches.dart';
import 'package:{{{packageName}}}/router.dart';

/// {@template index_page}
/// The index page of the app. This page is responsible for displaying the
/// scaffold with the bottom navigation bar.
/// {@endtemplate}
class IndexNavigationPage extends StatelessWidget {
  /// {@macro index_page}
  const IndexNavigationPage({
    required this.child,
    required this.routerState,
    this.scaffoldKey,
    super.key,
  });

  final StatefulNavigationShell child;
  final GoRouterState routerState;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppRouter.rootScaffoldKey,
      appBar: AppBar(
        title: Text(AppShellBranch.values[AppShellBranch.indexFromName(
                routerState.fullPath?.split('/')[1] ?? '')]
            .title(context)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: child.currentIndex,
        items: AppShellBranch.values
            .map(
              (e) => BottomNavigationBarItem(
                label: e.title(context),
                icon: e.icon(),
                activeIcon: e.activeIcon(),
              ),
            )
            .toList(),
      ),
    );
  }

  void onTap(int i) {
    /// Get current index from current router path
    final currentIndex = AppShellBranch.indexFromName(
      routerState.fullPath?.split('/')[1] ?? '',
    );

    /// If the current index is the same as the tapped index,
    /// navigate back to the root of the current branch.
    ///
    /// This is the expected behavior from apps in both iOS and
    /// Android.
    if (currentIndex == i) {
      return child.goBranch(i, initialLocation: true);
    }

    return child.goBranch(i);
  }
}
