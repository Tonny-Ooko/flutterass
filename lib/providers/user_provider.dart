import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<User> _users = [];

  List<User> get users => _users;

  Future<void> loadUsers(BuildContext context) async {
    if (_users.isNotEmpty) {
      print('Users already loaded, skipping fetch.');
      return;
    }

    try {
      print(' Fetching Users...');
      _users = await _apiService.fetchUsers();
      print(' Users Fetched: ${_users.map((u) => u.name).toList()}');
      notifyListeners();
    } catch (e) {
      print(' Error loading users: $e');
      _showErrorDialog(context, 'Failed to load users. Please check your internet connection.');
    }
  }

  Future<void> updateUser(BuildContext context, User user) async {
    try {
      print(' Updating User: ${user.name}');

      int userId = int.tryParse(user.id) ?? -1;
      if (userId == -1) {
        throw Exception("Invalid user ID: ${user.id}");
      }

      await _apiService.updateUser(userId, user);
      print(' User Updated: ${user.name}');

      _users = await _apiService.fetchUsers();
      notifyListeners();

      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error updating user: $e');
      _showErrorDialog(context, 'Failed to update user. Please try again.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}
