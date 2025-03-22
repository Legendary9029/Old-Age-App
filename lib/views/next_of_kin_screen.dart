import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NextOfKinScreen extends StatefulWidget {
  const NextOfKinScreen({super.key});

  @override
  State<NextOfKinScreen> createState() => _NextOfKinScreenState();
}

class _NextOfKinScreenState extends State<NextOfKinScreen> {
  Timer? _alertTimer;
  bool _isOkay = true;
  DateTime? _lastCheckIn;
  int _alertInterval = 30; // Default alert interval (minutes)

  // List of emergency contacts (Can be expanded)
  final List<String> emergencyContacts = ["+911234567890", "+919876543210"];

  @override
  void initState() {
    super.initState();
    _loadLastCheckIn();
    _startStatusCheckTimer();
  }

  void _startStatusCheckTimer() {
    _alertTimer?.cancel();
    _alertTimer = Timer(Duration(minutes: _alertInterval), () {
      if (!_isOkay) {
        _sendAlert();
      }
    });
  }

  void _confirmStatus() async {
    setState(() {
      _isOkay = true;
      _lastCheckIn = DateTime.now();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_check_in', _lastCheckIn!.toIso8601String());
    _startStatusCheckTimer();
    _showMessage("Status Confirmed", "Thank you! Your next of kin will not be alerted.");
  }

  Future<void> _loadLastCheckIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastCheckInStr = prefs.getString('last_check_in');
    if (lastCheckInStr != null) {
      setState(() {
        _lastCheckIn = DateTime.parse(lastCheckInStr);
      });
    }
  }

  void _sendAlert() async {
    String message = "🚨 ALERT! 🚨\nNo response detected. Please check on your loved one!";
    bool smsSent = false;

    for (String contact in emergencyContacts) {
      Uri smsUri = Uri.parse("sms:$contact?body=${Uri.encodeComponent(message)}");
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
        smsSent = true;
      }
    }

    if (!smsSent) {
      _showMessage("Alert Failed", "SMS could not be sent. Consider using another communication method.");
    } else {
      _showMessage("Alert Sent", "Next of Kin has been notified!");
    }
  }

  void _updateAlertInterval(int minutes) {
    setState(() {
      _alertInterval = minutes;
    });
    _startStatusCheckTimer();
  }

  void _showMessage(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _alertTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Next of Kin Status Check")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isOkay ? "Status: ✅ OK" : "Status: ⚠️ Not Confirmed",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _lastCheckIn != null
                  ? "Last Check-in: ${_lastCheckIn!.toLocal()}"
                  : "No Check-in Recorded",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("I'M OK", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            const SizedBox(height: 20),
            DropdownButton<int>(
              value: _alertInterval,
              items: [15, 30, 45, 60]
                  .map((e) => DropdownMenuItem<int>(value: e, child: Text("$e minutes")))
                  .toList(),
              onChanged: (value) {
                if (value != null) _updateAlertInterval(value);
              },
              hint: const Text("Set Alert Interval"),
            ),
          ],
        ),
      ),
    );
  }
}
