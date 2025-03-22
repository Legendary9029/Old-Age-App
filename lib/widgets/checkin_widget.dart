import 'package:flutter/material.dart';

class CheckInWidget extends StatelessWidget {
  final VoidCallback onCheckIn;
  final bool isCheckedIn;

  const CheckInWidget({
    super.key,
    required this.onCheckIn,
    required this.isCheckedIn,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isCheckedIn ? null : onCheckIn, // Disable button if already checked in
      style: ElevatedButton.styleFrom(
        backgroundColor: isCheckedIn ? Colors.grey : Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
      child: Text(isCheckedIn ? "Checked In ✔" : "Check-In Now"),
    );
  }
}
