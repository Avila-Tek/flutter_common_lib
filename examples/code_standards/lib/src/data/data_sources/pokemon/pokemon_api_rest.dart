import 'dart:convert';

import 'package:avilatek_core/avilatek_core.dart';
import 'package:code_standards/core/core.dart';
import 'package:code_standards/src/data/data_sources/pokemon/endpoints.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api.dart';
import 'package:code_standards/src/data/models/pokemon.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class PokemonApiRest implements IPokemonApi {
  PokemonApiRest({
    required String baseUrl,
    http.Client? client,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl {
    CommonAssertions.assertUrlIsHttpOrHttps(_baseUrl);
  }

  final http.Client _client;
  final String _baseUrl;

  @override
  ResultFuture<PokemonModel> getPokemon(int id) async {
    try {
      final response = await _client.get(
        Uri.parse(PokemonEndpoints.getPokemon(_baseUrl, id.toString())),
      );

      if (response.statusCode == 200) {
        return Right(PokemonModel.fromJson(response.body));
      }

      return Left(
        Failure(
          message: 'Failed to get Pokemon #$id',
          statusCode: response.statusCode,
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(error: e));
    }
  }

  @override
  ResultFuture<List<PokemonModel>> getPokemons() async {
    try {
      final response = await _client.get(
        Uri.parse(PokemonEndpoints.getPokemons(_baseUrl)),
      );

      if (response.statusCode == 200) {
        final pokemons = (jsonDecode(response.body) as List<dynamic>)
            .map((e) => PokemonModel.fromMap(e as DataMap))
            .toList();

        return Right(pokemons);
      }

      return Left(
        Failure(
          message: 'Failed to get Pokemons',
          statusCode: response.statusCode,
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(error: e));
    }
  }
}
