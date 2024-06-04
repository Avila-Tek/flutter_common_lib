import 'dart:math';

import 'package:code_standards/core/core.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api.dart';
import 'package:code_standards/src/data/models/models.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/domain/repositories/pokemon_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class PokemonRepository implements IPokemonRepository {
  const PokemonRepository({required IPokemonApi pokemonApi})
      : _pokemonApi = pokemonApi;

  final IPokemonApi _pokemonApi;

  @override
  ResultFuture<Pokemon> getPokemonById(int id) async {
    try {
      final response = await _pokemonApi.getPokemon(id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(e));
    }
  }

  @override
  ResultFuture<List<Pokemon>> getPokemons(PageParams params) async {
    try {
      final response = await _pokemonApi
          .getPokemons(PokemonApiPageParams.fromEntity(params));

      final pokemons = <Pokemon>[];

      final futures = List<Future<Pokemon>>.generate(
        response.length,
        (i) => _pokemonApi.getPokemon(response[i].id),
      );

      await Future.wait(futures).then((values) {
        for (final value in values) {
          pokemons.add(value);
        }
      });

      return Right(pokemons);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(e));
    }
  }

  @override
  ResultFuture<Pokemon> getRandomPokemon([int? seed]) async =>
      getPokemonById(randomId(seed));

  // 👇 Hard-coding max number of pokemons for ease of demonstration 👇
  // Note: This attribute should be private, but is visible in order to test
  // the repository.
  @visibleForTesting
  int randomId([int? seed]) => Random(seed).nextInt(900);
}
