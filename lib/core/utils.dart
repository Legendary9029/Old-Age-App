import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Formats DateTime objects into readable strings
String formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
}

/// Formats DateTime to display only the time (e.g., "08:30 AM")
String formatTime(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime);
}

/// Validates email input
bool isValidEmail(String email) {
  final RegExp emailRegex =
  RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  return emailRegex.hasMatch(email);
}

/// Displays a local notification (Used for check-ins, SOS alerts, etc.)
Future<void> showNotification({
  required FlutterLocalNotificationsPlugin notificationsPlugin,
  required String title,
  required String body,
  String channelId = "default_channel",
}) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'default_channel',
    'General Notifications',
    importance: Importance.high,
    priority: Priority.high,
  );
  const NotificationDetails platformDetails =
  NotificationDetails(android: androidDetails);

  await notificationsPlugin.show(0, title, body, platformDetails);
}
