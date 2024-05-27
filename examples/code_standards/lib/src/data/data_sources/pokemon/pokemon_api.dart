import 'package:code_standards/core/typedefs/typedefs.dart';
import 'package:code_standards/src/data/models/models.dart';

abstract class IPokemonApi {
  ResultFuture<PokemonModel> getPokemon(int id);

  ResultFuture<List<PokemonModel>> getPokemons();
}
