import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextOfKinScreen extends StatefulWidget {
  const NextOfKinScreen({super.key});

  @override
  State<NextOfKinScreen> createState() => _NextOfKinScreenState();
}

class _NextOfKinScreenState extends State<NextOfKinScreen> {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  DateTime? lastCheckedIn;
  bool checkedIn = false;
  static const Duration checkInInterval = Duration(hours: 12);

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadLastCheckIn();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: androidInit);
    await notificationsPlugin.initialize(initSettings);
  }

  Future<void> _sendCheckInReminder() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'check_in_channel',
      'Daily Check-In',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(0, 'Check-In Reminder', 'Please confirm your well-being.', platformDetails);
  }

  Future<void> _scheduleCheckInReminder() async {
    await notificationsPlugin.zonedSchedule(
      0,
      'Check-In Reminder',
      'Please confirm your well-being.',
      DateTime.now().add(checkInInterval).toUtc(), // Schedule for the future
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'check_in_channel',
          'Daily Check-In',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> _checkIn() async {
    setState(() {
      checkedIn = true;
      lastCheckedIn = DateTime.now();
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastCheckedIn', lastCheckedIn.toString());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Check-in confirmed. Next of Kin notified.")),
    );

    _scheduleCheckInReminder();
  }

  Future<void> _loadLastCheckIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastCheckInString = prefs.getString('lastCheckedIn');

    if (lastCheckInString != null) {
      setState(() {
        lastCheckedIn = DateTime.parse(lastCheckInString);
        checkedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Next of Kin Check")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              lastCheckedIn == null
                  ? "You haven't checked in yet."
                  : "Last Check-In: ${lastCheckedIn!.toLocal()}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkIn,
              child: const Text("✅ Check-In Now"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scheduleCheckInReminder,
              child: const Text("🔔 Schedule Daily Check-In"),
            ),
          ],
        ),
      ),
    );
  }
}
