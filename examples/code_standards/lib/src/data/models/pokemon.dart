import 'dart:convert';

import 'package:code_standards/core/typedefs/typedefs.dart';
import 'package:code_standards/src/data/models/pokemon_type.dart';
import 'package:code_standards/src/domain/entities/entities.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.height,
    required super.weight,
    required super.order,
    required super.sprite,
    required super.types,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String?;
    final height = map['height'] as int?;
    final weight = map['weight'] as int?;
    final order = map['order'] as int?;
    final sprites = (map['sprites'] as List<String>? ?? []).nonNulls;
    final types = (map['types'] as List<DataMap>? ?? []).nonNulls;

    return PokemonModel(
      id: id ?? 1,
      name: name ?? 'Unknown',
      height: height ?? 1,
      weight: weight ?? 1,
      order: order ?? 1,
      sprite: sprites.firstOrNull ?? '',
      types: types.map(PokemonTypeModel.fromMap).toList(),
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
        'sprites': [sprite],
        'types': types.map((e) => (e as PokemonTypeModel).toJson()).toList(),
      };
}
