import 'package:code_standards/src/domain/entities/entities.dart';

class PokemonApiPageParams {
  const PokemonApiPageParams({
    required this.limit,
    required this.offset,
  });

  factory PokemonApiPageParams.fromEntity(PageParams params) {
    return PokemonApiPageParams(
      limit: params.perPage,
      offset: params.page * params.perPage,
    );
  }

  const PokemonApiPageParams.empty() : this(limit: 0, offset: 0);

  final int limit;
  final int offset;

  String toQueryString() => '?limit=$limit&offset=$offset';

  @override
  String toString() => 'PageParams(limit: $limit, offset: $offset)';
}
