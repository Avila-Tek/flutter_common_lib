// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:{{{fullPath}}}/src/routes/shell_branches.dart';

/// {@template index_page}
/// The index page of the app. This page is responsible for displaying the
/// scaffold with the bottom navigation bar.
/// {@endtemplate}
class IndexNavigationPage extends StatelessWidget {
  /// {@macro index_page}
  const IndexNavigationPage({
    required this.child,
    required this.routerState,
    required this.scaffoldKey,
    super.key,
  });

  final StatefulNavigationShell child;
  final GoRouterState routerState;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: GlobalAppbar(
        titleAppbar: AppShellBranch.values[AppShellBranch.indexFromName(
                routerState.fullPath?.split('/')[1] ?? '')]
            .title(context),
      ),
      endDrawer: Drawer(
        child: DrawerWidget(
          scaffoldKey: scaffoldKey,
          items: AppShellBranch.values
              .asMap()
              .map((index, e) {
                return MapEntry(
                  index,
                  NavigationDrawerDestination(
                    label: Text(
                      e.drawerLabel(context),
                      style: context.textTheme.labelMedium,
                    ),
                    icon: Image.asset(
                      e.iconAsset(context),
                      width: 24,
                    ),
                  ),
                );
              })
              .values
              .toList(),
          selectedIndex: child.currentIndex,
          onDestinationSelected: (value) {
            final displayOrder = userBloc.state.user.trader
                ? AppShellBranch.traderDisplayOrder
                : AppShellBranch.clientDisplayOrder;

            if (value < displayOrder.length) {
              final menuItem = displayOrder[value];
              context.push(menuItem.path);
              scaffoldKey.currentState?.openEndDrawer(); // Close the drawer
              Navigator.pop(context); // Close the drawer
            }
          },
        ),
      ),
      // endDrawer:
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   items: AppShellBranch.values
      //       .asMap()
      //       .map((index, e) {
      //         return MapEntry(
      //           index,
      //           CustomButtonNavigationBarItem(
      //             icon: Image.asset(
      //               e.iconAsset(),
      //               width: 24,
      //             ),
      //             selected: child.currentIndex == index,
      //             label: e.title(context),
      //             onTap: () => onTap(index),
      //           ),
      //         );
      //       })
      //       .values
      //       .toList(),
      // ),
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
