// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:avilatek_test/avilatek_test.dart';
import 'package:code_standards/core/core.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api_rest.dart';
import 'package:code_standards/src/data/models/models.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client client;
  late String baseUrl;
  late String tPokemonsResponse;
  late String tPokemonResponse;

  setUpAll(() {
    baseUrl = 'https://pokeapi.co/api/v2';
    client = MockHttpClient();
    tPokemonsResponse = File('test/src/data/data_sources/mocks/pokemons.json')
        .readAsStringSync();
    tPokemonResponse = File('test/src/data/data_sources/mocks/pokemon.json')
        .readAsStringSync();

    registerFallbackValue(FakeUri());
  });
  test(
    'should be subclass of IPokemonApi',
    () => expect(PokemonApiRest(baseUrl: baseUrl), isA<IPokemonApi>()),
  );

  test('should check baseUrl is valid', () {
    TestHelpers.checkRestApiUrl((apiUrl) => PokemonApiRest(baseUrl: apiUrl));
  });

  group('PokemonApiRest.getPokemons()', () {
    test('should return [Right<Failure, List<PokemonModel>>]', () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(tPokemonsResponse, 200));

      final pokemonApiRest = PokemonApiRest(baseUrl: baseUrl, client: client);

      final response = await pokemonApiRest.getPokemons();

      verify(() => client.get(any<Uri>())).called(1);
      verifyNoMoreInteractions(client);

      expect(
        response,
        isA<Right<Failure, List<Pokemon>>>(),
      );

      response.fold(
        (l) => fail(
          'PokemonApiRest.getPokemons() call failed when it should have succeeded',
        ),
        (r) {
          expect(r.length, 5);
          expect(r[2].name, 'Squirtle');
        },
      );
    });
    test('should return [Left<Failure, List<PokemonModel>>]', () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('', 404));

      final pokemonApiRest = PokemonApiRest(baseUrl: baseUrl, client: client);

      final response = await pokemonApiRest.getPokemons();

      verify(() => client.get(any<Uri>())).called(1);
      verifyNoMoreInteractions(client);

      expect(
        response,
        isA<Left<Failure, List<Pokemon>>>(),
      );

      response.fold(
        (l) {
          expect(l.message, 'Failed to get Pokemons');
          expect(l.statusCode, 404);
        },
        (r) {
          fail(
            'PokemonApiRest.getPokemons() was expected to return a [Left] response but it returned a [Right] response',
          );
        },
      );
    });
  });

  group('PokemonApiRest.getPokemon()', () {
    test('should return [Right<Failure, PokemonModel>]', () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(tPokemonResponse, 200));

      final pokemonApiRest = PokemonApiRest(baseUrl: baseUrl, client: client);

      final response = await pokemonApiRest.getPokemon(31);

      verify(
        () => client.get(
          any<Uri>(
            that: predicate((uri) => uri.toString().endsWith('pokemon/31')),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);

      expect(response, isA<Right<Failure, PokemonModel>>());

      response.fold(
        (l) => fail(
          'PokemonApiRest.getPokemons() call failed when it should have succeeded',
        ),
        (r) => expect(r.name, 'Pikachu'),
      );
    });
    test('should return [Left<Failure, PokemonModel>]', () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('', 404));

      final pokemonApiRest = PokemonApiRest(baseUrl: baseUrl, client: client);

      final response = await pokemonApiRest.getPokemon(7);

      verify(
        () => client.get(
          any<Uri>(
            that: predicate((uri) => uri.toString().endsWith('pokemon/7')),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);

      expect(response, isA<Left<Failure, PokemonModel>>());

      response.fold(
        (l) {
          expect(l.message, 'Failed to get Pokemon #7');
          expect(l.statusCode, 404);
        },
        (r) => fail(
          'PokemonApiRest.getPokemon() was expected to return a [Left] response but it returned a [Right] response',
        ),
      );
    });
  });
}
