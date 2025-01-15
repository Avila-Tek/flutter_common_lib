import 'package:flutter/material.dart';{{#isBloc}}
import 'package:{{{fullPath}}}/bloc/bloc.dart';{{/isBloc}}{{#isCubit}}
import 'package:{{{fullPath}}}/cubit/cubit.dart';{{/isCubit}}{{#isProvider}}
import 'package:{{{fullPath}}}/provider/provider.dart';{{/isProvider}}
import 'package:{{{fullPath}}}/widgets/{{feature_name.snakeCase()}}_body.dart';

/// {@template {{feature_name.snakeCase()}}_page}
/// A description for {{feature_name.pascalCase()}}Page
/// {@endtemplate}
class {{feature_name.pascalCase()}}Page extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_page}
  const {{feature_name.pascalCase()}}Page({super.key});

  /// The path name of {{feature_name.pascalCase()}}Page. Use for navigation.
  static const path = '/$routeName';
  
  /// The route name of {{feature_name.pascalCase()}}Page. Use to navigate
  /// with named routes.
  static const routeName = '{{feature_name.paramCase()}}';

{{#isBloc}}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{feature_name.pascalCase()}}Bloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('{{feature_name.pascalCase()}}'),
        ),
        body: const {{feature_name.pascalCase()}}View(),
      ),
    );
  } {{/isBloc}}{{#isCubit}}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{feature_name.pascalCase()}}Cubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('{{feature_name.pascalCase()}}'),
        ),
        body: const {{feature_name.pascalCase()}}View(),
      ),
    );
  } {{/isCubit}} {{#isProvider}}
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => {{feature_name.pascalCase()}}Notifier(),
      child: const Scaffold(
        body: {{feature_name.pascalCase()}}View(),
      ),
    );
  } {{/isProvider}} {{#isRiverpod}}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{feature_name.pascalCase()}}'),
      ),
      body: const {{feature_name.pascalCase()}}View(),
    );
  } {{/isRiverpod}} {{#isNone}}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{feature_name.pascalCase()}}'),
      ),
      body: const {{feature_name.pascalCase()}}View(),
    );
  } {{/isNone}}
}

// NOTE: Declare all BlocListeners of {{feature_name.pascalCase()}} here to handle navigation, showing dialogs, etc.
/// {@template {{feature_name.snakeCase()}}_view}
/// Displays the Body of {{feature_name.pascalCase()}}View
/// {@endtemplate}
/// 
class {{feature_name.pascalCase()}}View extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_view}
  const {{feature_name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return const {{feature_name.pascalCase()}}Body();
  }
}
