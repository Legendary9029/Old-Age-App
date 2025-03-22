import 'package:flutter/material.dart';

class DailyAssistanceScreen extends StatefulWidget {
  const DailyAssistanceScreen({super.key});

  @override
  State<DailyAssistanceScreen> createState() => _DailyAssistanceScreenState();
}

class _DailyAssistanceScreenState extends State<DailyAssistanceScreen> {
  final List<Map<String, dynamic>> tasks = [
    {"time": "08:00 AM", "task": "Take Blood Pressure Medicine", "done": false},
    {"time": "10:30 AM", "task": "Doctor Appointment", "done": false},
    {"time": "05:00 PM", "task": "Evening Walk", "done": false},
  ];

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index]["done"] = !tasks[index]["done"];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  Future<void> _showTaskForm() async {
    String task = "";
    TimeOfDay selectedTime = const TimeOfDay(hour: 12, minute: 0);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Task Description"),
              onChanged: (val) => task = val,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (pickedTime != null) {
                  setState(() => selectedTime = pickedTime);
                }
              },
              child: const Text("Pick Time"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                String formattedTime = selectedTime.format(context);
                tasks.add({"time": formattedTime, "task": task, "done": false});
              });
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Assistance")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Today's Tasks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  var task = tasks[index];
                  return Card(
                    child: ListTile(
                      title: Text(task["task"],
                          style: TextStyle(
                              decoration: task["done"] ? TextDecoration.lineThrough : TextDecoration.none)),
                      subtitle: Text("Time: ${task["time"]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: task["done"],
                            onChanged: (_) => _toggleTaskCompletion(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTask(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showTaskForm,
              child: const Text("➕ Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
