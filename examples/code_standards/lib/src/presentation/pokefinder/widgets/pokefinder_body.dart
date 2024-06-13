import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:code_standards/l10n/l10n.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/presentation/pokefinder/bloc/bloc.dart';
import 'package:code_standards/src/presentation/pokefinder/widgets/pokefinder_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template pokefinder_body}
/// Body of the PokefinderPage.
/// {@endtemplate}
class PokefinderBody extends StatelessWidget {
  /// {@macro pokefinder_body}
  const PokefinderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokefinderBloc, RemoteDataState<Pokemon>>(
      listener: (context, state) {
        if (state.isFailure) {
          AvilaSnackBar.failure(
            context: context,
            content: Text(context.l10n.pokedexFinderSnackbarFailureMessage),
          ).show(context);
        }
      },
      builder: (context, state) {
        return Opacity(
          opacity: (state.isFetching) ? 0.75 : 1,
          child: Builder(
            builder: (context) {
              Pokemon? pokemon;
              if (state.isInitialized) {
                pokemon = (state as RemoteDataInitialized<Pokemon>).data;
              }
              return PokefinderFinder(
                pokemon: pokemon,
                onInputChanged: (value) =>
                    context.read<PokefinderBloc>().id = value,
              );
            },
          ),
        );
      },
    );
  }
}
