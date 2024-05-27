import 'package:code_standards/src/domain/entities/pokemon_type.dart';
import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  const Pokemon({
    required this.name,
    required this.id,
    required this.height,
    required this.weight,
    required this.order,
    required this.sprite,
    required this.types,
  });

  final String name;
  final int id;
  final int height;
  final int weight;
  final int order;
  final String sprite;
  final List<PokemonType> types;

  @override
  List<Object?> get props => [name, id, height, weight, order, sprite, types];
}
