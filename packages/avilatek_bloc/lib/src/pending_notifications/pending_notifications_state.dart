// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

extension PendingNotificationsStateX on PendingNotificationsState<dynamic> {
  /// Returns `true` if the state is not initialized and has no data to show.
  bool get isUnititialized => this is! PendingNotificationsInitialized;

  /// Returns `true` if the state is initialized and has data.
  bool get isInitialized => this is PendingNotificationsInitialized;

  /// Returns `true` if the state is either [PendingNotificationsInitialFetching] or
  /// [PendingNotificationsRefetching].
  bool get isFetching =>
      // this is PendingNotificationsRefetching ||
      this is PendingNotificationsInitialFetching;

  /// Returns `true` if the state is [PendingNotificationsInitialFetching].
  bool get isInitialFetching => this is PendingNotificationsInitialFetching;

  /// Returns `true` if the state is [PendingNotificationsRefetching].
  bool get isRefetching => this is PendingNotificationsRefetching;
}

abstract class PendingNotificationsState<T> extends Equatable {
  const PendingNotificationsState();

  @override
  List<Object?> get props => [];
}

/// Mixin for every [PendingNotificationsState] that represents network activity.
mixin PendingNotificationsFetching<T> on PendingNotificationsState<T> {}

/// Mixin for every [PendingNotificationsState] that represents a temporary success.
mixin PendingNotificationsSuccess<T> on PendingNotificationsState<T> {}

/// Mixin for every [PendingNotificationsState] that represents a temporary error.
mixin PendingNotificationsError<T> on PendingNotificationsState<T> {}

// #####################
// Uninitialized States
// #####################

/// Initial state of the [PendingNotificationsBloc<T>].
class PendingNotificationsUninitialized<T>
    extends PendingNotificationsState<T> {}

/// State that represents the initial fetching of the pending notifications. This state
/// is only emitted once, when the [FetchPendingNotifications<T>] event is dispatched
/// when the [PendingNotificationsBloc<T>] is in the [PendingNotificationsUninitialized] state.
class PendingNotificationsInitialFetching<T>
    extends PendingNotificationsState<T> with PendingNotificationsFetching<T> {}

/// State that represents the initial fetching of the remote data that failed.
///
/// This state is only emitted from the [PendingNotificationsInitialFetching] state.
class PendingNotificationsInitialFetchingError<T>
    extends PendingNotificationsState<T> with PendingNotificationsError<T> {
  ///
  const PendingNotificationsInitialFetchingError(this.error);

  /// The error that caused the fetching to fail.
  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

// ###################
// Initialized States
// ###################

/// Base class for states with fetched data:
/// [PendingNotificationsFetched], [PendingNotificationsRefetching],
/// [PendingNotificationsRefetchingSuccess] and [PendingNotificationsRefetchingError].

/// State that represents the initilized state of the pending notifications.
/// All the subclasses of this class have the [pendingNotifications] property with
/// the fetched data to be displayed even if the refetching fails.
abstract class PendingNotificationsInitialized<T>
    extends PendingNotificationsState<T> {
  const PendingNotificationsInitialized(this.pendingNotifications);

  PendingNotificationsInitialized.clone(
    PendingNotificationsInitialized<T> other,
  ) : this(other.pendingNotifications);

  /// The pending notification information previously fetched.
  /// Its value depends on the entity created by the developer to receive
  /// the pending notifications.
  final T pendingNotifications;

  @override
  List<Object?> get props => [...super.props, pendingNotifications];
}

/// State that represents the success fetching the pending notifications.
class PendingNotificationsFetched<T>
    extends PendingNotificationsInitialized<T> {
  const PendingNotificationsFetched(super.pendingNotifications);
  PendingNotificationsFetched.clone(super.oldState) : super.clone();
}

/// State that represents the refetching of the pending notifications.
class PendingNotificationsRefetching<T>
    extends PendingNotificationsInitialized<T>
    with PendingNotificationsFetching<T> {
  PendingNotificationsRefetching(super.oldState) : super.clone();
}

/// State that represents the refetching of the pending notifications that failed.
class PendingNotificationsRefetchingError<T>
    extends PendingNotificationsInitialized<T>
    with PendingNotificationsError<T> {
  PendingNotificationsRefetchingError(super.oldState, this.error)
      : super.clone();

  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

/// State that represents the successful refetching of the pending notifications.
class PendingNotificationsRefetchingSuccess<T>
    extends PendingNotificationsInitialized<T>
    with PendingNotificationsSuccess<T> {
  const PendingNotificationsRefetchingSuccess(super.pendingNotifications);

  PendingNotificationsRefetchingSuccess.clone(super.oldState) : super.clone();
}

/// State that representes the cancelation of the refetching due to a not authenticated status.
class PendingNotificationsRefetchingCancel<T>
    extends PendingNotificationsUninitialized<T> {}
