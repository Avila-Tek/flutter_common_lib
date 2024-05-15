import 'package:equatable/equatable.dart';

/// Abstract class that represents the events that can be dispatched
/// to the [PendingNotificationsBloc<T>].
abstract class PendingNotificationsEvent extends Equatable {
  const PendingNotificationsEvent();

  @override
  List<Object?> get props => [];
}

/// Event that triggers the fetching of the pending notifications.
class FetchPendingNotifications<T> extends PendingNotificationsEvent {
  const FetchPendingNotifications({
    this.simulateError = false,
    this.timeInterval = const Duration(seconds: 5),
  });

  /// If true, the [PendingNotificationsBloc<T>] will simulate an error.
  /// This error will not be visible to the user, but it will be logged.
  final bool? simulateError;
  final Duration timeInterval;

  @override
  List<Object?> get props => [simulateError, timeInterval];
}

/// Event that triggers the fetching of the pending notifications.
class RefetchPendingNotifications<T> extends PendingNotificationsEvent {
  const RefetchPendingNotifications({
    this.simulateError = false,
    this.timeInterval = const Duration(seconds: 5),
  });

  /// If true, the [PendingNotificationsBloc<T>] will simulate an error.
  /// This error will not be visible to the user, but it will be logged.
  final bool? simulateError;
  final Duration timeInterval;

  @override
  List<Object?> get props => [simulateError, timeInterval];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is FetchPendingNotifications<T>) {
      return runtimeType == other.runtimeType &&
          simulateError == other.simulateError &&
          timeInterval == other.timeInterval;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(simulateError, timeInterval);
}

/// Event that cancels the fetching of the pending notifications.
class CancelPendingNotifications<T> extends PendingNotificationsEvent {
  const CancelPendingNotifications();

  @override
  List<Object?> get props => [];
}
