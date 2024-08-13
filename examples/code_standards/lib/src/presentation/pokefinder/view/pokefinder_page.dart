import 'package:code_standards/core/widgets/custom_app_bar.dart';
import 'package:code_standards/src/domain/use_cases/get_pokemon.dart';
import 'package:code_standards/src/presentation/pokefinder/bloc/bloc.dart';
import 'package:code_standards/src/presentation/pokefinder/widgets/pokefinder_body.dart';
import 'package:flutter/material.dart';

/// {@template pokefinder_page}
/// A description for PokefinderPage
/// {@endtemplate}
class PokefinderPage extends StatelessWidget {
  /// {@macro pokefinder_page}
  const PokefinderPage({super.key});

  /// The path name of PokefinderPage. Use for navigation.
  static const path = '/$routeName';

  /// The route name of PokefinderPage. Use to navigate
  /// with named routes.
  static const routeName = 'pokefinder';

  static const initialId = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokefinderBloc(
        initialValue: initialId,
        getPokemon: GetPokemonUseCase(context.read()),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: const Text('Pokefinder'),
        ),
        body: const PokefinderView(),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of Pokefinder here to handle navigation, showing dialogs, etc.
/// {@template pokefinder_view}
/// Displays the Body of PokefinderView
/// {@endtemplate}
///
class PokefinderView extends StatelessWidget {
  /// {@macro pokefinder_view}
  const PokefinderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PokefinderBody();
  }
}
