import 'dart:convert';

import 'package:code_standards/core/typedefs/typedefs.dart';
import 'package:code_standards/src/data/models/models.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data_sources/mocks/mock_reader.dart';

void main() {
  late String tJson;
  late PokemonModel tModel;

  setUpAll(() {
    tJson = readMock('pokemon.json');
    tModel = const PokemonModel(
      id: 1,
      name: 'Pikachu',
      order: 5,
      height: 17,
      weight: 50,
      sprite: 'https://pokeapi.co/media/sprites/pokemon/1.png',
    );
  });

  test(
    'should be a subclass of [Pokemon] entity',
    () => expect(tModel, isA<Pokemon>()),
  );

  group('PokemonModel.fromMap()', () {
    test(
      'should return a [PokemonModel] instance with the correct values',
      () {
        expect(
          PokemonModel.fromMap(jsonDecode(tJson) as DataMap),
          equals(tModel),
        );
      },
    );
    test(
      'should handle null or missing values',
      () {
        expect(
          () => PokemonModel.fromMap(const {}),
          returnsNormally,
        );
      },
    );
  });

  group('PokemonModel.fromJson()', () {
    test('should parse [PokemonModel] from json string', () {
      expect(
        PokemonModel.fromJson(tJson),
        equals(tModel),
      );
    });
  });

  group('PokemonModel.toJson()', () {
    test('should return a [DataMap] instance', () {
      final tMap = tModel.toJson();

      expect(tMap, isA<DataMap>());
      expect(tMap, equals(jsonDecode(tJson)));
    });
  });
}
