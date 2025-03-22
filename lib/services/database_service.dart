import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save user data
  Future<void> saveUserData(String uid, Map<String, dynamic> userData) async {
    try {
      await _db.collection('users').doc(uid).set(userData, SetOptions(merge: true));
      debugPrint("✅ User data saved for UID: $uid");
    } catch (e) {
      debugPrint("🔥 Error saving user data: $e");
      throw Exception("Failed to save user data.");
    }
  }

  // Get user data
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (!doc.exists) {
        throw Exception("User data not found.");
      }
      return doc;
    } catch (e) {
      debugPrint("🔥 Error fetching user data: $e");
      throw Exception("Failed to retrieve user data.");
    }
  }

  // Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> updatedData) async {
    try {
      await _db.collection('users').doc(uid).update(updatedData);
      debugPrint("✅ User data updated for UID: $uid");
    } catch (e) {
      debugPrint("🔥 Error updating user data: $e");
      throw Exception("Failed to update user data.");
    }
  }

  // Delete user data
  Future<void> deleteUser(String uid) async {
    try {
      await _db.collection('users').doc(uid).delete();
      debugPrint("✅ User deleted: $uid");
    } catch (e) {
      debugPrint("🔥 Error deleting user: $e");
      throw Exception("Failed to delete user.");
    }
  }

  // 📌 EXPENSE MANAGEMENT 📌

  // Get all expenses
  Future<List<Map<String, dynamic>>> getExpenses(String uid) async {
    try {
      final snapshot = await _db.collection('users').doc(uid).collection('expenses').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint("🔥 Error fetching expenses: $e");
      throw Exception("Failed to fetch expenses.");
    }
  }

  // Get budget
  Future<double> getBudget(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists && doc.data()!.containsKey('budget')) {
        return doc.data()!['budget'] as double;
      } else {
        return 0.0; // Default budget
      }
    } catch (e) {
      debugPrint("🔥 Error fetching budget: $e");
      throw Exception("Failed to retrieve budget.");
    }
  }

  // Add expense
  Future<void> addExpense(String uid, Map<String, dynamic> expenseData) async {
    try {
      await _db.collection('users').doc(uid).collection('expenses').add(expenseData);
      debugPrint("✅ Expense added for UID: $uid");
    } catch (e) {
      debugPrint("🔥 Error adding expense: $e");
      throw Exception("Failed to add expense.");
    }
  }

  // Update budget
  Future<void> updateBudget(String uid, double newBudget) async {
    try {
      await _db.collection('users').doc(uid).update({'budget': newBudget});
      debugPrint("✅ Budget updated for UID: $uid");
    } catch (e) {
      debugPrint("🔥 Error updating budget: $e");
      throw Exception("Failed to update budget.");
    }
  }

  // Delete expense
  Future<void> deleteExpense(String uid, String expenseId) async {
    try {
      await _db.collection('users').doc(uid).collection('expenses').doc(expenseId).delete();
      debugPrint("✅ Expense deleted for UID: $uid, Expense ID: $expenseId");
    } catch (e) {
      debugPrint("🔥 Error deleting expense: $e");
      throw Exception("Failed to delete expense.");
    }
  }
}
