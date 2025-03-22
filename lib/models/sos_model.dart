class SOSRequest {
  String userId;
  String emergencyType;
  double latitude;
  double longitude;
  DateTime timestamp;
  String status; // "Pending", "Responding", "Resolved"
  String? responderId;

  SOSRequest({
    required this.userId,
    required this.emergencyType,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.status,
    this.responderId,
  });

  /// Converts the SOSRequest instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'emergencyType': emergencyType,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'responderId': responderId,
    };
  }

  /// Creates an SOSRequest instance from a JSON object
  factory SOSRequest.fromJson(Map<String, dynamic> json) {
    return SOSRequest(
      userId: json['userId'],
      emergencyType: json['emergencyType'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
      responderId: json['responderId'],
    );
  }
}
