import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final List<Map<String, dynamic>> transactions = [
    {"date": "2025-03-10", "desc": "Grocery Shopping", "amount": 50.0, "category": "Food"},
    {"date": "2025-03-12", "desc": "Pharmacy", "amount": 20.0, "category": "Health"},
    {"date": "2025-03-14", "desc": "Online Scam Detected", "amount": 500.0, "fraud": true, "category": "Security"},
  ];

  double monthlyBudget = 300.0;
  double totalSpent = 0.0;
  final Map<String, double> categoryTotals = {};

  @override
  void initState() {
    super.initState();
    _calculateSpending();
  }

  void _calculateSpending() {
    double sum = 0.0;
    categoryTotals.clear();
    for (var trans in transactions) {
      sum += trans["amount"];
      String category = trans["category"] ?? "Other";
      categoryTotals[category] = (categoryTotals[category] ?? 0) + trans["amount"];
    }
    setState(() => totalSpent = sum);
  }

  void _showTransactionForm() {
    String desc = "";
    double amount = 0.0;
    String selectedCategory = "Food";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Transaction"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Description"),
              onChanged: (val) => desc = val,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              onChanged: (val) => amount = double.tryParse(val) ?? 0.0,
            ),
            DropdownButton<String>(
              value: selectedCategory,
              items: ["Food", "Health", "Bills", "Entertainment", "Other"]
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) => selectedCategory = val ?? "Other",
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                transactions.add({
                  "date": "2025-03-15",
                  "desc": desc,
                  "amount": amount,
                  "category": selectedCategory
                });
                _calculateSpending();
              });
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _showSecurityAlert() {
    String pin = "";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("⚠️ Suspicious Activity!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("An unusual transaction was detected. Enter PIN to verify."),
            TextField(
              decoration: const InputDecoration(labelText: "Enter PIN"),
              obscureText: true,
              onChanged: (val) => pin = val,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ignore")),
          TextButton(
            onPressed: () {
              if (pin == "1234") {
                _showMessage("✅ Verified", "Fraud alert has been addressed.");
              } else {
                _showMessage("❌ Incorrect PIN", "Please try again.");
              }
              Navigator.pop(context);
            },
            child: const Text("Verify"),
          ),
        ],
      ),
    );
  }

  void _showBudgetEditDialog() {
    double newBudget = monthlyBudget;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Set Monthly Budget"),
        content: TextField(
          decoration: const InputDecoration(labelText: "New Budget"),
          keyboardType: TextInputType.number,
          onChanged: (val) => newBudget = double.tryParse(val) ?? monthlyBudget,
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => monthlyBudget = newBudget);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
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
  Widget build(BuildContext context) {
    bool overBudget = totalSpent > monthlyBudget;
    return Scaffold(
      appBar: AppBar(title: const Text("Finance & Security")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Monthly Budget", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _showBudgetEditDialog,
                ),
              ],
            ),
            Text("\$${monthlyBudget.toStringAsFixed(2)} (Spent: \$${totalSpent.toStringAsFixed(2)})",
                style: TextStyle(fontSize: 16, color: overBudget ? Colors.red : Colors.green)),
            const SizedBox(height: 10),

            const Text("Expense Breakdown", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: categoryTotals.entries.map((entry) {
                    return PieChartSectionData(
                      value: entry.value,
                      title: entry.key,
                      color: _getCategoryColor(entry.key),
                    );
                  }).toList(),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  var trans = transactions[index];
                  return Card(
                    color: trans["fraud"] == true ? Colors.red[100] : Colors.white,
                    child: ListTile(
                      title: Text(trans["desc"]),
                      subtitle: Text(trans["date"]),
                      trailing: Text("\$${trans["amount"].toStringAsFixed(2)}",
                          style: TextStyle(
                              color: trans["fraud"] == true ? Colors.red : Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        if (trans["fraud"] == true) _showSecurityAlert();
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: _showTransactionForm, child: const Text("➕ Add Expense")),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Food": return Colors.blue;
      case "Health": return Colors.green;
      case "Bills": return Colors.orange;
      case "Entertainment": return Colors.purple;
      default: return Colors.grey;
    }
  }
}
