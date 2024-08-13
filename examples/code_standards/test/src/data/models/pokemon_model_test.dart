import 'dart:convert';

import 'package:code_standards/core/typedefs/typedefs.dart';
import 'package:code_standards/src/data/models/models.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data_sources/mocks/mock_reader.dart';

void main() {
  test(
    'should be a subclass of [Pokemon] entity',
    () => expect(PokemonModel.empty(), isA<Pokemon>()),
  );

  group('PokemonModel.fromMap()', () {
    test(
      'should create a [PokemonModel] instance with the given values',
      () {
        // Arrange
        final tJson = readMock('pokemon.json');
        // Act
        final tModel = PokemonModel.fromMap(jsonDecode(tJson) as DataMap);
        // Assert
        expect(
          tModel,
          equals(
            const PokemonModel(
              id: 1,
              name: 'name',
              order: 1,
              height: 1,
              weight: 1,
              sprite: 'sprite',
            ),
          ),
        );

        /// NOTE that we are using "non-minimal values" on this test.
        ///
        /// This is
        /// because we want to make sure that the values assigned to the
        /// resulting object come from the passed json instead of the fallback
        /// values defined inside the method, which are 0's and empty strings.
      },
    );
    test(
      'should return [PokemonModel] with default values on null or missing '
      'fields',
      () {
        expect(
          () => PokemonModel.fromMap(const {}),
          returnsNormally,
        );
      },
    );
  });

  group('PokemonModel.fromJson()', () {
    test('should parse json string and return a [PokemonModel]', () {
      // Arrange
      final tJson = readMock('pokemon.json');
      // Act
      final tModel = PokemonModel.fromJson(tJson);
      // Assert
      expect(
        tModel,
        equals(
          const PokemonModel(
            id: 1,
            name: 'name',
            order: 1,
            height: 1,
            weight: 1,
            sprite: 'sprite',
          ),
        ),
      );
    });
  });

  group('PokemonModel.toJson()', () {
    test('should convert a [PokemonModel] object to a [DataMap]', () {
      // Arrange
      final tJson = readMock('pokemon.json');
      final tModel = PokemonModel.fromMap(jsonDecode(tJson) as DataMap);
      // Act
      final tMap = tModel.toJson();
      // Assert
      expect(tMap, isA<DataMap>());
      expect(tMap, equals(jsonDecode(tJson)));
    });
  });
}
