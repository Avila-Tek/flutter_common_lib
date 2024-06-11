import 'dart:convert';

import 'package:code_standards/core/typedefs/data_map.dart';
import 'package:code_standards/src/domain/entities/pokemon_preview.dart';

class PokemonPreviewModel extends PokemonPreview {
  const PokemonPreviewModel({
    required super.name,
    required super.url,
  });

  const PokemonPreviewModel.empty() : super(name: '', url: '');

  factory PokemonPreviewModel.fromMap(DataMap map) {
    final name = map['name'] as String?;
    final url = map['url'] as String?;

    return PokemonPreviewModel(
      name: name ?? '',
      url: url ?? '',
    );
  }

  factory PokemonPreviewModel.fromJson(String source) =>
      PokemonPreviewModel.fromMap(json.decode(source) as DataMap);

  int get id => url.isEmpty
      ? 0
      : int.tryParse(url.substring(0, url.length - 1).split('/').last) ?? 0;

  DataMap toJson() => <String, dynamic>{
        'name': name,
        'url': url,
      };
}
