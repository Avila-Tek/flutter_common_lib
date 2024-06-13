import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  const Pokemon({
    required this.name,
    required this.id,
    required this.height,
    required this.weight,
    required this.order,
    required this.sprite,
    // required this.types,
  });

  Pokemon.empty()
      : this(
          name: '',
          id: 0,
          height: 0,
          weight: 0,
          order: 0,
          sprite: '',
          // types: [],
        );

  final String name;
  final int id;
  final int height;
  final int weight;
  final int order;
  final String sprite;
  // final List<PokemonType> types;

  @override
  List<Object?> get props => [
        name,
        id,
        height,
        weight,
        order,
        sprite,
      ];

  @override
  String toString() => "Pokemon('name': $name, 'id': $id)";
}
