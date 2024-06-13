import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/domain/use_cases/get_pokemon.dart';
import 'package:equatable/equatable.dart';

part 'pokefinder_event.dart';
part 'pokefinder_state.dart';

class PokefinderBloc extends RemoteDataBloc<Pokemon> {
  PokefinderBloc({
    required GetPokemonUseCase getPokemon,
    int? initialValue,
  })  : _getPokemon = getPokemon,
        _id = initialValue ?? 1 {
    add(const FetchRemoteData());
  }

  final GetPokemonUseCase _getPokemon;

  int _id;
  String get id => _id.toString();

  set id(String value) {
    if (value.isEmpty) return;
    _id = int.tryParse(value) ?? 1;
    add(const FetchRemoteData());
  }

  @override
  Future<Pokemon> fetchAndParseData(
    RemoteDataState<Pokemon> oldState,
    FetchRemoteData event,
  ) async {
    final result = await _getPokemon(_id);

    return result.fold(
      (l) => throw l,
      (r) => r,
    );
  }
}
