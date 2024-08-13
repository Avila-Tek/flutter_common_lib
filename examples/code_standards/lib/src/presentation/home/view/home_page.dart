import 'package:code_standards/core/widgets/widgets.dart';
import 'package:code_standards/src/presentation/home/bloc/bloc.dart';
import 'package:code_standards/src/presentation/home/widgets/home_body.dart';
import 'package:flutter/material.dart';

/// {@template home_page}
/// A description for HomePage
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  /// The path name of HomePage. Use for navigation.
  static const path = '/$routeName';

  /// The route name of HomePage. Use to navigate
  /// with named routes.
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: CustomAppBar(
          key: const Key('home_appbar'),
          title: const Text('Pokemon'),
        ),
        body: const HomeView(),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of Home here to handle navigation, showing dialogs, etc.
/// {@template home_view}
/// Displays the Body of HomeView
/// {@endtemplate}
///
class HomeView extends StatelessWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}
