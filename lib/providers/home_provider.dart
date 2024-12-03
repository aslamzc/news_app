import 'package:flutter/material.dart';
import 'package:news/controllers/home_controller.dart';
import 'package:news/models/user_model.dart';

class HomeProvider with ChangeNotifier {
  final HomeController _controller = HomeController();

  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _error;
  bool _isDarkTheme = false;

  //getters
  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isDarkTheme => _isDarkTheme;
  ThemeData get theme => _isDarkTheme ? ThemeData.dark() : ThemeData.light();

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await _controller.fetchUsers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
