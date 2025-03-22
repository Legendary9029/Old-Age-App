class HealthModel {
  String userId;
  List<HealthRecord> healthRecords;
  List<Reminder> reminders;
  List<String> medications;
  List<String> allergies;
  DateTime lastUpdated;

  HealthModel({
    required this.userId,
    required this.healthRecords,
    required this.reminders,
    required this.medications,
    required this.allergies,
    required this.lastUpdated,
  });

  /// Converts the HealthModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'healthRecords': healthRecords.map((e) => e.toJson()).toList(),
      'reminders': reminders.map((r) => r.toJson()).toList(),
      'medications': medications,
      'allergies': allergies,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  /// Creates a HealthModel instance from a JSON object
  factory HealthModel.fromJson(Map<String, dynamic> json) {
    return HealthModel(
      userId: json['userId'],
      healthRecords: (json['healthRecords'] as List)
          .map((e) => HealthRecord.fromJson(e))
          .toList(),
      reminders: (json['reminders'] as List)
          .map((r) => Reminder.fromJson(r))
          .toList(),
      medications: List<String>.from(json['medications']),
      allergies: List<String>.from(json['allergies']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}

/// Represents a single health record entry
class HealthRecord {
  String id;
  String type;
  double value;
  DateTime date;

  HealthRecord({
    required this.id,
    required this.type,
    required this.value,
    required this.date,
  });

  /// Converts the HealthRecord instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'date': date.toIso8601String(),
    };
  }

  /// Creates a HealthRecord instance from a JSON object
  factory HealthRecord.fromJson(Map<String, dynamic> json) {
    return HealthRecord(
      id: json['id'],
      type: json['type'],
      value: json['value'],
      date: DateTime.parse(json['date']),
    );
  }
}

/// Represents a single reminder entry
class Reminder {
  String id;
  String message;
  DateTime time;

  Reminder({
    required this.id,
    required this.message,
    required this.time,
  });

  /// Converts the Reminder instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'time': time.toIso8601String(),
    };
  }

  /// Creates a Reminder instance from a JSON object
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      message: json['message'],
      time: DateTime.parse(json['time']),
    );
  }
}
