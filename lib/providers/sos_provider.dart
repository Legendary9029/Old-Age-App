import 'package:flutter/material.dart';
import '../models/sos_model.dart';
import '../services/sos_service.dart';

class SOSProvider with ChangeNotifier {
  SOSRequest? _currentSOS;
  bool _isSending = false;

  SOSRequest? get currentSOS => _currentSOS;
  bool get isSending => _isSending;

  Future<void> sendSOS(String userId, String userName, double lat, double lon, String emergencyType, List<String> contacts) async {
    _isSending = true;
    notifyListeners();

    try {
      _currentSOS = SOSRequest(
        userId: userId,
        userName: userName,
        latitude: lat,
        longitude: lon,
        timestamp: DateTime.now(),
        emergencyType: emergencyType,
        emergencyContacts: contacts,
        resolved: false,
      );

      await SOSService.sendSOS(_currentSOS!);
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }

  void markSOSResolved() {
    if (_currentSOS != null) {
      _currentSOS!.resolved = true;
      notifyListeners();
    }
  }
}
