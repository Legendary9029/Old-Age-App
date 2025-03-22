import 'package:flutter/material.dart';
import '../models/health_model.dart';
import '../services/database_service.dart';

class HealthProvider with ChangeNotifier {
  List<HealthRecord> _healthRecords = [];
  List<Reminder> _reminders = [];

  List<HealthRecord> get healthRecords => _healthRecords;
  List<Reminder> get reminders => _reminders;

  Future<void> fetchHealthData(String userId) async {
    _healthRecords = await DatabaseService.getHealthRecords(userId);
    _reminders = await DatabaseService.getReminders(userId);
    notifyListeners();
  }

  Future<void> addHealthRecord(HealthRecord record) async {
    await DatabaseService.addHealthRecord(record);
    _healthRecords.add(record);
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    await DatabaseService.addReminder(reminder);
    _reminders.add(reminder);
    notifyListeners();
  }

  Future<void> deleteReminder(String reminderId) async {
    await DatabaseService.deleteReminder(reminderId);
    _reminders.removeWhere((r) => r.id == reminderId);
    notifyListeners();
  }
}
