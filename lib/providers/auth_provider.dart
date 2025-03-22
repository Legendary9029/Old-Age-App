import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  AuthProvider() {
    _loadUserSession();
  }

  Future<void> _loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userEmail = prefs.getString('userEmail');
    notifyListeners();
  }

  Future<void> login(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = true;
    _userEmail = email;
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = false;
    _userEmail = null;
    await prefs.remove('isLoggedIn');
    await prefs.remove('userEmail');
    notifyListeners();
  }
}
