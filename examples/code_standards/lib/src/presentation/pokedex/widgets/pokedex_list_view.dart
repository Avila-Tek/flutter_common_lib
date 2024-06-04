import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:code_standards/src/domain/entities/entities.dart';
import 'package:code_standards/src/presentation/pokedex/pokedex.dart';
import 'package:flutter/material.dart';

class PokedexListView extends StatefulWidget {
  const PokedexListView({
    required this.state,
    required this.onRetry,
    super.key,
  });

  final PagedRemoteDataInitialized<Pokemon> state;
  final VoidCallback onRetry;

  @override
  State<PokedexListView> createState() => _PokedexListViewState();
}

class _PokedexListViewState extends State<PokedexListView> {
  final _controller = ScrollController();

  static const _bottomTreshold = 0.95;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.addListener(() {
        final hasReachedTreshold = _controller.position.pixels >=
            _controller.position.maxScrollExtent * _bottomTreshold;

        if (_controller.hasClients && hasReachedTreshold) {
          context.read<PokedexBloc>().add(const PagedRemoteDataFetchNextPage());
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.data.isEmpty) {
      return const PokedexEmpty();
    }

    return ListView.builder(
      controller: _controller,
      itemCount:
          widget.state.data.length + 1, // +1 for the 'Loading' or 'Error' item
      itemBuilder: (context, i) {
        if (i == widget.state.data.length) {
          return _lastWidget();
        }

        return PokemonListTile(pokemon: widget.state.data[i]);
      },
    );
  }

  Widget _lastWidget() {
    if (widget.state.isFetchingNextPageError) {
      return PokedexErrorListTile(onRetry: widget.onRetry);
    }

    if (widget.state.isFetchingNextPage) {
      return const PokedexLoadingListTile();
    }

    return const SizedBox(
      key: ValueKey('pokedex_list_view_empty_space'),
    );
  }
}
