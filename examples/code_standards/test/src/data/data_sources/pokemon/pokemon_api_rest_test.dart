// ignore_for_file: lines_longer_than_80_chars

import 'package:avilatek_test/avilatek_test.dart';
import 'package:code_standards/core/core.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api_rest.dart';
import 'package:code_standards/src/data/models/models.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client client;
  late PokemonApiRest api;

  late String tPokemonsJson;
  late String tPokemonJson;

  const baseUrl = 'https://mock.api';

  setUpAll(() {
    tPokemonsJson = readMock('pokemons.json');
    tPokemonJson = readMock('pokemon.json');
  });

  setUp(() {
    client = MockHttpClient();
    api = PokemonApiRest(baseUrl: baseUrl, client: client);

    registerFallbackValue(FakeUri());
  });

  test(
    'should be subclass of IPokemonApi',
    () => expect(PokemonApiRest(baseUrl: baseUrl), isA<IPokemonApi>()),
  );

  test('should check that[baseUrl] is valid', () {
    TestHelpers.checkRestApiUrl((apiUrl) => PokemonApiRest(baseUrl: apiUrl));
  });

  /// We use this list of codes to test each function with 2xx responses easily.
  final mock200Codes = <int>[200, 201, 250, 299];

  group('PokemonApiRest.getPokemons()', () {
    test('should include [limit] and [offset] parameters in the query string',
        () async {
      for (final code in mock200Codes) {
        when(() => client.get(any()))
            .thenAnswer((_) async => http.Response(tPokemonsJson, code));

        await api.getPokemons(const PokemonApiPageParams(limit: 2, offset: 10));

        verify(
          () => client.get(
            any<Uri>(
              that: equals(Uri.parse('$baseUrl/pokemon?limit=2&offset=10')),
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      }
    });

    test('should return a [List<PokemonPreview>] when response code is 2xx',
        () async {
      for (final code in mock200Codes) {
        when(() => client.get(any()))
            .thenAnswer((_) async => http.Response(tPokemonsJson, code));

        final response = await api
            .getPokemons(const PokemonApiPageParams(limit: 2, offset: 10));

        verify(() => client.get(any<Uri>())).called(1);
        verifyNoMoreInteractions(client);

        expect(response, isA<List<PokemonPreview>>());

        expect(response.length, 5);
      }
    });

    test('should throw a [ServerException] when status code is not 2xx',
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Error', 404));

      expect(
        () async =>
            api.getPokemons(const PokemonApiPageParams(limit: 2, offset: 10)),
        throwsA(const ServerException(message: 'Error', statusCode: 404)),
      );

      verify(() => client.get(any<Uri>())).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw an [UnknownException] on unexpected errors', () async {
      final tException = Exception('Unexpected error');
      when(() => client.get(any())).thenThrow(tException);

      expect(
        () async =>
            api.getPokemons(const PokemonApiPageParams(limit: 2, offset: 10)),
        throwsA(UnknownException(error: tException)),
      );
    });
  });

  group('PokemonApiRest.getPokemon()', () {
    test('should return [PokemonModel] when response code is 2xx', () async {
      for (final code in mock200Codes) {
        when(() => client.get(any()))
            .thenAnswer((_) async => http.Response(tPokemonJson, code));

        final response = await api.getPokemon(31);

        verify(() => client.get(Uri.parse('$baseUrl/pokemon/31'))).called(1);
        verifyNoMoreInteractions(client);

        expect(response, isA<PokemonModel>());
        expect(response, PokemonModel.fromJson(tPokemonJson));
      }
    });
    test('should throw an [ServerException] when status code is not 2xx',
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Error', 404));

      expect(
        () async => api.getPokemon(7),
        throwsA(const ServerException(message: 'Error', statusCode: 404)),
      );

      verify(() => client.get(Uri.parse('$baseUrl/pokemon/7'))).called(1);
      verifyNoMoreInteractions(client);
    });
    test('should throw an [UnknownException] on unexpected errors', () async {
      final tException = Exception('Unexpected error');
      when(() => client.get(any())).thenThrow(tException);

      expect(
        () async => api.getPokemon(1),
        throwsA(UnknownException(error: tException)),
      );
    });
  });
}
