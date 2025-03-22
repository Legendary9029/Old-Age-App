import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: androidInit);

    await _notificationsPlugin.initialize(initSettings);
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'general_channel',
      'General Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(0, title, body, platformDetails);
  }

  Future<void> scheduleDailyCheckInReminder() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'check_in_channel',
      'Daily Check-In Reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.periodicallyShow(
      1,
      'Daily Check-In',
      'Please check in to confirm your well-being.',
      RepeatInterval.daily,
      platformDetails,
    );
  }
}
