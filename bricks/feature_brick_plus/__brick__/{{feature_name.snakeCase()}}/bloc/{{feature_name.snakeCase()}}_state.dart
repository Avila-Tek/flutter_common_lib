part of '{{feature_name.snakeCase()}}_bloc.dart';

{{#isConventional}}enum {{feature_name.pascalCase()}}Status { 
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
class {{feature_name.pascalCase()}}State extends Equatable {
  /// {@macro {{feature_name.snakeCase()}}_state}
  const {{feature_name.pascalCase()}}State({
    this.status = {{feature_name.pascalCase()}}Status.initial,
  });

  /// Status of the state
  final {{feature_name.pascalCase()}}Status status;

  @override
  List<Object> get props => [status];

  /// Creates a copy of the current {{feature_name.pascalCase()}}State with property changes
  {{feature_name.pascalCase()}}State copyWith({
    {{feature_name.pascalCase()}}Status? status,
  }) {
    return {{feature_name.pascalCase()}}State(
      status: status ?? this.status,
    );
  }
}{{/isConventional}}{{#isTabbed}}
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
class {{feature_name.pascalCase()}}State extends Equatable {
  /// {@macro {{feature_name.snakeCase()}}_state}
  const {{feature_name.pascalCase()}}State({
    this.status = {{feature_name.pascalCase()}}Status.initial,
  });

  /// Status of the state
  final {{feature_name.pascalCase()}}Status status;

  @override
  List<Object> get props => [status];

  /// Creates a copy of the current {{feature_name.pascalCase()}}State with property changes
  {{feature_name.pascalCase()}}State copyWith({
    {{feature_name.pascalCase()}}Status? status,
  }) {
    return {{feature_name.pascalCase()}}State(
      status: status ?? this.status,
    );
  }
}{{/isTabbed}}{{#isStepper}}
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
class {{feature_name.pascalCase()}}State extends Equatable {
  /// {@macro {{feature_name.snakeCase()}}_state}
  const {{feature_name.pascalCase()}}State({
    this.status = {{feature_name.pascalCase()}}Status.initial,
    this.step = {{feature_name.pascalCase()}}Step.{{#children}}{{#isFirst}}{{name.camelCase()}}{{/isFirst}}{{/children}},
    this.currentPageIndex = 0,
  });

  /// Status of the state
  final {{feature_name.pascalCase()}}Status status;
  final {{feature_name.pascalCase()}}Step step;
  final int currentPageIndex;

  @override
  List<Object> get props => [status, step, currentPageIndex];

  /// Creates a copy of the current {{feature_name.pascalCase()}}State with property changes
  {{feature_name.pascalCase()}}State copyWith({
    {{feature_name.pascalCase()}}Status? status,
    {{feature_name.pascalCase()}}Step? step,
    int? currentPageIndex,
  }) {
    return {{feature_name.pascalCase()}}State(
      status: status ?? this.status,
      step: step ?? this.step,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}{{/isStepper}}
