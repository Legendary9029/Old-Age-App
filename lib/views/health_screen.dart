import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  double heartRate = 72;
  double bloodPressure = 120;
  double oxygenLevel = 98;
  Timer? _vitalTimer;

  final List<FlSpot> _heartRateData = [];
  final List<FlSpot> _bpData = [];
  final List<FlSpot> _oxygenData = [];
  int _time = 0;

  @override
  void initState() {
    super.initState();
    _startVitalUpdates();
  }

  void _startVitalUpdates() {
    _vitalTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _time += 1;
        heartRate = 60 + (20 * (timer.tick % 2));
        bloodPressure = 110 + (10 * (timer.tick % 2));
        oxygenLevel = 96 + (4 * (timer.tick % 2));

        _heartRateData.add(FlSpot(_time.toDouble(), heartRate));
        _bpData.add(FlSpot(_time.toDouble(), bloodPressure));
        _oxygenData.add(FlSpot(_time.toDouble(), oxygenLevel));

        _checkHealthAlerts();
      });
    });
  }

  void _checkHealthAlerts() {
    if (heartRate < 50 || heartRate > 120) {
      _showMessage("⚠️ Alert", "Heart rate is abnormal: $heartRate BPM");
    }
    if (bloodPressure < 90 || bloodPressure > 140) {
      _showMessage("⚠️ Alert", "Blood Pressure is abnormal: $bloodPressure / 80");
    }
    if (oxygenLevel < 92) {
      _showMessage("⚠️ Alert", "Oxygen level is low: $oxygenLevel%");
    }
  }

  void _sendEmergencyAlert() {
    _showMessage("🚨 Emergency Alert Sent!", "Your emergency contacts have been notified.");
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
    _vitalTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Health Monitoring")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Vitals:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildVitalCard("Heart Rate", "$heartRate BPM", Colors.red),
            _buildVitalCard("Blood Pressure", "$bloodPressure / 80", Colors.blue),
            _buildVitalCard("Oxygen Level", "$oxygenLevel%", Colors.green),
            const SizedBox(height: 20),
            const Text("Health Trends:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 150,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    _buildLineChartBar(_heartRateData, Colors.red),
                    _buildLineChartBar(_bpData, Colors.blue),
                    _buildLineChartBar(_oxygenData, Colors.green),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendEmergencyAlert,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("🚨 Emergency SOS", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalCard(String title, String value, Color color) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.favorite, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }

  LineChartBarData _buildLineChartBar(List<FlSpot> data, Color color) {
    return LineChartBarData(
      spots: data,
      isCurved: true,
      color: color,
      barWidth: 3,
      belowBarData: BarAreaData(show: false),
    );
  }
}
