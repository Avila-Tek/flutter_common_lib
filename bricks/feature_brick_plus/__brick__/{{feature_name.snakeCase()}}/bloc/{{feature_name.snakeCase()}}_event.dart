part of 'package:{{{fullPath}}}/base/{{feature_name.snakeCase()}}_page.dart';

abstract class _{{feature_name.pascalCase()}}Event extends Equatable {
  const _{{feature_name.pascalCase()}}Event();

  @override
  List<Object?> get props => [];

}

class _Custom{{feature_name.pascalCase()}}Event extends _{{feature_name.pascalCase()}}Event {
  const _Custom{{feature_name.pascalCase()}}Event();
}

{{#isStepper}}class _{{feature_name.pascalCase()}}NextStep extends _{{feature_name.pascalCase()}}Event {
  const _{{feature_name.pascalCase()}}NextStep({
    this.nextStep,
  });

  final _{{feature_name.pascalCase()}}Step? nextStep;

  @override
  List<Object?> get props => [nextStep];
}

class _{{feature_name.pascalCase()}}PreviousStep extends _{{feature_name.pascalCase()}}Event {
  const _{{feature_name.pascalCase()}}PreviousStep();
}{{/isStepper}}