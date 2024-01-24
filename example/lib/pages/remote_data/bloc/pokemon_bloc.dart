// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:example/pages/remote_data/models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonBloc extends RemoteDataBloc<Pokemon> {
  PokemonBloc({
    int initialPokemonId = 1,
    bool simulateInitialFetchingError = false,
  }) : _id = initialPokemonId {
    add(FetchRemoteData<Pokemon>(simulateError: simulateInitialFetchingError));
  }

  int get id => _id;
  int _id = 3;

  void getPokemonOfId(String id) {
    _id = int.tryParse(id) ?? 1;

    add(const FetchRemoteData<Pokemon>());
  }

  @override
  Future<Pokemon> fetchAndParseData(
    RemoteDataState oldState,
    FetchRemoteData event,
  ) async {
    final Uri uri = Uri.parse('https://pokeapi.co/api/v2/pokemon/$_id/');

    final response = await http.get(uri);

    final pokemon = Pokemon.fromJson(response.body);
    return pokemon;
  }
}
