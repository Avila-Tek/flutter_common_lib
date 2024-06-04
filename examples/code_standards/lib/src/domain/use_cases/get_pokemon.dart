// ignore_for_file: avoid_renaming_method_parameters

import 'package:code_standards/core/interfaces/use_case.dart';
import 'package:code_standards/core/typedefs/response.dart';
import 'package:code_standards/src/domain/entities/pokemon.dart';
import 'package:code_standards/src/domain/repositories/repositories.dart';

class GetPokemonUseCase extends UseCaseWithParams<Pokemon, int> {
  GetPokemonUseCase(IPokemonRepository repository) : _repository = repository;

  final IPokemonRepository _repository;

  @override
  ResultFuture<Pokemon> call(int id) => _repository.getPokemonById(id);
}
