import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

class UserProvider extends ChangeNotifier {
  final GetUsers getUsersUsecase;
  final List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = false;
  String? _error;

  // Expose users as List<User>
  List<User> get users => _filteredUsers.isEmpty ? _users : _filteredUsers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  UserProvider({required this.getUsersUsecase});

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final apiUsers = await getUsersUsecase();
      _users.clear();
      _users.addAll(apiUsers);
      _filteredUsers = [];
      _error = null;
    } catch (e) {
      _error = "Error fetching users. Check your internet connection.";
    }
    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredUsers = [];
    } else {
      _filteredUsers = _users
          .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void addUser(User user) {
    _users.add(user); 
    notifyListeners();
  }
}
