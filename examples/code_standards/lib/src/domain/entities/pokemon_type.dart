import 'package:equatable/equatable.dart';

class PokemonType extends Equatable {
  const PokemonType({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
