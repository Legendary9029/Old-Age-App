import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import '../services/sos_service.dart';

class SOSScreen extends StatefulWidget {
  @override
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  bool isSending = false;
  int countdown = 5;
  Timer? timer;

  void _startCountdown() {
    setState(() => isSending = true);
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (countdown > 1) {
          countdown--;
        } else {
          _sendSOS();
          t.cancel();
        }
      });
    });
  }

  Future<void> _sendSOS() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    await SOSService.sendSOSAlert(position.latitude, position.longitude);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('SOS Alert Sent!')),
    );

    setState(() {
      isSending = false;
      countdown = 5;
    });
  }

  void _cancelSOS() {
    timer?.cancel();
    setState(() {
      isSending = false;
      countdown = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency SOS')),
      body: Center(
        child: isSending
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sending in $countdown...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cancelSOS,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: Text('Cancel'),
            ),
          ],
        )
            : ElevatedButton(
          onPressed: _startCountdown,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Text('Send SOS Alert'),
        ),
      ),
    );
  }
}
