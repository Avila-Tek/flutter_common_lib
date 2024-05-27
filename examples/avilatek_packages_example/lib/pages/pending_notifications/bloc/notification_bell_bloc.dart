import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:example/pages/pending_notifications/models/pending_notification.dart';
import 'package:http/http.dart' as http;

class NotificationBellBloc
    extends PendingNotificationsBloc<PendingNotification> {
  NotificationBellBloc({
    bool simulateError = false,
    Duration timeInterval = const Duration(minutes: 1),
  }) : super(timeInterval: timeInterval) {
    add(FetchPendingNotifications<PendingNotification>(
      simulateError: simulateError,
      timeInterval: timeInterval,
    ));
  }

  int get timesFetched => _timesFetched;
  int _timesFetched = 0;

  @override
  Future<PendingNotification> fetchAndParseData(
      PendingNotificationsState<PendingNotification> oldState,
      FetchPendingNotifications<PendingNotification> event) async {
    _timesFetched++;
    final Uri uri = Uri.parse(
        'https://my.api.mockaroo.com/pending-notifications?key=6c251f20');
    final response = await http.get(uri);

    final pendingNotifications = PendingNotification.fromJson(response.body);

    return pendingNotifications;
  }
}
