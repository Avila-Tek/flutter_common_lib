import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:code_standards/core/constants.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/domain/repositories/repositories.dart';
import 'package:code_standards/src/presentation/pokedex/pokedex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers.dart';
import '../mocks.dart';

void main() {
  /// Should display appbar with title
  /// Should display a list of pokemons
  /// Should display error widget when api call fails
  /// Should display loading widget when api call is in progress
  group(
    'PokedexPage',
    () {
      late IPokemonRepository repository;

      setUp(() => repository = PokemonRepositoryMock());

      testWidgets(
        'renders PokedexView',
        (tester) async {
          await tester.pumpApp(
            child: RepositoryProvider.value(
              value: repository,
              child: const PokedexPage(),
            ),
          );

          expect(find.byType(PokedexView), findsOneWidget);
        },
      );
    },
  );

  group('PokedexView', () {
    late PokedexBloc bloc;

    setUp(() => bloc = PokedexBlocMock());

    testWidgets(
      'renders PokedexError for PagedRemoteDataUninitialized',
      (tester) async {
        when(() => bloc.state).thenReturn(PagedRemoteDataUninitialized());

        // NOTE: We need to stub bloc.stream to test the BlocBuilder's
        // subscription.
        when(() => bloc.stream).thenAnswer(
          (_) => Stream.value(PagedRemoteDataUninitialized()),
        );

        await tester.pumpApp(
          child: BlocProvider.value(
            value: bloc,
            child: const PokedexView(),
          ),
        );

        expect(find.byType(PokedexError), findsOneWidget);
      },
    );

    testWidgets(
      'renders PokedexLoading for PagedRemoteDataFirstPageFetching',
      (tester) async {
        final tState = PagedRemoteDataFirstPageFetching<Pokemon>();

        when(() => bloc.state).thenReturn(tState);
        when(() => bloc.stream).thenAnswer((_) => Stream.value(tState));

        await tester.pumpApp(
          child: BlocProvider.value(
            value: bloc,
            child: const PokedexView(),
          ),
        );

        expect(find.byType(PokedexLoading), findsOneWidget);
      },
    );

    /// NOTE: Example on how to test transitional state behaviors, like showing
    /// a Snackbar, a Dialog, pushing a new route, etc.
    testWidgets(
      'shows Snackbar with error message when '
      'PagedRemoteDataFirstPageFetchingFailure is emitted',
      (tester) async {
        const tState1 = PagedRemoteDataFirstPageFetchingFailure<Pokemon>(
          'test description',
        );
        final tState2 = PagedRemoteDataUninitialized<Pokemon>();

        when(() => bloc.state).thenReturn(tState2);

        /// Simulates a PagedRemoteData error that emits a transitional
        /// (and instant) state before the final state. This way, the
        /// PokedexView's BlocListener will show the snackbar without
        /// breaking PokedexBody's assertion, which do not accept
        /// PagedRemoteDataFirstPageFetchingFailure as a state for PokedexBody.
        when(() => bloc.stream)
            .thenAnswer((_) => Stream.fromIterable([tState1, tState2]));

        await tester.pumpApp(
          child: BlocProvider.value(
            value: bloc,
            child: const Scaffold(body: PokedexView()),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Failed to load Pokédex'), findsOneWidget);
        expect(find.text('test description'), findsOneWidget);
      },
    );

    group('PokedexListView', () {
      late List<Pokemon> tPokemons;

      setUp(
        () => tPokemons = <Pokemon>[
          for (var i = 0; i < Consts.pageLimit; i++) Pokemon.empty(),
        ].cast<Pokemon>(),
      );

      testWidgets(
        'renders PokedexEmpty for PagedRemoteDataNextPageFetched with empty '
        'data',
        (tester) async {
          const tState = PagedRemoteDataNextPageFetched<Pokemon>([]);

          when(() => bloc.state).thenReturn(tState);
          when(() => bloc.stream).thenAnswer((_) => Stream.value(tState));

          await tester.pumpApp(
            child: PokedexListView(state: tState, onRetry: () {}),
          );

          expect(find.byType(PokedexEmpty), findsOneWidget);
        },
      );
      testWidgets(
        'renders PokedexListView for PagedRemoteDataNextPageFecthed with data',
        (tester) async {
          final tState = PagedRemoteDataNextPageFetched(tPokemons);

          when(() => bloc.state).thenReturn(tState);
          when(() => bloc.stream).thenAnswer((_) => Stream.value(tState));

          await tester.pumpApp(
            child: BlocProvider.value(
              value: bloc,
              child: const PokedexView(),
            ),
          );

          expect(find.byType(PokedexListView), findsOneWidget);
        },
      );
    });
  });
}
