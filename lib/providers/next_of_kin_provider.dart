import 'package:flutter/material.dart';
import '../models/next_of_kin_model.dart';
import '../services/next_of_kin_service.dart';

class NextOfKinProvider with ChangeNotifier {
  List<NextOfKin> _nextOfKinContacts = [];
  DateTime? _lastCheckIn;
  bool _isCheckedIn = false;

  List<NextOfKin> get nextOfKinContacts => _nextOfKinContacts;
  DateTime? get lastCheckIn => _lastCheckIn;
  bool get isCheckedIn => _isCheckedIn;

  Future<void> loadNextOfKin(String userId) async {
    _nextOfKinContacts = await NextOfKinService.getNextOfKinContacts(userId);
    notifyListeners();
  }

  Future<void> addNextOfKin(NextOfKin contact) async {
    await NextOfKinService.addNextOfKin(contact);
    _nextOfKinContacts.add(contact);
    notifyListeners();
  }

  Future<void> deleteNextOfKin(String contactId) async {
    await NextOfKinService.deleteNextOfKin(contactId);
    _nextOfKinContacts.removeWhere((c) => c.id == contactId);
    notifyListeners();
  }

  Future<void> checkIn() async {
    _isCheckedIn = true;
    _lastCheckIn = DateTime.now();
    await NextOfKinService.updateCheckInStatus(_lastCheckIn!);
    notifyListeners();
  }

  Future<void> scheduleCheckInReminder() async {
    if (!_isCheckedIn) {
      await NextOfKinService.sendCheckInReminder();
    }
  }
}
