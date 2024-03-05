import 'dart:math' as math;

import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:flutter/material.dart';

class RainbowBloc extends PagedRemoteDataBloc<Color> {
  RainbowBloc() : super() {
    add(const PagedRemoteDataFetchNextPage());
  }

  final int _itemsPerPage = 20;

  @override
  Future<(List<Color>, bool)> fetchAndParseNextPage(
    PagedRemoteDataState oldState,
    PagedRemoteDataFetchNextPage event,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final List<Color> colors = List.generate(_itemsPerPage, (index) {
      return _generateColor();
    });

    // NOTE: Here, you might add your own conditional logic to determine if the
    // the currently fetched page is the last one. For example, you might want
    // to check if the length of the currently fetched page is less than the
    // items per page, or if the length of the currently fetched page plus the
    // length of the old state's data is greater than or equal to the total, or
    // if a boolean value returned from the server indicates that the current
    // page is the last one, etc.

    // In this case, we will assume that the last page is reached when the
    // length of the currently fetched page plus the length of the old state's
    // data is greater than or equal to 100.

    /// We must ensure that [oldState] is of type
    /// [PagedRemoteDataNextPageFetched]. If we are fetching the first page,
    /// [oldState] will be of type [PagedRemoteDataUninitialized] and we won't
    /// be able to access the data property to calculate our condition.
    if (oldState is PagedRemoteDataNextPageFetched) {
      if (oldState.data.length + colors.length >= 60) {
        /// Return true as the second value to indicate that the last page was
        /// fetched.
        return (colors, true);
      }
    }

    /// Return false as the second value to indicate that there are more pages
    return (colors, false);
  }

  Color _generateColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }
}
