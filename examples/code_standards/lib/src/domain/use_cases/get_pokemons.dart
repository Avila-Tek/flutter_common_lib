// ignore_for_file: avoid_renaming_method_parameters

import 'package:code_standards/core/interfaces/use_case.dart';
import 'package:code_standards/core/typedefs/response.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/domain/repositories/repositories.dart';

class GetPokemonsUseCase extends UseCaseWithParams<List<Pokemon>, PageParams> {
  GetPokemonsUseCase(IPokemonRepository repository) : _repository = repository;

  final IPokemonRepository _repository;

  @override
  ResultFuture<List<Pokemon>> call(PageParams params) =>
      _repository.getPokemons(params);
}
