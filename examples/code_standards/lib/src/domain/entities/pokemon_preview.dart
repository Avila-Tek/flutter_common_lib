import 'package:equatable/equatable.dart';

class PokemonPreview extends Equatable {
  const PokemonPreview({
    required this.name,
    required this.url,
  });

  const PokemonPreview.empty() : this(name: '', url: '');

  final String name;
  final String url;

  @override
  List<Object?> get props => [name, url];
}
