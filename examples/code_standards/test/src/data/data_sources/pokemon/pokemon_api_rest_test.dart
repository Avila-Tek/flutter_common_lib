// ignore_for_file: lines_longer_than_80_chars

import 'package:avilatek_test/avilatek_test.dart';
import 'package:code_standards/core/core.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api_rest.dart';
import 'package:code_standards/src/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client client;
  late PokemonApiRest api;

  const baseUrl = 'https://mock.api';

  setUp(() {
    client = MockHttpClient();
    api = PokemonApiRest(baseUrl: baseUrl, client: client);

    registerFallbackValue(FakeUri());
  });

  test(
    'should be subclass of IPokemonApi',
    () => expect(PokemonApiRest(baseUrl: baseUrl), isA<IPokemonApi>()),
  );

  test('should check that [baseUrl] is valid', () {
    TestHelpers.checkRestApiUrl((apiUrl) => PokemonApiRest(baseUrl: apiUrl));
  });

  group('PokemonApiRest.getPokemons()', () {
    test('should return a [List<PokemonPreview>] when response code is 2xx',
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('{"results": []}', 200));

      final response = await api
          .getPokemons(const PokemonApiPageParams(limit: 0, offset: 0));

      expect(response, equals([]));
    });

    test(
        'should make the GET request with the given [limit] and [offset] '
        'parameters in the query string and be called only once', () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('{"results": []}', 200));

      await api.getPokemons(const PokemonApiPageParams(limit: 0, offset: 0));

      verify(
        () => client.get(
          any<Uri>(
            that: equals(Uri.parse('$baseUrl/pokemon?limit=0&offset=0')),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw a [ServerException] when status code is not 2xx',
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('', 400));

      expect(
        () async =>
            api.getPokemons(const PokemonApiPageParams(limit: 0, offset: 0)),
        throwsA(const ServerException(message: '', statusCode: 400)),
      );

      verify(() => client.get(any<Uri>())).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw an [UnknownException] on unexpected thrown errors',
        () async {
      final tException = Exception('');
      when(() => client.get(any())).thenThrow(tException);

      expect(
        () async =>
            api.getPokemons(const PokemonApiPageParams(limit: 0, offset: 0)),
        throwsA(UnknownException(error: tException)),
      );
    });
  });

  group('PokemonApiRest.getPokemon()', () {
    test('should return [PokemonModel] when response code is 2xx', () async {
      // Arrange
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('{}', 200));
      // Act
      final response = await api.getPokemon(0);
      // Assert
      expect(response, isA<PokemonModel>());

      /// NOTE that we are not testing the [PokemonModel] attributes. That is
      /// responsibility of the [PokemonModel] tests. We just need to make sure
      /// that the method is returning the expected instance.
    });
    test(
        'should make the GET request with the given id and be called only once',
        () async {
      // Arrange
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('{}', 200));
      // Act
      await api.getPokemon(0);
      // Assert
      verify(() => client.get(Uri.parse('$baseUrl/pokemon/0'))).called(1);
      verifyNoMoreInteractions(client);
    });
    test('should throw an [ServerException] when status code is not 2xx',
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('', 400));

      expect(
        () async => api.getPokemon(0),
        throwsA(const ServerException(message: '', statusCode: 400)),
      );
    });
    test('should throw an [UnknownException] on unexpected thrown errors',
        () async {
      final tException = Exception('');
      when(() => client.get(any())).thenThrow(Exception(''));

      expect(
        () async => api.getPokemon(0),
        throwsA(UnknownException(error: tException)),
      );
    });
  });
}
