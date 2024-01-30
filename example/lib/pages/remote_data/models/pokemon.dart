import 'dart:convert';

class Pokemon {
  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.sprite,
  });

  final int id;
  final String name;
  final int height;
  final int weight;
  final String sprite;

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    try {
      return Pokemon(
        id: map['id'] as int,
        name: map['name'] as String,
        height: map['height'] as int,
        weight: map['weight'] as int,
        sprite: map['sprites']['front_default'] ?? '',
      );
    } catch (e) {
      rethrow;
    }
  }

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);
}
