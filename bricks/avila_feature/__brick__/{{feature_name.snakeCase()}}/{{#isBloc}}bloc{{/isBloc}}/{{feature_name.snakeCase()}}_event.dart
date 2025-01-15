part of '{{feature_name.snakeCase()}}_bloc.dart';

abstract class {{feature_name.pascalCase()}}Event {{#use_equatable}} extends Equatable{{/use_equatable}} {
  const {{feature_name.pascalCase()}}Event();
{{#use_equatable}}
  @override
  List<Object> get props => [];
{{/use_equatable}}
}
