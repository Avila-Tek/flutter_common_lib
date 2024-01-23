import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:example/pages/remote_data/bloc/pokemon_bloc.dart';
import 'package:example/pages/remote_data/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteDataFetchExamplePage extends StatelessWidget {
  const RemoteDataFetchExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Remote Data Fetch Bloc Example'),
        ),
        body: const _RemoteDataFetchExampleBody(),
      ),
    );
  }
}

class _RemoteDataFetchExampleBody extends StatefulWidget {
  const _RemoteDataFetchExampleBody();

  @override
  State<_RemoteDataFetchExampleBody> createState() =>
      _RemoteDataFetchExampleBodyState();
}

class _RemoteDataFetchExampleBodyState
    extends State<_RemoteDataFetchExampleBody> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller = TextEditingController(
        text: context.read<PokemonBloc>().id.toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, RemoteDataState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state.isUnititialized) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        final pokemon = (state as RemoteDataInitialized<Pokemon>).data;

        return Column(
          children: [
            SizedBox(
              height: 200,
              child: state.isFetching
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Center(child: Image.network(pokemon.sprite, scale: 0.5)),
            ),
            const SizedBox(height: 17),
            const Text('Buscar Pokémon por ID'),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: TextField(
                controller: controller,
                enabled: !state.isFetching,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: state.isFetching
                  ? null
                  : () {
                      context
                          .read<PokemonBloc>()
                          .getPokemonOfId(controller.text);
                    },
              icon: const Icon(Icons.search),
              label: const Text('Buscar'),
            )
          ],
        );
      },
    );
  }
}
