part of 'pokerandomizer_bloc.dart';

enum PokerandomizerStatus { 
  initial, 
  loading, 
  success, 
  failure;

  bool get isInitial => this == PokerandomizerStatus.initial;
  bool get isLoading => this == PokerandomizerStatus.loading;
  bool get isSuccess => this == PokerandomizerStatus.success;
  bool get isFailure => this == PokerandomizerStatus.failure;
 }

/// {@template pokerandomizer_state}
/// PokerandomizerState description
/// {@endtemplate}
class PokerandomizerState extends Equatable {
  /// {@macro pokerandomizer_state}
  const PokerandomizerState({
    this.status = PokerandomizerStatus.initial,
  });

  /// Status of the state
  final PokerandomizerStatus status;

  @override
  List<Object> get props => [status];

  /// Creates a copy of the current PokerandomizerState with property changes
  PokerandomizerState copyWith({
    PokerandomizerStatus? status,
  }) {
    return PokerandomizerState(
      status: status ?? this.status,
    );
  }
}
