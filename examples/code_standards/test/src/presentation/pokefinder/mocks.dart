import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/domain/repositories/repositories.dart';
import 'package:code_standards/src/presentation/pokefinder/pokefinder.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepository extends Mock implements IPokemonRepository {}

class MockPokefinderBloc extends Mock implements PokefinderBloc {}

class MockPokefinderState extends Mock implements RemoteDataState<Pokemon> {}

class MockRemoteDataError extends Mock implements RemoteDataError<Pokemon> {}

class MockRemoteDataRefetching extends Mock
    implements RemoteDataRefetching<Pokemon> {
  @override
  Pokemon get data => Pokemon.empty();
}
