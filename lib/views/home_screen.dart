import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/routes.dart';
import '../providers/auth_provider.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, Routes.login);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Info Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text('Welcome, User!'),
                subtitle: Text('Stay safe and connected'),
              ),
            ),
            SizedBox(height: 20),

            // Grid Menu
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(context, 'Emergency SOS', LucideIcons.alertTriangle, Routes.sos),
                  _buildFeatureCard(context, 'Health Tracking', LucideIcons.heartPulse, Routes.health),
                  _buildFeatureCard(context, 'Financial Security', LucideIcons.wallet, Routes.finance),
                  _buildFeatureCard(context, 'Daily Assistance', LucideIcons.handHelping, Routes.assistance),
                  _buildFeatureCard(context, 'Next of Kin', LucideIcons.users, Routes.nextOfKin),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
