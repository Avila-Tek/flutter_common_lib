part of '{{feature_name.snakeCase()}}_bloc.dart';

enum {{feature_name.pascalCase()}}Status { 
  initial, 
  loading, 
  success, 
  failure;

  bool get isInitial => this == {{feature_name.pascalCase()}}Status.initial;
  bool get isLoading => this == {{feature_name.pascalCase()}}Status.loading;
  bool get isSuccess => this == {{feature_name.pascalCase()}}Status.success;
  bool get isFailure => this == {{feature_name.pascalCase()}}Status.failure;
 }

/// {@template {{feature_name.snakeCase()}}_state}
/// {{feature_name.pascalCase()}}State description
/// {@endtemplate}
class {{feature_name.pascalCase()}}State{{#use_equatable}} extends Equatable{{/use_equatable}} {
  /// {@macro {{feature_name.snakeCase()}}_state}
  const {{feature_name.pascalCase()}}State({
    this.status = {{feature_name.pascalCase()}}Status.initial,
  });

  /// Status of the state
  final {{feature_name.pascalCase()}}Status status;
{{#use_equatable}}
  @override
  List<Object> get props => [status];
{{/use_equatable}}
  /// Creates a copy of the current {{feature_name.pascalCase()}}State with property changes
  {{feature_name.pascalCase()}}State copyWith({
    {{feature_name.pascalCase()}}Status? status,
  }) {
    return {{feature_name.pascalCase()}}State(
      status: status ?? this.status,
    );
  }
}
