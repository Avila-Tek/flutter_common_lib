// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:{{packageName}}/routes/branches/base_branch.dart';

/// Defines all the branches for the app, including navigator keys for each
/// branch.
///
/// [AppStatefulShellBranches.branches] returns the [StatefulShellBranch] of
/// each [AppShellBranch] value.
///
/// To add a new branch (a new tab in the bottom navigation bar), you
/// must:
///
/// 1. Declare a new entry for [AppShellBranch].
/// 2. Create a implementation of [AppBaseShellBranch] for the new branch.
///
class AppStatefulShellBranches {
  /// The list of [AppShellBranch] for each [AppShellBranch] value.
  static List<StatefulShellBranch> get branches => AppShellBranch.values.map(_branch).toList();

  static StatefulShellBranch _branch(AppShellBranch page) {
    {{#branches}}final {{#camelCase}}{{.}}{{/camelCase}} = {{#pascalCase}}{{.}}{{/pascalCase}}ShellBranch();
    {{/branches}}

    switch (page) {
      {{#branches}}case AppShellBranch.{{#camelCase}}{{.}}{{/camelCase}}:
        return {{#camelCase}}{{.}}{{/camelCase}}.branch;
        {{/branches}}
    }
  }
}

/// {@template app_branches}
/// Defines all the branches for the app. This is used to build the bottom
/// navigation bar, and declares the route name for each branch, aswell as
/// the title and icon for each branch (tab) in the bottom navigation bar.
///
/// The order of each branch in this enum will be the same order it will be
/// displayed in the bottom navigation bar.
/// {@endtemplate}
enum AppShellBranch {
  {{#branches}}{{#camelCase}}{{.}}{{/camelCase}}('{{#camelCase}}{{.}}{{/camelCase}}'),
  {{/branches}};
  /// {@macro app_branches}
  const AppShellBranch(this.routeName);

  /// The name of this branch initial route. Used to set the [GoRoute.name]
  /// parameter.
  final String routeName;

  /// The path to this branch initial route. Used to set the [GoRoute.path]
  /// parameter, aswell as [StatefulShellBranch.initialLocation]
  ///
  /// This is the same as [routeName], but with a leading `/` i.e.:
  /// `/wallet`.
  String get path => '/$routeName';

  /// Returns the localized title for this branch.
  String title(BuildContext context) {
    // TODO: Localize titles.
    switch (this) {
      {{#branches}}case AppShellBranch.{{#camelCase}}{{.}}{{/camelCase}}:
        return '{{#titleCase}}{{.}}{{/titleCase}}';
        {{/branches}}
    }
  }

  /// Returns the icon for this branch.
  Widget icon() {
    switch (this) {
      {{#branches}}case AppShellBranch.{{#camelCase}}{{.}}{{/camelCase}}:
        // TODO: Update with your custom icons
        return const Icon(Icons.check_box_outline_blank, color: Colors.grey);
      {{/branches}}
    }
  }
  /// Returns the active icon for this branch that would be displayed when the
  /// branch is active or selected.
  Widget activeIcon() {
    switch (this) {
      {{#branches}}case AppShellBranch.{{#camelCase}}{{.}}{{/camelCase}}:
        // TODO: Update with your custom icons
        return const Icon(Icons.check_box_outline_blank, color: Colors.blue);
        {{/branches}}
    }
  }

  /// Returns the index of the given `name` from [AppShellBranch.values] list,
  /// by comparing it to the [routeName] of each branch.
  /// ---
  /// #### Note:
  /// `name` must not be a path, it must be the name of the route. For example,
  /// if you want to get the index of the `loans` branch, you must pass
  /// `loans` as the `name` parameter, not `/loans`.
  static int indexFromName(String name) {
    assert(!name.startsWith('/'), 'name cannot be a path');

    final index = AppShellBranch.values.indexWhere(
      (element) => element.routeName == name,
    );

    if (index == -1) {
      return 0;
    }

    return index;
  }
}
