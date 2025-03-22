import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class SOSService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Send an SOS alert
  Future<void> sendSOSAlert(String userId, List<String> emergencyContacts) async {
    try {
      Position position = await _getCurrentLocation();

      Map<String, dynamic> sosData = {
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
        'location': {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
        'contactsNotified': emergencyContacts,
      };

      await _db.collection('sos_alerts').add(sosData);
    } catch (e) {
      print("Error sending SOS alert: $e");
    }
  }

  // Get the current location
  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  // Fetch recent SOS alerts for a user
  Future<QuerySnapshot<Map<String, dynamic>>> getRecentSOSAlerts(String userId) async {
    try {
      return await _db
          .collection('sos_alerts')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(5)
          .get();
    } catch (e) {
      print("Error fetching SOS alerts: $e");
      rethrow;
    }
  }
}
