import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/next_of_kin.dart';
import '../providers/next_of_kin_provider.dart';
import '../services/notification_service.dart';

class NextOfKinService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final NextOfKinProvider _nextOfKinProvider;
  final NotificationService _notificationService;
  Timer? _checkInTimer;
  final Duration checkInInterval = const Duration(hours: 12);

  NextOfKinService(this._nextOfKinProvider, this._notificationService);

  /// Fetch next of kin contacts from Firestore
  Future<List<NextOfKin>> getNextOfKinContacts(String userId) async {
    try {
      QuerySnapshot snapshot =
      await _db.collection('users').doc(userId).collection('next_of_kin').get();

      return snapshot.docs.map((doc) => NextOfKin.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error fetching next of kin contacts: $e");
      return [];
    }
  }

  /// Add a next of kin contact to Firestore
  Future<void> addNextOfKin(String userId, NextOfKin contact) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('next_of_kin')
          .doc(contact.id)
          .set(contact.toJson());
    } catch (e) {
      print("Error adding next of kin: $e");
    }
  }

  /// Delete a next of kin contact from Firestore
  Future<void> deleteNextOfKin(String userId, String contactId) async {
    try {
      await _db.collection('users').doc(userId).collection('next_of_kin').doc(contactId).delete();
    } catch (e) {
      print("Error deleting next of kin: $e");
    }
  }

  /// Start a check-in timer to remind the user every 12 hours
  void startCheckInTimer() {
    _checkInTimer?.cancel(); // Cancel any existing timer
    _checkInTimer = Timer(checkInInterval, _handleMissedCheckIn);
    _notificationService.scheduleDailyCheckInReminder();
  }

  /// Confirm a check-in and reset the timer
  void confirmCheckIn() {
    _nextOfKinProvider.updateLastCheckIn();
    _checkInTimer?.cancel(); // Stop the timer upon check-in
  }

  /// Handle cases where the user misses a check-in
  void _handleMissedCheckIn() {
    if (!_nextOfKinProvider.hasCheckedInRecently(checkInInterval)) {
      _sendEmergencyAlert();
    }
  }

  /// Send an emergency alert notification
  void _sendEmergencyAlert() {
    _notificationService.showNotification(
      "🚨 Emergency Alert",
      "No check-in received! Alerting Next of Kin.",
    );
  }
}
