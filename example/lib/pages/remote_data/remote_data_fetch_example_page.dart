import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:example/pages/remote_data/bloc/pokemon_bloc.dart';
import 'package:example/pages/remote_data/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteDataFetchExamplePage extends StatelessWidget {
  const RemoteDataFetchExamplePage({
    this.simulateInitialFetchingError = false,
    super.key,
  });

  final bool simulateInitialFetchingError;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc(
        simulateInitialFetchingError: simulateInitialFetchingError,
      ),
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
    return BlocConsumer<PokemonBloc, RemoteDataState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is RemoteDataRefetchingSuccess) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(content: Text('Pokemon refetched successfully')),
            );
        }

        if (state is RemoteDataRefetchingFailed) {
          // NOTE: [RemoteDataRefetchingFailed] state does not prevent the app to display the current data.
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: const Text('Error refetching Pokémon'),
                backgroundColor: Colors.red.shade600,
              ),
            );
        }
      },
      builder: (context, state) {
        return BlocBuilder<PokemonBloc, RemoteDataState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state.isUnititialized) {
              /// This is a transition state when the bloc is intialized.
              /// But, if a [RemoteDataInitialFetchingError] state is emitted,
              /// it will go back to [RemoteDataUninitialized] state. Thus, we
              /// want to display the failure recovery option here.

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed loading Pokémon'),
                    TextButton(
                      onPressed: () {
                        context
                            .read<PokemonBloc>()
                            .add(const FetchRemoteData<Pokemon>());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state.isInitialFetching) {
              /// We show a loading indicator when loading the first time.
              /// If the initial fetching fails, the bloc will go back to the
              /// [RemoteDataUninitialized] state, showing the failure recovery
              /// option.
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            /// At this point, the bloc is initialized and the data is available.
            ///
            /// If we refetch the data and get an error, we can keep displaying
            /// the old data.
            ///
            /// Even when refetching is in progress, we can keep the old data
            /// being displayed.

            final pokemon = (state as RemoteDataInitialized<Pokemon>).data;

            return Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Center(
                    /// NOTE: While refetching, we can still display the old
                    /// data. We change the opacity to give some kind of
                    /// feedback that there is a refetching in progress, but
                    /// view's content is still kept visible.
                    child: Opacity(
                      opacity: state.isRefetching ? 0.5 : 1,
                      child: Image.network(
                        pokemon.sprite,
                        scale: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                const Text('Search Pokémon by ID'),
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
                  label: const Text('Search'),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: state.isFetching
                      ? null
                      : () {
                          // NOTE: The event simulates an error using the [simulateError] property of [FetchRemoteData<T>] event.
                          context.read<PokemonBloc>().add(
                                const FetchRemoteData<Pokemon>(
                                  simulateError: true,
                                ),
                              );
                        },
                  icon: const Icon(Icons.error),
                  label: const Text('Simulate refetching error'),
                ),
                const Spacer(),
                TextButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red.shade600,
                  ),
                  onPressed: state.isFetching
                      ? null
                      : () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RemoteDataFetchExamplePage(
                                simulateInitialFetchingError: true,
                              ),
                            ),
                          );
                        },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Simulate initial fetching error'),
                ),
                const SizedBox(height: 64),
              ],
            );
          },
        );
      },
    );
  }
}
