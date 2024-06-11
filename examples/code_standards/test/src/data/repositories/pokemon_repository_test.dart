// ignore_for_file: lines_longer_than_80_chars

import 'package:code_standards/core/errors/exceptions.dart';
import 'package:code_standards/core/errors/failure.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api.dart';
import 'package:code_standards/src/data/models/models.dart';
import 'package:code_standards/src/data/repositories/pokemon_repository.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PokemonApiMock extends Mock implements IPokemonApi {}

void main() {
  late IPokemonApi pokemonApi;
  late PokemonRepository repository;

  setUp(() {
    pokemonApi = PokemonApiMock();
    repository = PokemonRepository(pokemonApi: pokemonApi);

    registerFallbackValue(const PokemonApiPageParams.empty());
  });

  group('getPokemon()', () {
    test(
      'should call [IPokemonApi.getPokemon] with the given id and return '
      'a [Pokemon]',
      () async {
        when(() => pokemonApi.getPokemon(any()))
            .thenAnswer((_) async => PokemonModel.empty());

        final response = await repository.getPokemonById(0);

        expect(
          response,
          equals(Right<Failure, PokemonModel>(PokemonModel.empty())),
        );
        verify(() => pokemonApi.getPokemon(0)).called(1);
        verifyNoMoreInteractions(pokemonApi);
      },
    );
    test(
      'should return [Left(ServerFailure())] when the api throws a '
      '[ServerException]',
      () async {
        const tException = ServerException(message: '', statusCode: 0);
        when(() => pokemonApi.getPokemon(any())).thenThrow(tException);

        final response = await repository.getPokemonById(0);

        verify(() => pokemonApi.getPokemon(0)).called(1);
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
      'should return a [List<Pokemon>] on success',
      () async {
        // Arrange
        final tResult = [const PokemonPreviewModel.empty()];

        when(() => pokemonApi.getPokemons(any()))
            .thenAnswer((_) async => tResult);
        when(() => pokemonApi.getPokemon(any()))
            .thenAnswer((_) async => PokemonModel.empty());

        const pageParams = PageParams(page: 0, perPage: 0);

        // Act
        final response = await repository.getPokemons(pageParams);

        // Assert
        expect(response, isA<Right<Failure, List<Pokemon>>>());

        /// NOTE: Because lists are not easily equatable in Dart, we need to use
        /// listEquals to compare the them properly.
        ///
        /// So, in this case, in order to access the result and compare it we
        /// need to use the [fold] method.
        ///
        /// We are not expecting a [Left] response here, so if that happens
        /// we will force test failure.
        response.fold(
          (l) => fail(
            'PokemonApiRest.getPokemons() call failed when it should have succeeded',
          ),
          (r) {
            expect(
              listEquals(r, [PokemonModel.empty()]),
              isTrue,
              reason: 'Response list does not match the expected list',
            );
          },
        );
      },
    );
    test(
      'should call [IPokemonApi.getPokemons] once, and [IPokemonApi.getPokemon] '
      'for each element in the response',
      () async {
        // Arrange
        const tResult = [
          PokemonPreviewModel.empty(),
          PokemonPreviewModel.empty(),
          PokemonPreviewModel.empty(),
        ];
        when(() => pokemonApi.getPokemons(any()))
            .thenAnswer((_) async => tResult);
        when(() => pokemonApi.getPokemon(any()))
            .thenAnswer((_) async => PokemonModel.empty());
        // Act
        await repository.getPokemons(const PageParams.empty());
        // Assert
        verify(() => pokemonApi.getPokemons(any())).called(1);
        // pokemonApi.getPokemon must be called for each element in the list
        verify(() => pokemonApi.getPokemon(any())).called(tResult.length);
        verifyNoMoreInteractions(pokemonApi);
      },
    );

    test(
      'should return [Left(ServerFailure())] when the api throws a ServerException',
      () async {
        const tException = ServerException(message: '', statusCode: 0);

        when(() => pokemonApi.getPokemons(any())).thenThrow(tException);

        const pageParams = PageParams(page: 0, perPage: 0);
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
        const tSeed = 0;
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
