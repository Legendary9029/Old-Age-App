import 'package:flutter/material.dart';

class FinanceWidget extends StatelessWidget {
  final double balance;
  final double expenses;
  final double savings;

  const FinanceWidget({
    super.key,
    required this.balance,
    required this.expenses,
    required this.savings,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Financial Overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _financeDetail("💰 Balance", balance, Colors.green),
            _financeDetail("📉 Expenses", expenses, Colors.red),
            _financeDetail("📈 Savings", savings, Colors.blue),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Action: Navigate to finance screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("View Detailed Report"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _financeDetail(String label, double amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(
            "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
