import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/presentation/pokedex/pokedex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers.dart';

void main() {
  group('PokedexListView', () {
    late List<Pokemon> tPokemons;

    setUp(
      () {
        tPokemons = <Pokemon>[
          for (var i = 0; i < 3; i++) Pokemon.empty(),
        ];
      },
    );

    testWidgets(
      'renders PokedexEmpty for PagedRemoteDataNextPageFetched with empty '
      'data',
      (tester) async {
        const tState = PagedRemoteDataNextPageFetched<Pokemon>([]);

        await tester.pumpApp(
          child: PokedexListView(state: tState, onRetry: () {}),
        );

        expect(find.byType(PokedexEmpty), findsOneWidget);
      },
    );
    testWidgets(
      'renders a [ListTile] for each data object of '
      'PagedRemoteDataNextPageFecthed',
      (tester) async {
        final tState = PagedRemoteDataNextPageFetched(tPokemons);
        await tester.pumpApp(
          child: PokedexListView(state: tState, onRetry: () {}),
        );

        expect(find.byType(PokemonListTile), findsNWidgets(tPokemons.length));
      },
    );
    testWidgets(
      'renders each ListTile and a PokedexErrorListTile for '
      'PagedRemoteDataNextPageFetchingFailure',
      (tester) async {
        final tState = PagedRemoteDataNextPageFetchingFailure<Pokemon>(
          PagedRemoteDataNextPageFetched(tPokemons),
          '',
        );

        await tester.pumpApp(
          child: PokedexListView(state: tState, onRetry: () {}),
        );

        await tester.pumpAndSettle();

        expect(find.byType(PokemonListTile), findsNWidgets(tPokemons.length));
        expect(find.byType(PokedexErrorListTile), findsOneWidget);
      },
    );
    testWidgets(
      'renders each ListTile and a PokedexLoadingListTile for '
      'PagedRemoteDataNextPageFetching',
      (tester) async {
        final tState = PagedRemoteDataNextPageFetching<Pokemon>(
          PagedRemoteDataNextPageFetched(tPokemons),
        );

        await tester.pumpApp(
          child: PokedexListView(state: tState, onRetry: () {}),
        );

        expect(find.byType(PokemonListTile), findsNWidgets(tPokemons.length));
        expect(find.byType(PokedexLoadingListTile), findsOneWidget);
      },
    );
    testWidgets(
      'renders each ListTile and a empty space for '
      'PagedRemoteDataLastPageFetched',
      (tester) async {
        final tState = PagedRemoteDataLastPageFetched<Pokemon>(tPokemons);

        await tester.pumpApp(
          child: PokedexListView(state: tState, onRetry: () {}),
        );

        expect(find.byType(ListTile), findsNWidgets(tPokemons.length));
        expect(
          find.byKey(const ValueKey('pokedex_list_view_empty_space')),
          findsOneWidget,
        );
      },
    );
  });
}
