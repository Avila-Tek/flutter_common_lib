class PokemonEndpoints {
  static String getPokemon(String baseUrl, String id) => '$baseUrl/pokemon/$id';
  static String getPokemons(String baseUrl) => '$baseUrl/pokemon';
}
