import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = "Old Age Care App";
  static const String appVersion = "1.0.0";

  // API Endpoints (Replace with actual API URLs)
  static const String apiBaseUrl = "https://your-api.com";
  static const String authEndpoint = "$apiBaseUrl/auth";
  static const String sosEndpoint = "$apiBaseUrl/sos";
  static const String healthEndpoint = "$apiBaseUrl/health";
  static const String financeEndpoint = "$apiBaseUrl/finance";
  static const String nextOfKinEndpoint = "$apiBaseUrl/next-of-kin";

  // Default Values
  static const Duration checkInReminderInterval = Duration(hours: 12);
  static const String defaultCurrency = "USD";

  // Notification Channel IDs
  static const String sosNotificationChannel = "sos_alerts";
  static const String checkInNotificationChannel = "check_in_reminders";

  // Predefined Messages
  static const String checkInReminderMessage = "Please confirm your well-being.";
  static const String emergencyAlertMessage = "🚨 No response! Alert sent to Next of Kin.";

  // UI Colors
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.orange;
}
