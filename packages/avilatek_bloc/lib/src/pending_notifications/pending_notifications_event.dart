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
  });

  /// If true, the [PendingNotificationsBloc<T>] will simulate an error.
  /// This error will not be visible to the user, but it will be logged.
  final bool? simulateError;

  @override
  List<Object?> get props => [simulateError];
}
