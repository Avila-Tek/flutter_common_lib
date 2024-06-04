// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:code_standards/core/errors/exceptions.dart';
import 'package:code_standards/core/errors/failure.dart';
import 'package:code_standards/core/typedefs/data_map.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api.dart';
import 'package:code_standards/src/data/models/models.dart';
import 'package:code_standards/src/data/repositories/pokemon_repository.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data_sources/mocks/mock_reader.dart';

class PokemonApiMock extends Mock implements IPokemonApi {}

void main() {
  late IPokemonApi pokemonApi;
  late PokemonRepository repository;
  late ServerException tException;
  late List<PokemonPreviewModel> tPokemons;

  setUp(() {
    pokemonApi = PokemonApiMock();
    repository = PokemonRepository(pokemonApi: pokemonApi);
    tException =
        const ServerException(message: 'Server error', statusCode: 500);

    tPokemons =
        // ignore: avoid_dynamic_calls
        (jsonDecode(readMock('pokemons.json'))['results'] as List<dynamic>)
            .map((e) => PokemonPreviewModel.fromMap(e as DataMap))
            .toList();

    registerFallbackValue(const PokemonApiPageParams.empty());
  });

  group('getPokemon()', () {
    test(
      'should call [IPokemonApi.getPokemon] with the correct id and return [Pokemon]',
      () async {
        when(() => pokemonApi.getPokemon(any()))
            .thenAnswer((_) async => PokemonModel.empty());

        final response = await repository.getPokemonById(1);

        expect(
          response,
          equals(Right<Failure, PokemonModel>(PokemonModel.empty())),
        );

        verify(() => pokemonApi.getPokemon(1)).called(1);
        verifyNoMoreInteractions(pokemonApi);
      },
    );
    test(
      'should return [Left(ServerFailure())] when the api throws a ServerException',
      () async {
        when(() => pokemonApi.getPokemon(any())).thenThrow(tException);

        final response = await repository.getPokemonById(1);

        verify(() => pokemonApi.getPokemon(1)).called(1);
        verifyNoMoreInteractions(pokemonApi);

        expect(
          response,
          equals(
            Left<Failure, PokemonModel>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
      },
    );
  });

  group('getPokemons()', () {
    test(
      'should call [IPokemonApi.getPokemons], and then [IPokemonApi.getPokemon] '
      'for each element in the response, and then return a [List<Pokemon>]',
      () async {
        final tResult = tPokemons.map((e) => PokemonModel.empty()).toList();

        when(() => pokemonApi.getPokemons(any()))
            .thenAnswer((_) async => tPokemons);
        when(() => pokemonApi.getPokemon(any()))
            .thenAnswer((_) async => PokemonModel.empty());

        const pageParams = PageParams(page: 1, perPage: 10);
        final response = await repository.getPokemons(pageParams);

        expect(response, isA<Right<Failure, List<Pokemon>>>());

        /// NOTE: Because lists are not easily equatable in Dart, we need to use
        /// listEquals to compare the them properly.
        ///
        /// So, in this case, in order to access the result and compare it we
        /// need to use the [fold] method.
        ///
        /// We are not expecting a [Left] response here, so if that happens
        /// we will fail the test.
        response.fold(
          (l) => fail(
            'PokemonApiRest.getPokemons() call failed when it should have succeeded',
          ),
          (r) {
            expect(
              listEquals(r, tResult),
              isTrue,
              reason: 'Response list does not match the expected list',
            );
          },
        );

        verify(() => pokemonApi.getPokemons(any())).called(1);
        // pokemonApi.getPokemon must be called for each element in the list
        verify(() => pokemonApi.getPokemon(any())).called(tPokemons.length);

        verifyNoMoreInteractions(pokemonApi);
      },
    );

    test(
      'should return [Left(ServerFailure())] when the api throws a ServerException',
      () async {
        when(() => pokemonApi.getPokemons(any())).thenThrow(tException);

        const pageParams = PageParams(page: 1, perPage: 10);
        final response = await repository.getPokemons(pageParams);

        verify(() => pokemonApi.getPokemons(any())).called(1);
        verifyNoMoreInteractions(pokemonApi);

        expect(
          response,
          equals(
            Left<Failure, List<Pokemon>>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
      },
    );
  });

  group('getRandomPokemon()', () {
    test(
      'should call [IPokemonApi.getRandomPokemon] the random generated id',
      () async {
        const tSeed = 1923662128266128;
        final expectedId = repository.randomId(tSeed);

        when(() => pokemonApi.getPokemon(any()))
            .thenAnswer((_) async => PokemonModel.empty());

        await repository.getRandomPokemon(tSeed);

        verify(() => pokemonApi.getPokemon(expectedId)).called(1);
        verifyNoMoreInteractions(pokemonApi);
      },
    );
  });
}
