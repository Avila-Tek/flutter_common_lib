import 'dart:math';

import 'package:code_standards/core/typedefs/response.dart';
import 'package:code_standards/src/data/data_sources/pokemon/pokemon_api.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/domain/repositories/pokemon.repository.dart';

class PokemonRepository implements IPokemonRepository {
  const PokemonRepository({required IPokemonApi pokemonApi})
      : _pokemonApi = pokemonApi;

  final IPokemonApi _pokemonApi;

  @override
  ResultFuture<Pokemon> getPokemonById(int id) async =>
      _pokemonApi.getPokemon(id);

  @override
  ResultFuture<List<Pokemon>> getPokemons(PageParams params) async =>
      _pokemonApi.getPokemons();

  @override
  ResultFuture<Pokemon> getRandomPokemon() async =>
      getPokemonById(_getRandomPokemonId);

  // 👇 Hard-coding max number of pokemons for ease of demonstration 👇
  int get _getRandomPokemonId => Random().nextInt(900);
}
