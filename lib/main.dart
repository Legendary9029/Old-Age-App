import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes.dart';
import 'core/theme.dart';
import 'providers/auth_provider.dart';
import 'providers/health_provider.dart';
import 'providers/sos_provider.dart';
import 'providers/finance_provider.dart';
import 'core/app_routes.dart';
//import 'services/firebase_service.dart'; // If Firebase is used

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await FirebaseService.initialize(); // If using Firebase
  runApp(const OldAgeCareApp());
}

class OldAgeCareApp extends StatelessWidget {
  const OldAgeCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HealthProvider()),
        ChangeNotifierProvider(create: (_) => SOSProvider()),
        ChangeNotifierProvider(create: (_) => FinanceProvider()),
      ],
      child: MaterialApp(
        title: 'Old Age Care App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/login', // Explicitly set
        onGenerateRoute: AppRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
