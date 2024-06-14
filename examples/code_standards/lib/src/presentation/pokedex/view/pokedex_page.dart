import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:code_standards/core/constants.dart';
import 'package:code_standards/core/widgets/custom_app_bar.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/domain/use_cases/get_pokemons.dart';
import 'package:code_standards/src/presentation/pokedex/bloc/bloc.dart';
import 'package:code_standards/src/presentation/pokedex/widgets/pokedex_body.dart';
import 'package:code_standards/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template pokedex_page}
/// A description for PokedexPage
/// {@endtemplate}
class PokedexPage extends StatelessWidget {
  /// {@macro pokedex_page}
  const PokedexPage({super.key});

  /// The path name of PokedexPage. Use for navigation.
  static const path = '/$routeName';

  /// The route name of PokedexPage. Use to navigate
  /// with named routes.
  static const routeName = 'pokedex';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokedexBloc(
        getPokemons: GetPokemonsUseCase(context.read()),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(context.l10n.pokedexPageTitle),
        ),
        body: const PokedexView(),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of Pokedex here to handle navigation,
// showing dialogs, etc.
/// {@template pokedex_view}
/// Displays the Body of PokedexView
/// {@endtemplate}
///
class PokedexView extends StatelessWidget {
  /// {@macro pokedex_view}
  const PokedexView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PokedexBloc, PagedRemoteDataState<Pokemon>>(
      listener: (context, state) {
        if (state is PagedRemoteDataFirstPageFetchingFailure) {
          AvilaSnackBar.failure(
            context: context,
            content: AvilaSnackBarChild(
              title: 'Failed to load Pokédex',
              description: (state as PagedRemoteDataFirstPageFetchingFailure)
                  .error
                  .toString(),
            ),
          ).show(context);
        }
      },
      child: const PokedexBody(),
    );
  }
}
