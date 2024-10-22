part of '{{feature_name.snakeCase()}}_bloc.dart';

abstract class {{feature_name.pascalCase()}}Event extends Equatable {
  const {{feature_name.pascalCase()}}Event();

  @override
  List<Object?> get props => [];

}

class Custom{{feature_name.pascalCase()}}Event extends {{feature_name.pascalCase()}}Event {
  const Custom{{feature_name.pascalCase()}}Event();
}

{{#isStepper}}class {{feature_name.pascalCase()}}NextStep extends {{feature_name.pascalCase()}}Event {
  const {{feature_name.pascalCase()}}NextStep({
    this.nextStep,
  });

  final {{feature_name.pascalCase()}}Step? nextStep;

  @override
  List<Object?> get props => [nextStep];
}

class {{feature_name.pascalCase()}}PreviousStep extends {{feature_name.pascalCase()}}Event {
  const {{feature_name.pascalCase()}}PreviousStep();
}{{/isStepper}}