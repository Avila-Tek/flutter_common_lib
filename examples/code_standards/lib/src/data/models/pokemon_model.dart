import 'dart:convert';

import 'package:code_standards/core/typedefs/typedefs.dart';
import 'package:code_standards/src/domain/entities/entities.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.height,
    required super.weight,
    required super.order,
    required super.sprite,
    // required super.types,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String?;
    final height = map['height'] as int?;
    final weight = map['weight'] as int?;
    final order = map['order'] as int?;

    // ignore: avoid_dynamic_calls
    final sprite = map['sprites']?['front_default'] as String?;

    return PokemonModel(
      id: id ?? 0,
      name: name ?? 'Unknown',
      height: height ?? 0,
      weight: weight ?? 0,
      order: order ?? 0,
      sprite: sprite ?? '',
    );
  }

  factory PokemonModel.fromJson(String source) =>
      PokemonModel.fromMap(json.decode(source) as DataMap);

  DataMap toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'height': height,
        'weight': weight,
        'order': order,
        'sprites': {
          'front_default': sprite,
        },
        // 'types': types.map((e) => (e as PokemonTypeModel).toJson()).toList(),
      };

  // ignore: prefer_constructors_over_static_methods
  static PokemonModel empty() => const PokemonModel(
        id: 0,
        name: '',
        height: 0,
        weight: 0,
        order: 0,
        sprite: '',
        // types: [],
      );
}
