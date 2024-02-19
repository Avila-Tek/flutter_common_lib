import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:example/pages/remote_data_paginated/bloc/rainbow_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RainbowPage extends StatelessWidget {
  const RainbowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RainbowBloc(),
      child: const RainbowView(),
    );
  }
}

class RainbowView extends StatefulWidget {
  const RainbowView({
    super.key,
  });

  @override
  State<RainbowView> createState() => _RainbowViewState();
}

class _RainbowViewState extends State<RainbowView>
    with SingleTickerProviderStateMixin {
  final _controller = ScrollController();

  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat(reverse: true);

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent * 0.95) {
        context.read<RainbowBloc>().add(const PagedRemoteDataFetchNextPage());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rainbow Page'),
      ),
      body: BlocBuilder<RainbowBloc, PagedRemoteDataState<Color>>(
        builder: (context, state) {
          if (state.isUnititialized) {
            // If uninitialized (fetching first page), we will show a loading
            // indicator.
            // You might want to handle errors here, but for the sake of the
            // example, we will omit that.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// From now on, we can assume that the state is initialized (has data available)
          /// and we can safely cast the state to `PagedRemoteDataInitialized<Color>`.
          final data = (state as PagedRemoteDataInitialized<Color>).data;

          return ListView.builder(
            controller: _controller,
            // Plus 1 to append widgets to the end of the ListView
            itemCount: data.length + 1,
            itemBuilder: (_, i) {
              var isLastItem = i == data.length;

              if (isLastItem) {
                if (state.isFetchingNextPage) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: animationController.drive(
                          ColorTween(
                            begin: Colors.red,
                            end: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (state.isFetchingNextPageError) {
                  return Center(
                    child: Column(
                      children: [
                        const Text('Error fetching next page'),
                        TextButton(
                          onPressed: () {
                            context
                                .read<RainbowBloc>()
                                .add(const PagedRemoteDataFetchNextPage());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                if (state.isLastPageFetched) {
                  return const ListTile(
                    title: Center(child: Text('End of the rainbow 🌈')),
                    minVerticalPadding: 50,
                  );
                }
                return Container();
              }

              return ListTile(
                tileColor: data[i],
                minVerticalPadding: 50,
              );
            },
          );
        },
      ),
    );
  }
}
