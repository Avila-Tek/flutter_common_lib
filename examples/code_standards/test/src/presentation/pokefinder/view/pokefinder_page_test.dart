import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/presentation/pokefinder/pokefinder.dart';
import 'package:code_standards/src/presentation/pokefinder/widgets/pokefinder_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers.dart';
import '../mocks.dart';

void main() {
  group(
    'PokefinderPage',
    () {
      testWidgets(
        'renders [PokefinderView]',
        (tester) async {
          // Arrange
          final repository = MockPokemonRepository();
          // Act
          await tester.pumpApp(
            pokemonRepository: repository,
            child: const PokefinderPage(),
          );
          // Assert
          expect(find.byType(PokefinderView), findsOne);
        },
      );
    },
  );
  group(
    'PokefinderBody',
    () {
      testWidgets(
        'renders [PokefinderFinder] widget on any state',
        (tester) async {
          // Arrange
          final state = MockPokefinderState();
          final bloc = MockPokefinderBloc();
          when(() => bloc.state).thenReturn(state);
          when(() => bloc.stream).thenAnswer(
            (_) => Stream.value(state),
          );
          // Act
          await tester.pumpApp(
            child: BlocProvider<PokefinderBloc>.value(
              value: bloc,
              child: const PokefinderBody(),
            ),
          );
          // Assert
          expect(find.byType(PokefinderFinder), findsOne);
        },
      );

      final fetchingStateVariants = ValueVariant<RemoteDataState<Pokemon>>({
        MockRemoteDataRefetching(),
        RemoteDataInitialFetching(),
      });

      testWidgets(
        'renders [Opacity] with opacity: 0.75 on either '
        '[RemoteDataInitialFetching] or [RemoteDataRefetching]',
        (tester) async {
          // Arrange
          final state = fetchingStateVariants.currentValue!;
          final bloc = MockPokefinderBloc();
          when(() => bloc.state).thenReturn(state);
          when(() => bloc.stream).thenAnswer((_) => Stream.value(state));
          // Act
          await tester.pumpApp(
            child: BlocProvider<PokefinderBloc>.value(
              value: bloc,
              child: const PokefinderBody(),
            ),
          );
          // Assert
          expect(
            tester.widget(find.byType(Opacity)),
            isA<Opacity>().having(
              (widget) => widget.opacity,
              'opacity',
              equals(0.75),
            ),
          );
        },
        variant: fetchingStateVariants,
      );

      final notFetchingStateVariants = ValueVariant<RemoteDataState<Pokemon>>({
        RemoteDataUninitialized<Pokemon>(),
        RemoteDataFetched<Pokemon>(Pokemon.empty()),
        MockPokefinderState(),
      });

      testWidgets(
        'renders [Opacity] with opacity: 1 when state is neither '
        '[RemoteDataInitialFetching] or [RemoteDataRefetching]',
        (tester) async {
          // Arrange
          final state = notFetchingStateVariants.currentValue!;
          final bloc = MockPokefinderBloc();
          when(() => bloc.state).thenReturn(state);
          when(() => bloc.stream).thenAnswer((_) => Stream.value(state));
          // Act
          await tester.pumpApp(
            child: BlocProvider<PokefinderBloc>.value(
              value: bloc,
              child: const PokefinderBody(),
            ),
          );
          // Assert
          expect(
            tester.widget(find.byType(Opacity)),
            isA<Opacity>().having(
              (widget) => widget.opacity,
              'opacity',
              equals(1.0),
            ),
          );
        },
        variant: notFetchingStateVariants,
      );
      testWidgets(
        'renders [Snackbar] on [RemoteDataError]',
        (tester) async {
          // Arrange
          final state = MockRemoteDataError();
          final bloc = MockPokefinderBloc();
          when(() => bloc.state).thenReturn(state);
          when(() => bloc.stream).thenAnswer((_) => Stream.value(state));
          // Act
          await tester.pumpApp(
            child: BlocProvider<PokefinderBloc>.value(
              value: bloc,
              child: const Scaffold(body: PokefinderBody()),
            ),
          );
          await tester.pumpAndSettle();

          // Assert
          expect(find.byType(SnackBar), findsOneWidget);
        },
      );
      testWidgets(
        'should update [PokefinderBloc.id] when [TextField] is changed',
        (tester) async {
          // Arrange
          final state = MockPokefinderState();
          final bloc = MockPokefinderBloc();
          when(() => bloc.state).thenReturn(state);
          when(() => bloc.stream).thenAnswer((_) => Stream.value(state));
          // Act
          await tester.pumpApp(
            child: BlocProvider<PokefinderBloc>.value(
              value: bloc,
              child: const Scaffold(body: PokefinderBody()),
            ),
          );
          final textFieldFinder =
              find.byKey(const ValueKey('pokefinder_finder_id_input'));

          // Act
          await tester.enterText(textFieldFinder, '0');
          // Assert
          verify(() => bloc.id = '0').called(1);
        },
      );
    },
  );
}
