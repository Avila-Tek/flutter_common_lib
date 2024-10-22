import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part '{{feature_name.snakeCase()}}_event.dart';
part '{{feature_name.snakeCase()}}_state.dart';
{{#isStepper}}part '{{feature_name.snakeCase()}}_step.dart';{{/isStepper}}

class {{feature_name.pascalCase()}}Bloc extends Bloc<{{feature_name.pascalCase()}}Event, {{feature_name.pascalCase()}}State> {
  {{feature_name.pascalCase()}}Bloc() : super(const {{feature_name.pascalCase()}}State()) {
  {{#isStepper}} on<{{feature_name.pascalCase()}}NextStep>(_on{{feature_name.pascalCase()}}NextStep);
    on<{{feature_name.pascalCase()}}PreviousStep>(
      _on{{feature_name.pascalCase()}}PreviousStep,
    );{{/isStepper}}
  }
  {{#isStepper}}FutureOr<void> _on{{feature_name.pascalCase()}}NextStep(
    {{feature_name.pascalCase()}}NextStep event,
    Emitter<{{feature_name.pascalCase()}}State> emit,
  ) async {
    final nextIndex = state.currentPageIndex + 1;
    final nextStep = event.nextStep ?? state.step.nextStep;

      emit(
        state.copyWith(
          currentPageIndex: nextIndex,
          step: nextStep,
        ),
      );
  }

  FutureOr<void> _on{{feature_name.pascalCase()}}PreviousStep(
    {{feature_name.pascalCase()}}PreviousStep event,
    Emitter<{{feature_name.pascalCase()}}State> emit,
  ) async {
    if (state.currentPageIndex == 0) return;
    final previousIndex = state.currentPageIndex - 1;
    final previousStep = state.step.previousStep;

      emit(
        state.copyWith(
          currentPageIndex: previousIndex,
          step: previousStep,
        ),
      );
  }
  {{/isStepper}}
}
