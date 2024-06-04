// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:example/pages/pending_notifications/bloc/notification_bell_bloc.dart';
import 'package:example/pages/pending_notifications/models/pending_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingNotificationsExamplePage extends StatelessWidget {
  const PendingNotificationsExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            NotificationBellBloc(timeInterval: const Duration(seconds: 30)),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pending Notifications Example'),
          ),
          body: const PendingNotificationsExampleView(),
        ));
  }
}

class PendingNotificationsExampleView extends StatelessWidget {
  const PendingNotificationsExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PendingNotificationsExampleBody();
  }
}

class PendingNotificationsExampleBody extends StatelessWidget {
  const PendingNotificationsExampleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBellBloc, PendingNotificationsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state.isUnititialized) {
          return const Center(
            child: NotificationBellWidget(
              hasNotifications: false,
            ),
          );
        }

        if (state.isFetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final notificationInformation =
            (state as PendingNotificationsInitialized<PendingNotification>)
                .pendingNotifications;
        final timesFetched = context.read<NotificationBellBloc>().timesFetched;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NotificationBellWidget(
                hasNotifications: notificationInformation.hasNotifications,
                notificationCount: notificationInformation.count,
              ),
              Text(
                notificationInformation.hasNotifications
                    ? 'You have ${notificationInformation.count} pending notifications'
                    : 'You have no pending notifications',
                style: TextStyle(
                  color: notificationInformation.hasNotifications
                      ? Colors.deepPurple
                      : Colors.grey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text('Times Fetched: $timesFetched'),
            ],
          ),
        );
      },
    );
  }
}

class NotificationBellWidget extends StatelessWidget {
  const NotificationBellWidget({
    Key? key,
    this.notificationCount = 0,
    this.hasNotifications = false,
  }) : super(key: key);

  final int? notificationCount;
  final bool hasNotifications;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        Icon(
          hasNotifications ? Icons.notifications : Icons.notifications_none,
          color: hasNotifications ? Colors.deepPurple : Colors.grey,
          size: 60,
        ),
        if (hasNotifications)
          Positioned(
            right: 2,
            top: 5,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              constraints: const BoxConstraints(
                minWidth: 25,
                minHeight: 25,
              ),
              child: Text(
                notificationCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
