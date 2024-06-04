import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/presentation/pokedex/bloc/bloc.dart';
import 'package:code_standards/src/presentation/pokedex/widgets/widgets.dart';
import 'package:flutter/material.dart';

// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template pokedex_body}
/// Body of the PokedexPage.
/// {@endtemplate}
class PokedexBody extends StatelessWidget {
  /// {@macro pokedex_body}
  const PokedexBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokedexBloc, PagedRemoteDataState<Pokemon>>(
      builder: (context, state) {
        if (state is PagedRemoteDataUninitialized) {
          return PokedexError(
            onRetry: () => context
                .read<PokedexBloc>()
                .add(const PagedRemoteDataFetchNextPage()),
          );
        }

        if (state is PagedRemoteDataFirstPageFetching) {
          return const PokedexLoading();
        }

        assert(
          state is PagedRemoteDataInitialized,
          'Invalid state: $state. Was expecting a PagedRemoteDataInitialized '
          'state.',
        );

        return PokedexListView(
          state: state as PagedRemoteDataInitialized<Pokemon>,
          onRetry: () => context
              .read<PokedexBloc>()
              .add(const PagedRemoteDataFetchNextPage()),
        );
      },
    );
  }
}
