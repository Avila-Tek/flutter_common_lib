import 'dart:convert';

import 'package:code_standards/core/typedefs/typedefs.dart';
import 'package:code_standards/src/domain/entities/pokemon_type.dart';

class PokemonTypeModel extends PokemonType {
  const PokemonTypeModel({
    required super.id,
    required super.name,
  });

  factory PokemonTypeModel.fromMap(Map<String, dynamic> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String?;

    return PokemonTypeModel(
      id: id ?? 0,
      name: name ?? 'Unknown',
    );
  }

  factory PokemonTypeModel.fromJson(String source) =>
      PokemonTypeModel.fromMap(json.decode(source) as DataMap);

  DataMap toJson() => <String, dynamic>{'id': id, 'name': name};

  @override
  String toString() => 'PokemonTypeModel(id: $id, name: $name)';
}
