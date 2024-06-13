import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/presentation/pokefinder/widgets/pokefinder_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers.dart';

void main() {
  group(
    'PokefinderFinder',
    () {
      testWidgets(
        'renders [SizedBox] and [TextField] but not [CachedNetworkImage] when '
        '[PokefinderFinder.pokemon] is null',
        (tester) async {
          // Act
          await tester.pumpApp(
            child: PokefinderFinder(onInputChanged: (_) {}),
          );

          // Assert
          final sizedBoxFinder = find.byKey(
            const ValueKey('pokefinder_finder_pokemon_sprite_sized_box'),
          );
          final imageFinder = find.byKey(
            const ValueKey('pokefinder_finder_pokemon_sprite_image'),
          );
          final textFieldFinder = find.byKey(
            const ValueKey('pokefinder_finder_id_input'),
          );
          expect(sizedBoxFinder, findsOne);
          expect(imageFinder, findsNothing);
          expect(textFieldFinder, findsOne);
        },
      );
      testWidgets(
        'renders [CachedNetworkImage] and [TextField] when '
        '[PokefinderFinder.pokemon] is not null',
        (tester) async {
          // Act
          await tester.pumpApp(
            child: PokefinderFinder(
              pokemon: Pokemon.empty(),
              onInputChanged: (_) {},
            ),
          );

          final sizedBoxFinder = find.byKey(
            const ValueKey('pokefinder_finder_pokemon_sprite_sized_box'),
          );
          final imageFinder = find
              .byKey(const ValueKey('pokefinder_finder_pokemon_sprite_image'));
          final textFieldFinder =
              find.byKey(const ValueKey('pokefinder_finder_id_input'));
          expect(sizedBoxFinder, findsOne);
          expect(imageFinder, findsOne);
          expect(textFieldFinder, findsOne);
        },
      );

      group('TextField', () {
        testWidgets(
          'should accept digits only',
          (tester) async {
            // Act
            await tester.pumpApp(
              child: PokefinderFinder(
                pokemon: Pokemon.empty(),
                onInputChanged: (_) {},
              ),
            );

            // Assert
            final textFieldFinder =
                find.byKey(const ValueKey('pokefinder_finder_id_input'));

            await tester.enterText(textFieldFinder, 'a');
            expect(find.text(''), findsOne);

            await tester.enterText(textFieldFinder, '1');
            expect(find.text('1'), findsOne);
          },
        );
        testWidgets(
          'should be limited to four digits',
          (tester) async {
            // Act
            await tester.pumpApp(
              child: PokefinderFinder(
                pokemon: Pokemon.empty(),
                onInputChanged: (_) {},
              ),
            );

            // Assert
            final textFieldFinder =
                find.byKey(const ValueKey('pokefinder_finder_id_input'));

            await tester.enterText(textFieldFinder, '12345');
            expect(find.text('1234'), findsOne);
          },
        );
        testWidgets(
          'invokes [onInputChanged] callback with the given input when '
          'text is entered',
          (tester) async {
            // Arrange
            var tValue = '';
            await tester.pumpApp(
              child: PokefinderFinder(
                pokemon: Pokemon.empty(),
                onInputChanged: (value) => tValue = value,
              ),
            );
            final textFieldFinder =
                find.byKey(const ValueKey('pokefinder_finder_id_input'));
            // Act
            await tester.enterText(textFieldFinder, '1');
            // Assert
            expect(tValue, equals('1'));
          },
        );
      });
    },
  );
}
