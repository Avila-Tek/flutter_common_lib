{{#isTabbed}}import 'package:equatable/equatable.dart';{{/isTabbed}}{{#isStepper}}import 'package:equatable/equatable.dart';{{/isStepper}}
import 'package:flutter/material.dart';
import 'package:{{{fullPath}}}/bloc/bloc.dart';

part 'package:{{{fullPath}}}/base/{{feature_name.snakeCase()}}_body.dart';
{{#isTabbed}}//TODO: remember to add the part/part of in any additional widget you add to any of your tabs.
{{#childrenNames}}part 'package:{{{fullPath}}}/tabs/{{#snakeCase}}{{.}}{{/snakeCase}}/base/{{#snakeCase}}{{.}}{{/snakeCase}}_page.dart';
part 'package:{{{fullPath}}}/tabs/{{#snakeCase}}{{.}}{{/snakeCase}}/base/{{#snakeCase}}{{.}}{{/snakeCase}}_body.dart';
part 'package:{{{fullPath}}}/tabs/{{#snakeCase}}{{.}}{{/snakeCase}}/bloc/{{#snakeCase}}{{.}}{{/snakeCase}}_bloc.dart';
part 'package:{{{fullPath}}}/tabs/{{#snakeCase}}{{.}}{{/snakeCase}}/bloc/{{#snakeCase}}{{.}}{{/snakeCase}}_event.dart';
part 'package:{{{fullPath}}}/tabs/{{#snakeCase}}{{.}}{{/snakeCase}}/bloc/{{#snakeCase}}{{.}}{{/snakeCase}}_state.dart';
{{/childrenNames}}{{/isTabbed}}
{{#isStepper}}//TODO: remember to add the part/part of in any additional widget you add to any of your tabs.
{{#childrenNames}}part 'package:{{{fullPath}}}/steps/{{#snakeCase}}{{.}}{{/snakeCase}}/base/{{#snakeCase}}{{.}}{{/snakeCase}}_page.dart';
part 'package:{{{fullPath}}}/steps/{{#snakeCase}}{{.}}{{/snakeCase}}/base/{{#snakeCase}}{{.}}{{/snakeCase}}_body.dart';
part 'package:{{{fullPath}}}/steps/{{#snakeCase}}{{.}}{{/snakeCase}}/bloc/{{#snakeCase}}{{.}}{{/snakeCase}}_bloc.dart';
part 'package:{{{fullPath}}}/steps/{{#snakeCase}}{{.}}{{/snakeCase}}/bloc/{{#snakeCase}}{{.}}{{/snakeCase}}_event.dart';
part 'package:{{{fullPath}}}/steps/{{#snakeCase}}{{.}}{{/snakeCase}}/bloc/{{#snakeCase}}{{.}}{{/snakeCase}}_state.dart';
{{/childrenNames}}{{/isStepper}}

/// {@template {{feature_name.snakeCase()}}_page}
/// A description for {{feature_name.pascalCase()}}Page
/// {@endtemplate}
{{#isConventional}}class {{feature_name.pascalCase()}}Page extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_page}
  const {{feature_name.pascalCase()}}Page({super.key});

  /// The path name of {{feature_name.pascalCase()}}Page. Use for navigation.
  static const path = '/$routeName';
  
  /// The route name of {{feature_name.pascalCase()}}Page. Use to navigate
  /// with named routes.
  static const routeName = '{{feature_name.paramCase()}}';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{feature_name.pascalCase()}}Bloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('{{feature_name.pascalCase()}}'),
        ),
        body: const _{{feature_name.pascalCase()}}View(),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of {{feature_name.pascalCase()}} here to handle navigation, showing dialogs, etc.
/// {@template {{feature_name.snakeCase()}}_view}
/// Displays the Body of {{feature_name.pascalCase()}}View
/// {@endtemplate}
/// 
class _{{feature_name.pascalCase()}}View extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_view}
  const _{{feature_name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return const _{{feature_name.pascalCase()}}Body();
  }
}{{/isConventional}}{{#isTabbed}}
class {{feature_name.pascalCase()}}Page extends StatefulWidget {
  /// {@macro {{feature_name.pascalCase()}}_page}
  const {{feature_name.pascalCase()}}Page({super.key});

 /// The path name of {{feature_name.pascalCase()}}Page. Use for navigation.
  static const path = '/$routeName';
  
  /// The route name of {{feature_name.pascalCase()}}Page. Use to navigate
  /// with named routes.
  static const routeName = '{{feature_name.paramCase()}}';

  @override
  State<{{feature_name.pascalCase()}}Page> createState() => _{{feature_name.pascalCase()}}PageState();
}

class _{{feature_name.pascalCase()}}PageState extends State<{{feature_name.pascalCase()}}Page>
    with SingleTickerProviderStateMixin {
  // TODO: remember to add any additional tabs you add to the list of tabs.
  static const List<Tab> myTabs = <Tab>[
    {{#childrenNames}}Tab(text: '{{#snakeCase}}{{.}}{{/snakeCase}}'),
    {{/childrenNames}}
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{feature_name.pascalCase()}}Bloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('{{feature_name}}'),
          bottom: TabBar(
            tabs: myTabs,
            controller: _tabController,
          ),
        ),
        body: _{{feature_name.pascalCase()}}View(
          tabController: _tabController,
        ),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of {{feature_name.pascalCase()}} here to handle navigation,
// showing dialogs, etc.
/// {@template {{feature_name.pascalCase()}}_view}
/// Displays the Body of {{feature_name.pascalCase()}}View
/// {@endtemplate}
///
class _{{feature_name.pascalCase()}}View extends StatelessWidget {
  /// {@macro {{feature_name.pascalCase()}}_view}
  const _{{feature_name.pascalCase()}}View({
    required TabController tabController,
    super.key,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return _{{feature_name.pascalCase()}}Body(
      tabController: _tabController,
    );
  }
}{{/isTabbed}}{{#isStepper}}
class {{feature_name.pascalCase()}}Page extends StatelessWidget {
  /// {@macro travel_subscription_page}
  const {{feature_name.pascalCase()}}Page({
    super.key,
  });

  static const path = '/$routeName';

  static const routeName = '{{feature_name.paramCase()}}';

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
          create: (context) => {{feature_name.pascalCase()}}Bloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('{{feature_name.pascalCase()}}'),
        ),
        body: {{feature_name.pascalCase()}}View(),
      ),
    );
  }
}

/// {@template travel_subscription_view}
/// Displays the Body of {{feature_name.pascalCase()}}View
/// {@endtemplate}
class {{feature_name.pascalCase()}}View extends StatelessWidget {
  /// {@macro travel_subscription_view}
  const {{feature_name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return _{{feature_name.pascalCase()}}Body();
  }
}{{/isStepper}}