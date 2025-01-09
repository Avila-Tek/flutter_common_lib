part of 'package:{{{fullPath}}}/base/{{feature_name.snakeCase()}}_page.dart';

enum _{{feature_name.pascalCase()}}Status { 
  initial, 
  loading, 
  success, 
  failure;

  bool get isInitial => this == _{{feature_name.pascalCase()}}Status.initial;
  bool get isLoading => this == _{{feature_name.pascalCase()}}Status.loading;
  bool get isSuccess => this == _{{feature_name.pascalCase()}}Status.success;
  bool get isFailure => this == _{{feature_name.pascalCase()}}Status.failure;
 }

{{#isDefault}}
/// {@template {{feature_name.snakeCase()}}_state}
/// _{{feature_name.pascalCase()}}State description
/// {@endtemplate}
class _{{feature_name.pascalCase()}}State extends Equatable {
  /// {@macro {{feature_name.snakeCase()}}_state}
  const _{{feature_name.pascalCase()}}State({
    this.status = _{{feature_name.pascalCase()}}Status.initial,
  });

  /// Status of the state
  final _{{feature_name.pascalCase()}}Status status;

  @override
  List<Object> get props => [status];

  /// Creates a copy of the current _{{feature_name.pascalCase()}}State with property changes
  _{{feature_name.pascalCase()}}State copyWith({
    _{{feature_name.pascalCase()}}Status? status,
  }) {
    return _{{feature_name.pascalCase()}}State(
      status: status ?? this.status,
    );
  }
}{{/isDefault}}{{#isTabbed}}
/// {@template {{feature_name.snakeCase()}}_state}
/// _{{feature_name.pascalCase()}}State description
/// {@endtemplate}
class _{{feature_name.pascalCase()}}State extends Equatable {
  /// {@macro {{feature_name.snakeCase()}}_state}
  const _{{feature_name.pascalCase()}}State({
    this.status = _{{feature_name.pascalCase()}}Status.initial,
  });

  /// Status of the state
  final _{{feature_name.pascalCase()}}Status status;

  @override
  List<Object> get props => [status];

  /// Creates a copy of the current _{{feature_name.pascalCase()}}State with property changes
  _{{feature_name.pascalCase()}}State copyWith({
    _{{feature_name.pascalCase()}}Status? status,
  }) {
    return _{{feature_name.pascalCase()}}State(
      status: status ?? this.status,
    );
  }
}{{/isTabbed}}{{#isStepper}}
/// {@template {{feature_name.snakeCase()}}_state}
/// _{{feature_name.pascalCase()}}State description
/// {@endtemplate}
class _{{feature_name.pascalCase()}}State extends Equatable {
  /// {@macro {{feature_name.snakeCase()}}_state}
  const _{{feature_name.pascalCase()}}State({
    this.status = _{{feature_name.pascalCase()}}Status.initial,
    this.step = _{{feature_name.pascalCase()}}Step.{{#children}}{{#isFirst}}{{name.camelCase()}}{{/isFirst}}{{/children}},
    this.currentPageIndex = 0,
  });

  /// Status of the state
  final _{{feature_name.pascalCase()}}Status status;
  final _{{feature_name.pascalCase()}}Step step;
  final int currentPageIndex;

  @override
  List<Object> get props => [status, step, currentPageIndex];

  /// Creates a copy of the current _{{feature_name.pascalCase()}}State with property changes
  _{{feature_name.pascalCase()}}State copyWith({
    _{{feature_name.pascalCase()}}Status? status,
    _{{feature_name.pascalCase()}}Step? step,
    int? currentPageIndex,
  }) {
    return _{{feature_name.pascalCase()}}State(
      status: status ?? this.status,
      step: step ?? this.step,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}{{/isStepper}}
