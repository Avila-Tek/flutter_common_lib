part of 'pokefinder_bloc.dart';

enum PokefinderStatus { 
  initial, 
  loading, 
  success, 
  failure;

  bool get isInitial => this == PokefinderStatus.initial;
  bool get isLoading => this == PokefinderStatus.loading;
  bool get isSuccess => this == PokefinderStatus.success;
  bool get isFailure => this == PokefinderStatus.failure;
 }

/// {@template pokefinder_state}
/// PokefinderState description
/// {@endtemplate}
class PokefinderState extends Equatable {
  /// {@macro pokefinder_state}
  const PokefinderState({
    this.status = PokefinderStatus.initial,
  });

  /// Status of the state
  final PokefinderStatus status;

  @override
  List<Object> get props => [status];

  /// Creates a copy of the current PokefinderState with property changes
  PokefinderState copyWith({
    PokefinderStatus? status,
  }) {
    return PokefinderState(
      status: status ?? this.status,
    );
  }
}
