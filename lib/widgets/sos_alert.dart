import 'package:flutter/material.dart';

class SOSAlert extends StatelessWidget {
  final VoidCallback onPressed;

  const SOSAlert({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.red.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Emergency Alert",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Press the button below to send an SOS alert to your emergency contacts.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.warning_amber_rounded),
              label: const Text("Send SOS"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
