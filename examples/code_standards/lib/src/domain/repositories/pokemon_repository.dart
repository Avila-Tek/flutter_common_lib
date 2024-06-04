import 'package:code_standards/core/typedefs/response.dart';
import 'package:code_standards/src/domain/entities/paged_params.dart';
import 'package:code_standards/src/domain/entities/pokemon.dart';

abstract class IPokemonRepository {
  ResultFuture<Pokemon> getPokemonById(int id);

  ResultFuture<List<Pokemon>> getPokemons(PageParams request);

  ResultFuture<Pokemon> getRandomPokemon();
}
