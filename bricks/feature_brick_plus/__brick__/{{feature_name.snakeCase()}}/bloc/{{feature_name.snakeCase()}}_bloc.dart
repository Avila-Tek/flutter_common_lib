part of 'package:{{{fullPath}}}/base/{{feature_name.snakeCase()}}_page.dart';

class _{{feature_name.pascalCase()}}Bloc extends Bloc<_{{feature_name.pascalCase()}}Event, _{{feature_name.pascalCase()}}State> {
  _{{feature_name.pascalCase()}}Bloc() : super(const _{{feature_name.pascalCase()}}State()) {
  {{#isStepper}} on<_{{feature_name.pascalCase()}}NextStep>(_on{{feature_name.pascalCase()}}NextStep);
    on<_{{feature_name.pascalCase()}}PreviousStep>(
      _on{{feature_name.pascalCase()}}PreviousStep,
    );{{/isStepper}}
  }
  {{#isStepper}}void _on{{feature_name.pascalCase()}}NextStep(
    _{{feature_name.pascalCase()}}NextStep event,
    Emitter<_{{feature_name.pascalCase()}}State> emit,
  ) {
    final nextIndex = state.currentPageIndex + 1;
    final nextStep = event.nextStep ?? state.step.nextStep;

      emit(
        state.copyWith(
          currentPageIndex: nextIndex,
          step: nextStep,
        ),
      );
  }

  void _on{{feature_name.pascalCase()}}PreviousStep(
    _{{feature_name.pascalCase()}}PreviousStep event,
    Emitter<_{{feature_name.pascalCase()}}State> emit,
  ) {
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
