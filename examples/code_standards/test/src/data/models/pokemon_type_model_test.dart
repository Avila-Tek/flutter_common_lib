import 'dart:convert';

import 'package:code_standards/src/data/models/models.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data_sources/mocks/mock_reader.dart';

void main() {
  late String tJson;

  late PokemonTypeModel tModel;

  setUpAll(() {
    tJson = readMock('pokemon_type.json');
    tModel = const PokemonTypeModel(id: 1, name: 'Electric');
  });

  test('should be a subclass of [PokemonType] entity', () {
    expect(
      tModel,
      isA<PokemonType>(),
    );
  });

  group('fromMap', () {
    test('should return a [PokemonTypeModel] with the correct values', () {
      expect(tModel, isA<PokemonTypeModel>());

      expect(
        PokemonTypeModel.fromMap(const {'id': 1, 'name': 'Electric'}),
        equals(tModel),
      );
    });

    test('should handle null values', () {
      expect(() => PokemonTypeModel.fromMap(const {}), returnsNormally);
    });
  });
  group('fromJson', () {
    test('should parse [PokemonTypeModel] from json string', () {
      expect(PokemonTypeModel.fromJson(tJson), equals(tModel));
    });
  });

  group('toJson', () {
    test('should return json string', () {
      expect(tModel.toJson(), equals(jsonDecode(tJson)));
    });
  });

  group('toString', () {
    test("should return [PokemonTypeModel]'s string representation", () {
      expect(tModel.toString(), 'PokemonTypeModel(id: 1, name: Electric)');
    });
  });
}
