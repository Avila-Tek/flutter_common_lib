import 'dart:convert';

class PendingNotification {
  const PendingNotification({
    required this.count,
    required this.hasNotifications,
  });

  final int count;
  final bool hasNotifications;

  factory PendingNotification.fromMap(Map<String, dynamic> map) {
    try {
      return PendingNotification(
        count: map['count'] as int,
        hasNotifications: map['hasNotifications'] as bool,
      );
    } catch (e) {
      rethrow;
    }
  }

  factory PendingNotification.fromJson(String source) =>
      PendingNotification.fromMap(json.decode(source) as Map<String, dynamic>);
}
