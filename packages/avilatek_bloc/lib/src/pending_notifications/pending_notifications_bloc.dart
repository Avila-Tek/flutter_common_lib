// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:avilatek_bloc/src/pending_notifications/pending_notifications_event.dart';
import 'package:avilatek_bloc/src/pending_notifications/pending_notifications_handler.dart';
import 'package:avilatek_bloc/src/pending_notifications/pending_notifications_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

/// Abstract Bloc implementation used to fetch information related
/// to pending notifications.
/// [timeInterval] is the time interval in which the pending notifications
/// will be fetched.
abstract class PendingNotificationsBloc<T>
    extends Bloc<PendingNotificationsEvent, PendingNotificationsState<T>> {
  PendingNotificationsBloc({
    required Duration timeInterval,
  }) : super(PendingNotificationsUninitialized()) {
    _handler = PendingNotificationsEventHandler<T>();
    on<FetchPendingNotifications<T>>(
      _mapFetchPendingNotificationsToState,
    );
    on<CancelPendingNotifications<T>>(
      _mapCancelPendingNotificationsToState,
    );
    //  await subscription?.cancel();
    _subscription = Stream.periodic(timeInterval, (x) {
      add(FetchPendingNotifications<T>());
    }).listen((event) {});
  }
  late PendingNotificationsEventHandler<T> _handler;
  StreamSubscription<void>? _subscription;

  /// Propagates the [FetchPendingNotifications] event down to the corresponding event
  /// handler.
  Future<void> _mapFetchPendingNotificationsToState(
    FetchPendingNotifications<T> event,
    Emitter<PendingNotificationsState<T>> emit,
  ) async {
    return await _handleStatesOnEvent(
      timeInterval: event.timeInterval,
      isNoOp: state is PendingNotificationsFetching ||
          state is PendingNotificationsError ||
          state is PendingNotificationsSuccess,
      onPendingNotificationsUninitialized: () =>
          _handler.mapInitialFetchPendingNotificationsToState(
        event,
        state as PendingNotificationsUninitialized<T>,
        emit,
        fetchAndParseData,
      ),
      onPendingNotificationsFetched: () =>
          _handler.mapRefetchPendingNotificationsToState(
        event,
        state as PendingNotificationsFetched<T>,
        emit,
        fetchAndParseData,
      ),
    );
  }

  /// Helper function that can be used by [_mapFetchPendingNotificationsToState] function
  /// for cleaner propagation of the events to the corresponding event handler.
  FutureOr<void> _handleStatesOnEvent({
    required bool isNoOp,
    required Duration timeInterval,
    Future<void> Function()? onPendingNotificationsUninitialized,
    Future<void> Function()? onPendingNotificationsFetched,
  }) async {
    if (isNoOp) {
      return;
    } else if ((state is PendingNotificationsUninitialized) &&
        onPendingNotificationsUninitialized != null) {
      return onPendingNotificationsUninitialized();
    } else if (state is PendingNotificationsFetched &&
        onPendingNotificationsFetched != null) {
      return onPendingNotificationsFetched();
    } else {
      throw UnimplementedError(
        'No handler implemented for combination: ${state.runtimeType}.',
      );
    }
  }

  Future<void> _mapCancelPendingNotificationsToState(
    CancelPendingNotifications<T> event,
    Emitter<PendingNotificationsState<T>> emit,
  ) async {
    return close();
  }

  /// Function which retrieves the blocs data from the backend,
  /// parses the response and returns the parsed [T] Object.
  /// The [oldState] and thus the old [T] object is also accesible,
  /// if merging of the new and old data is required.
  @visibleForTesting
  Future<T> fetchAndParseData(
    PendingNotificationsState<T> oldState,
    FetchPendingNotifications<T> event,
  );

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
