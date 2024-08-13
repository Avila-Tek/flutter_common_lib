import 'dart:convert';

import 'package:avilatek_core/avilatek_core.dart';
import 'package:code_standards/core/core.dart';
import 'package:code_standards/core/extensions/int_extensions.dart';
import 'package:code_standards/src/data/data_sources/pokemon/endpoints.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api.dart';
import 'package:code_standards/src/data/models/models.dart';
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
  Future<PokemonModel> getPokemon(int id) async {
    try {
      final response = await _client.get(
        Uri.parse(PokemonEndpoints.getPokemon(_baseUrl, id.toString())),
      );

      if (response.statusCode.isSuccessful) {
        return PokemonModel.fromJson(response.body);
      }

      throw ServerException(
        message: response.body,
        statusCode: response.statusCode,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw UnknownException(error: e);
    }
  }

  @override
  Future<List<PokemonPreviewModel>> getPokemons(
    PokemonApiPageParams params,
  ) async {
    try {
      final response = await _client.get(
        Uri.parse(
          PokemonEndpoints.getPokemons(_baseUrl) + params.toQueryString(),
        ),
      );

      if (response.statusCode.isSuccessful) {
        final body = jsonDecode(response.body) as DataMap;

        final pokemons = (body['results'] as List<dynamic>)
            .map((e) => PokemonPreviewModel.fromMap(e as DataMap))
            .toList();

        return pokemons;
      }

      throw ServerException(
        message: response.body,
        statusCode: response.statusCode,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw UnknownException(error: e);
    }
  }
}
