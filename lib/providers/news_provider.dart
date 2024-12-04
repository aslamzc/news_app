import 'package:flutter/material.dart';
import 'package:news/controllers/home_controller.dart';
import 'package:news/models/news.dart';

class NewsProvider with ChangeNotifier {
  final HomeController _controller = HomeController();

  List<News> _news = [];
  bool _isLoading = false;
  String? _error;

  List<News> get news => _news;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchNews() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _news = await _controller.fetchNews();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
