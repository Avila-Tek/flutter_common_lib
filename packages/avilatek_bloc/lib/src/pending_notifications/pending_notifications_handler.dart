import 'package:avilatek_bloc/src/pending_notifications/pending_notifications_event.dart';
import 'package:avilatek_bloc/src/pending_notifications/pending_notifications_state.dart';
import 'package:bloc/bloc.dart';

class PendingNotificationsEventHandler<T> {
  const PendingNotificationsEventHandler();

  /// Handler for [FetchPendingNotifications] + [PendingNotificationsUninitialized] combination.
  /// Handles initial fetch when the pending notifications are not yet present.
  ///
  /// On success it emits: [PendingNotificationsInitialFetching], [PendingNotificationsFetched].
  /// On failure it emits: [PendingNotificationsInitialFetching], [PendingNotificationsInitialFetchingError], [PendingNotificationsUninitialized].
  Future<void> mapInitialFetchPendingNotificationsToState(
    FetchPendingNotifications<T> event,
    PendingNotificationsUninitialized<T> state,
    Emitter<PendingNotificationsState<T>> emit,
    Future<T> Function(
      PendingNotificationsState<T>,
      FetchPendingNotifications<T>,
    ) fetchAndParseData,
  ) async {
    try {
      emit(PendingNotificationsInitialFetching());

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final pendingNotifications = await fetchAndParseData(state, event);

      emit(PendingNotificationsFetched(pendingNotifications));
    } catch (e) {
      emit(PendingNotificationsInitialFetchingError(e));
      emit(PendingNotificationsUninitialized());
    }
  }

  /// Handler for [FetchPendingNotifications] + [PendingNotificationsFetched] combination.
  /// Handles refetch of the pending notifications.
  ///
  /// On success it emits: [PendingNotificationsRefetching], [PendingNotificationsFetched].
  /// On failure it emits: [PendingNotificationsRefetching], [PendingNotificationsRefetchingError], [PendingNotificationsFetched].
  ///
  Future<void> mapRefetchPendingNotificationsToState(
    FetchPendingNotifications<T> event,
    PendingNotificationsFetched<T> state,
    Emitter<PendingNotificationsState<T>> emit,
    Future<T> Function(
      PendingNotificationsState<T>,
      FetchPendingNotifications<T>,
    ) fetchAndParseData,
  ) async {
    try {
      emit(PendingNotificationsRefetching(state));

      if (event.simulateError ?? false) {
        await _simulateError();
      }

      final pendingNotifications = await fetchAndParseData(state, event);
      emit(PendingNotificationsRefetchingSuccess(pendingNotifications));
      emit(PendingNotificationsFetched(pendingNotifications));
    } catch (e) {
      emit(PendingNotificationsRefetchingError(state, e));
      emit(PendingNotificationsFetched.clone(state));
    }
  }

  Future<void> _simulateError() {
    Future<void>.delayed(const Duration(seconds: 1));
    throw Exception('Simulated error');
  }

  /// Handler for [CancelPendingNotifications] + [PendingNotificationsRefetchingCancel]
  /// combination. Handles the cancelation of the refetching of the pending notifications.
  void mapCancelPendingNotificationsToState(
    CancelPendingNotifications<T> event,
    PendingNotificationsRefetchingCancel<T> state,
    Emitter<PendingNotificationsState<T>> emit,
  ) {
    emit(PendingNotificationsRefetchingCancel());
  }
}
