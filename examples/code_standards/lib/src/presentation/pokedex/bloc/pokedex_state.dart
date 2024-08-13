part of 'pokedex_bloc.dart';

enum PokedexStatus { 
  initial, 
  loading, 
  success, 
  failure;

  bool get isInitial => this == PokedexStatus.initial;
  bool get isLoading => this == PokedexStatus.loading;
  bool get isSuccess => this == PokedexStatus.success;
  bool get isFailure => this == PokedexStatus.failure;
 }

/// {@template pokedex_state}
/// PokedexState description
/// {@endtemplate}
class PokedexState extends Equatable {
  /// {@macro pokedex_state}
  const PokedexState({
    this.status = PokedexStatus.initial,
  });

  /// Status of the state
  final PokedexStatus status;

  @override
  List<Object> get props => [status];

  /// Creates a copy of the current PokedexState with property changes
  PokedexState copyWith({
    PokedexStatus? status,
  }) {
    return PokedexState(
      status: status ?? this.status,
    );
  }
}
