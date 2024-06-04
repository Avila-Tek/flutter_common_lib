import 'package:code_standards/src/data/models/models.dart';

abstract class IPokemonApi {
  Future<PokemonModel> getPokemon(int id);

  Future<List<PokemonPreviewModel>> getPokemons(PokemonApiPageParams params);
}
