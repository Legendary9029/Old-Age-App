---

# 🏡 Old Age Care App

An all-in-one mobile app designed to help seniors manage their health, finances, and daily activities while staying connected with their loved ones.

---

## 🔹 Features

### 🩺 Health & Wellness  
✅ **Medication Reminders** – Get notifications to take pills on time.  
✅ **Doctor Appointments** – Schedule, get reminders, and do video consultations.  
✅ **Emergency SOS Button** – One-tap button to call family or emergency services.  
✅ **Vital Tracking** – Monitor blood pressure, sugar levels, heart rate, etc.  
✅ **Wearable Integration** – Sync with smartwatches like Fitbit or Apple Watch.  

### 🛠️ Accessibility & Usability  
✅ **Large Fonts & High Contrast Mode** – Enhanced readability for seniors.  
✅ **Voice Commands** – Control the app hands-free (Google Assistant, Siri).  
✅ **Simplified Navigation** – Big buttons and an easy-to-use interface.  
✅ **Hearing Aid Compatibility** – Support for Bluetooth hearing aids.  
✅ **Text-to-Speech & Speech-to-Text** – Assist users with vision or mobility issues.  

### 📞 Communication & Social  
✅ **Family Connect** – Video calls and messaging with loved ones.  
✅ **Community Groups** – Join interest-based groups (health, hobbies, etc.).  
✅ **Daily Motivation & Mental Well-Being** – Positive quotes, puzzles, meditation.  
✅ **Automated Check-ins** – Notify family members of daily activities.  

### 💰 Finance & Security  
✅ **Secure Digital Payments** – Easy banking and payment options.  
✅ **Fraud Alerts** – Detect and warn about suspicious activity.  
✅ **Password Manager** – Store and retrieve passwords securely.  
✅ **Voice Authentication** – Use biometrics for secure access.  

### 🏠 Daily Assistance  
✅ **Grocery & Essentials Ordering** – Order food, groceries, and medicines.  
✅ **Transportation Assistance** – Easily book cabs or request family pickups.  
✅ **Reminders & Calendar** – Manage daily tasks, bill payments, and events.  
✅ **News & Weather Updates** – Get local/global news with voice updates.  

---

## 📱 Tech Stack  

**🛠️ Backend:**  
- Firebase (Authentication, Database, Notifications)  
- Firestore for real-time updates  

**📱 Mobile App (Cross-Platform):**  
- **Flutter (Dart)** – Ensures a smooth UI & performance  

**🧑‍💻 State Management:**  
- Provider / Riverpod (for efficient state handling)  

**📢 Notifications:**  
- Firebase Cloud Messaging (FCM)  
- Local Notifications for reminders  

**🗺️ Location & Emergency Services:**  
- Google Maps API for tracking & navigation  
- Geolocation for emergency SOS  

---

## 📂 Project Structure  

```
old_age_care_app/
│-- android/                   # Android-specific files
│-- ios/                       # iOS-specific files
│-- lib/                       # Main Flutter code
│   ├── main.dart              # Entry point of the app
│   ├── core/                  # Core app utilities
│   │   ├── theme.dart         # App theme settings
│   │   ├── routes.dart        # Navigation routes
│   │   ├── constants.dart     # Constants used throughout the app
│   │   ├── utils.dart         # Helper functions
│   ├── models/                # Data models
│   │   ├── user_model.dart    # User data model
│   │   ├── health_model.dart  # Health tracking data model
│   │   ├── finance_model.dart # Finance tracking data model
│   │   ├── sos_model.dart     # SOS request data model
│   │   ├── next_of_kin_model.dart # Next of Kin model (contact & check-in data)
│   ├── providers/             # State management
│   │   ├── auth_provider.dart # Authentication provider
│   │   ├── health_provider.dart # Health data management
│   │   ├── finance_provider.dart # Finance data management
│   │   ├── sos_provider.dart  # SOS feature logic
│   │   ├── next_of_kin_provider.dart # Next of Kin check-in management
│   ├── services/              # Backend services
│   │   ├── auth_service.dart  # Handles authentication
│   │   ├── database_service.dart # Firebase/Database interaction
│   │   ├── sos_service.dart   # SOS handling & location tracking
│   │   ├── notification_service.dart # Push notifications
│   │   ├── next_of_kin_service.dart # Automates check-ins & alerts
│   ├── views/                 # UI Screens
│   │   ├── home_screen.dart   # Home screen
│   │   ├── login_screen.dart  # Login & Registration screen
│   │   ├── profile_screen.dart # User profile
│   │   ├── health_screen.dart # Health tracking
│   │   ├── finance_screen.dart # Financial security tools
│   │   ├── sos_screen.dart    # Emergency SOS
│   │   ├── assistance_screen.dart # Daily assistance tools
│   │   ├── next_of_kin_screen.dart # Manage Next of Kin contacts
│   │   ├── next_of_kin_checkin_screen.dart # Daily check-in system
│   ├── widgets/               # Reusable UI components
│   │   ├── custom_button.dart # Custom buttons
│   │   ├── health_card.dart   # Health data display
│   │   ├── sos_alert.dart     # SOS alert UI
│   │   ├── finance_widget.dart # Finance data widget
│   │   ├── checkin_widget.dart # Next of Kin check-in button
│-- pubspec.yaml               # Dependencies & assets
│-- assets/                    # Images, fonts, and sounds
│-- README.md                  # Project description
```

---

## 🔥 Development Best Practices  

✅ **Focus on Simplicity** – Simple UI, big buttons, easy-to-read text.  
✅ **Test with Elders** – Gather real feedback on usability.  
✅ **Offline Mode** – Allow access to vital features without the internet.  
✅ **Emergency Contact on Home Screen** – Quick access for emergencies.  
✅ **Voice & Gesture Control** – Enhance usability for users with limited dexterity.  
✅ **Avoid Ads & Complex Sign-Ups** – Keep the experience frustration-free.  

---

## 🚀 How to Run the Project  

1️⃣ **Clone the Repository**  
```bash
git clone https://github.com/yourusername/old_age_care_app.git
cd old_age_care_app
```

2️⃣ **Install Dependencies**  
```bash
flutter pub get
```

3️⃣ **Run on Emulator/Device**  
```bash
flutter run
```

---

## 🤝 Contributing  

We welcome contributions! If you find a bug or have suggestions, feel free to open an issue or submit a pull request.  

---

## 📜 License  

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.  

---
