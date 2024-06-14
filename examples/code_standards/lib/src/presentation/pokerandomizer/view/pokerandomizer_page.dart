import 'package:code_standards/core/widgets/custom_app_bar.dart';
import 'package:code_standards/src/presentation/pokerandomizer/bloc/bloc.dart';
import 'package:code_standards/src/presentation/pokerandomizer/widgets/pokerandomizer_body.dart';
import 'package:flutter/material.dart';

/// {@template pokerandomizer_page}
/// A description for PokerandomizerPage
/// {@endtemplate}
class PokerandomizerPage extends StatelessWidget {
  /// {@macro pokerandomizer_page}
  const PokerandomizerPage({super.key});

  /// The path name of PokerandomizerPage. Use for navigation.
  static const path = '/$routeName';

  /// The route name of PokerandomizerPage. Use to navigate
  /// with named routes.
  static const routeName = 'pokerandomizer';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokerandomizerBloc(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: const Text('Pokerandomizer'),
        ),
        body: const PokerandomizerView(),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of Pokerandomizer here to handle navigation, showing dialogs, etc.
/// {@template pokerandomizer_view}
/// Displays the Body of PokerandomizerView
/// {@endtemplate}
///
class PokerandomizerView extends StatelessWidget {
  /// {@macro pokerandomizer_view}
  const PokerandomizerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PokerandomizerBody();
  }
}
