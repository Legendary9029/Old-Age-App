import 'package:flutter/material.dart';
import '../views/login_screen.dart';
import '../views/home_screen.dart';
import '../views/sos_screen.dart';
import '../views/next_of_kin_screen.dart';
import '../views/health_screen.dart';
import '../views/finance_screen.dart';
import '../views/assistance_screen.dart';
import '../views/profile_screen.dart';
import '../core/routes.dart'; // Import the routes file

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.sos:
        return MaterialPageRoute(builder: (_) => SOSScreen());
      case Routes.nextOfKin:
        return MaterialPageRoute(builder: (_) => const NextOfKinScreen());
      case Routes.health:
        return MaterialPageRoute(builder: (_) => const HealthScreen());
      case Routes.finance:
        return MaterialPageRoute(builder: (_) => const FinanceScreen());
      case Routes.assistance:
        return MaterialPageRoute(builder: (_) => const DailyAssistanceScreen());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
