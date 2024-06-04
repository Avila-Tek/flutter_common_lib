import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:code_standards/core/constants.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/domain/use_cases/get_pokemons.dart';
import 'package:equatable/equatable.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends PagedRemoteDataBloc<Pokemon> {
  PokedexBloc({
    required GetPokemonsUseCase getPokemons,
  }) : _getPokemons = getPokemons {
    add(const PagedRemoteDataFetchNextPage());
  }

  final GetPokemonsUseCase _getPokemons;

  static const _pageSize = Consts.pageLimit;

  @override
  Future<(List<Pokemon>, bool)> fetchAndParseNextPage(
    PagedRemoteDataState<Pokemon> oldState,
    PagedRemoteDataFetchNextPage event,
  ) async {
    var page = 0;

    if (oldState is PagedRemoteDataInitialized<Pokemon>) {
      page = (oldState as PagedRemoteDataInitialized).data.length ~/ _pageSize;
    }

    final response = await _getPokemons(
      PageParams(
        page: page,
        perPage: _pageSize,
      ),
    );

    return response.fold(
      (l) => throw l,
      (r) {
        final isLastPage = r.length < _pageSize;

        return (r, isLastPage);
      },
    );
  }
}
