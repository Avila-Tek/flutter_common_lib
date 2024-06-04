import 'package:code_standards/src/presentation/home/view/home_page.dart';
import 'package:code_standards/src/presentation/pokedex/view/pokedex_page.dart';
import 'package:code_standards/src/presentation/pokefinder/pokefinder.dart';
import 'package:code_standards/src/presentation/pokerandomizer/pokerandomizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers.dart';

void main() {
  group(
    'HomePage',
    () {
      testWidgets(
        'should display [AppBar], [ListView] and all the [ListTile]s',
        (tester) async {
          await tester.pumpApp(child: const HomePage());
          await tester.pumpAndSettle();
          final appbar = find.byKey(const Key('home_appbar'));
          final listview = find.byKey(const Key('home_listview'));
          final pokedexTile = find.byKey(const Key('pokedex_list_tile'));
          final pFinderTile = find.byKey(const Key('poke_finder_list_tile'));
          final pRandomTile = find.byKey(const Key('poke_random_list_tile'));

          expect(appbar, findsOneWidget);
          expect(listview, findsOneWidget);
          expect(pokedexTile, findsOneWidget);
          expect(pFinderTile, findsOneWidget);
          expect(pRandomTile, findsOneWidget);
        },
      );
      testWidgets(
        'should navigate to PokedexPage when tapping on Pokedex list tile',
        (tester) async {
          await tester.pumpApp(child: const HomePage());

          await tester.tap(find.byKey(const Key('pokedex_list_tile')));

          await tester.pumpAndSettle();

          expect(find.byType(PokedexPage), findsOneWidget);
        },
      );

      testWidgets(
        'should navigate to [PokefinderPage] when tapping on PokeFinder '
        'list tile',
        (tester) async {
          await tester.pumpApp(child: const HomePage());

          await tester.tap(find.byKey(const Key('poke_finder_list_tile')));

          await tester.pumpAndSettle();

          expect(find.byType(PokefinderPage), findsOneWidget);
        },
      );

      testWidgets(
        'should navigate to [PokerandomizerPage] when tapping on PokeRandom '
        'list tile',
        (tester) async {
          await tester.pumpApp(child: const HomePage());

          await tester.tap(find.byKey(const Key('poke_random_list_tile')));

          await tester.pumpAndSettle();

          expect(find.byType(PokerandomizerPage), findsOneWidget);
        },
      );
    },
  );
}
